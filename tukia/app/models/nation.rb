class Nation < ActiveRecord::Base
  translates :name
  belongs_to :globalize_country
  belongs_to :committee
  validates_presence_of :name
  validates_presence_of :globalize_country_id
  validates_presence_of :committee_id
  has_many :person
  attr_protected :created_at, :updated_at
end
