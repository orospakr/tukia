class Term < ActiveRecord::Base
  acts_as_tree
  # source authority
  belongs_to :document
  belongs_to :gender
  belongs_to :globalize_language
  belongs_to :globalize_country
  has_and_belongs_to_many :document
  # not for policy, just a submitted-by field for reference purposes
  belongs_to :person
  belongs_to :synonmic
  validates_presence_of :term
  validates_presence_of :definition
  validates_presence_of :copyright
  validates_presence_of :licence
  validates_presence_of :person_id
  validates_presence_of :created
  validates_presence_of :document_id
  validates_presence_of :document_section
  validates_presence_of :synonmic_id
end
