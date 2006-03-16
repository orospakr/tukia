class Nation < ActiveRecord::Base
  translates :name
  belongs_to :globalize_country
  belongs_to :committee
  has_and_belongs_to_many :people
  validates_presence_of :name
  validates_presence_of :globalize_country_id
  validates_presence_of :committee_id
  attr_protected :created_at, :updated_at
end
