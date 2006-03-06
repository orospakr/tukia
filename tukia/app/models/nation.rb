class Nation < ActiveRecord::Base
  translates :name
  belongs_to :globalize_country
  has_and_belongs_to_many :committees, :class_name => "Committee"
  validates_presence_of :name
  validates_presence_of :globalize_country_id
  has_many :person
end
