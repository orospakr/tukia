class Term < ActiveRecord::Base
  acts_as_tree
  
  # source authority
  belongs_to :project
  
  belongs_to :gender
  belongs_to :language, :class_name => "Globalize::Language"
  
  has_many :usages
  has_many :projects, :through => :usages
  
  # not for policy, just a submitted-by field for reference purposes
  belongs_to :person
  belongs_to :synonmic
  attr_protected :created_at, :updated_at
  validates_presence_of :term
  validates_presence_of :definition
  validates_presence_of :person_id
  #validates_presence_of :created_at
  validates_presence_of :synonmic
  validates_presence_of :language_id
  
  # returns all synonyms and translations of this term by looking up all other terms
  # in the same synonmic group.
  def synonyms
    Term.find(:all, :conditions => ["synonmic_id = ? AND id != ?", self.synonmic_id, self.id], :order => "term ASC")
  end
end
