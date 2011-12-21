class Gender < ActiveRecord::Base
  belongs_to :language, :class_name => "Globalize::Language"
  translates :name
  has_many :terms, :dependent => :destroy
  validates_presence_of :name
  validates_presence_of :code
  
  # gah! hardcoded for English! yuck!
  def get_full_name
    self.language.english_name + " " + self.name + " (" + self.code.to_s + ")"
  end
end
