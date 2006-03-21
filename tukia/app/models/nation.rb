class Nation < ActiveRecord::Base
  @@participation_levels = [["Liason", 0], ["Observer", 1], ["Participant", 2]]
  def self.participation_levels
     return @@participation_levels
  end
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
