class Person < ActiveRecord::Base
  has_and_belongs_to_many :editorof, :class_name => "Committee", :join_table => "committees_editors"
  has_and_belongs_to_many :convenorof, :class_name => "Committee", :join_table => "committees_convenors"
  has_many :document
# again, just a submitted-by field for reference, not policy
  has_many :term
  belongs_to :nation
  validates_presence_of :name
  validates_presence_of :givenname
  validates_presence_of :surname
  validates_presence_of :password
  validates_presence_of :email
  validates_presence_of :created
  #validates_presence_of :lastlogin
  validates_presence_of :nation_id
end
