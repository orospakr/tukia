class Project < ActiveRecord::Base
  belongs_to :status
  
  # "n-" documents created by committees that pertain to this standard/project. things like CDs, WDs, FCDs, etc.
  has_many :documents, :dependent => :destroy
  
  belongs_to :committee
  
  # term usages
  has_many :usages
  has_many :terms, :through => :usages, :dependent => :destroy, :order => "term ASC"
  
  # source authorities.
  has_many :authorityof, :class_name => "Term", :order => "term ASC"
  
  # has_and_belongs_to_many :terms
  #has_many :usages, :dependent => true
  #has_one :term, :dependent => :destroy # kill all terms that are sourced from this project
  # if it is nuked.
  
  attr_protected :created_at, :updated_at
  
  validates_presence_of :title
  validates_presence_of :referenceid
  validates_presence_of :committee_id
  validates_presence_of :published_on
  
  def get_full_name
    if !self.do_not_show_committee_in_report
      committee.get_full_name + " " + self.referenceid + ":" + self.published_on.year.to_s
    else
      self.referenceid + ":" + self.published_on.year.to_s
    end
  end
  
  def get_full_name_with_title
    if !self.do_not_show_committee_in_report
      committee.get_full_name + " " + self.referenceid + ":" + self.published_on.year.to_s + " " + self.title
    else
      self.referenceid + ":" + self.published_on.year.to_s + " " + self.title
    end
  end
end
