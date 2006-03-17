class Person < ActiveRecord::Base
  has_and_belongs_to_many :editorof, :class_name => "Committee", :join_table => "committees_editors"
  has_and_belongs_to_many :convenorof, :class_name => "Committee", :join_table => "committees_convenors"
  has_many :documents
  belongs_to :language, :class_name => "Globalize::Language"
  composed_of :tz, :class_name => 'TZInfo::Timezone', :mapping => %w(time_zone time_zone)
# again, just a submitted-by field for reference, not policy
  has_many :terms
  has_and_belongs_to_many :nations
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :givenname
  validates_presence_of :surname
  validates_presence_of :password
  validates_presence_of :email
  attr_protected :created_at, :updated_at
  validates_presence_of :time_zone
  
  
    # Please change the salt to something else, 
  # Every application should use a different one 
  @@salt = 'weenis'
  cattr_accessor :salt

  # Authenticate a user. 
  #
  # Example:
  #   @user = User.authenticate('bob', 'bobpass')
  #
  def self.authenticate(login, pass)
    find_first(["name = ? AND password = ?", login, sha1(pass)])
  end  
  

  protected

  # Apply SHA1 encryption to the supplied password. 
  # We will additionally surround the password with a salt 
  # for additional security. 
  def self.sha1(pass)
    Digest::SHA1.hexdigest("#{salt}--#{pass}--")
  end
  
    before_create :crypt_password
  
  # Before saving the record to database we will crypt the password 
  # using SHA1. 
  # We never store the actual password in the DB.
  def crypt_password
    write_attribute "password", self.class.sha1(password)
  end
  
  before_update :crypt_unless_empty
  
  # If the record is updated we will check if the password is empty.
  # If its empty we assume that the user didn't want to change his
  # password and just reset it to the old value.
  def crypt_unless_empty
    if password.empty?      
      user = self.class.find(self.id)
      self.password = user.password
    else
      write_attribute "password", self.class.sha1(password)
    end        
  end  
  
  validates_uniqueness_of :name, :on => :create

  validates_confirmation_of :password
  validates_length_of :name, :within => 3..40
  validates_length_of :password, :within => 5..40
  validates_presence_of :password_confirmation
  
end
