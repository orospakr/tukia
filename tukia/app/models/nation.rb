class Nation < ActiveRecord::Base
  translates :name
  has_and_belongs_to_many :committees, :class_name => "Committee"
  validates_presence_of :name
  validates_presence_of :code
  has_many :person
end
