class Nation < ActiveRecord::Base
  translates :name
  belongs_to :country, :class_name => "Globalize::Country"
  belongs_to :committee
  has_and_belongs_to_many :people
  validates_presence_of :name
  validates_presence_of :country_id
  validates_presence_of :committee_id
  validates_presence_of :participation_level
  attr_protected :created_at, :updated_at
end
