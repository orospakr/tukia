class Term < ActiveRecord::Base
  acts_as_tree
  
  # source authority
  belongs_to :project
  
  belongs_to :gender
  belongs_to :language, :class_name => "Globalize::Language"
  
  #has_many :usages
  #has_many :projects, :through => :usages
  has_and_belongs_to_many :projects, :join_table => "usages"
  
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
  
  def before_validation
    projects.each { |item|
      if (item.id == project.id)
        errors.add("Used In:".t, "may not contain the Source Authority.".t)
        return false
      end
    }
    return true
  end
  
  def setup_from_parent(parent)
    self.parent = parent
    self.project = parent.project
    self.gender = parent.gender
    self.language = parent.language
    self.term = parent.term
    self.definition = parent.definition
    # should derived terms be in the synonmic by default?
    self.synonmic = parent.synonmic
    self.comments = parent.comments
  end
  
  # returns all synonyms and translations of this term by looking up all other terms
  # in the same synonmic group.
  def synonyms
    Term.find(:all, :conditions => ["synonmic_id = ? AND id != ?", self.synonmic_id, self.id], :order => "term ASC")
  end
end
