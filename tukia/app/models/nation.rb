class Nation < ActiveRecord::Base
  @@participation_levels = [["Liason", 0], ["Observer", 1], ["Participant", 2]]
  def self.participation_levels
     return @@participation_levels
  end
  translates :name
  belongs_to :country, :class_name => "Globalize::Country"
  belongs_to :committee
  has_and_belongs_to_many :people, :class_name => "Person"
  validates_presence_of :name
  validates_presence_of :country_id
  validates_presence_of :committee_id
  validates_presence_of :participation_level
  attr_protected :created_at, :updated_at
  
  def self.testcaselol
    mynation = Nation.new
    mynation.name = "Asshatasdtdasfsfgggg"
    mynation.committee_id = Committee.find(2)
    mynation.participation_level = 1
    mynation.country = Globalize::Country.find(1)
    mynation.people << Person.find(1)
    mynation.people << Person.find(2)
    mynation.people << Person.find(4)
    mynation.save!
  end
end
