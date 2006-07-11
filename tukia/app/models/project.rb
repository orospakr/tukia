class Project < ActiveRecord::Base
  belongs_to :status
 
  # "n-" documents created by committees that pertain to this standard/project. things like CDs, WDs, FCDs, etc.
  has_many :documents, :dependent => :destroy
  
  belongs_to :committee
  
  # term usages
  has_many :usages
  has_many :terms, :through => :usages, :dependent => :destroy
  
  # source authorities.
  has_many :authorityof, :class_name => "Term"

  # has_and_belongs_to_many :terms
  #has_many :usages, :dependent => true
  #has_one :term, :dependent => :destroy # kill all terms that are sourced from this project
  # if it is nuked.
  
  attr_protected :created_at, :updated_at
  
  validates_presence_of :title
  validates_presence_of :referenceid
  
  def get_full_name
    committee.get_full_name + " " + self.referenceid + " " + self.title
  end
end
