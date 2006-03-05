class Document < ActiveRecord::Base
  belongs_to :status
  belongs_to :globalize_language
  has_and_belongs_to_many :term
  has_many :term
  belongs_to :person
  belongs_to :committee
  validates_presence_of :person_id
  validates_presence_of :title
  validates_presence_of :committee_id
  validates_presence_of :register_number
  validates_presence_of :status_id
  validates_presence_of :statusiteration
  validates_presence_of :modified
  validates_presence_of :external
  validates_presence_of :globalize_language_id
end
