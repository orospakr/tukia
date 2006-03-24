require_dependency "globalize_language"

class Document < ActiveRecord::Base
  belongs_to :status
  
  # the languages of this document.
  has_and_belongs_to_many :languages, :class_name => "Globalize::Language"
  
  # term usages
  has_and_belongs_to_many :term
  
  # this document is the source authority for...
  has_many :terms
  
  # creator, for informative purposes, not security policy
  belongs_to :person
  validates_presence_of :person_id
  
  # owning committee, used for security policy
  belongs_to :committee
  validates_presence_of :committee_id
  
  def upload=(upload_field)
    #self.name = base_part_of(picture_field.original_filename)
    #self.content_type = picture_field.content_type.chomp
    self.file = upload_field.read
    self.extension = File.extname(upload_field.original_filename)
  end
  
  
  attr_protected :created_at, :updated_at
  
  validates_presence_of :title
  validates_presence_of :register_number
  validates_presence_of :status_id
  validates_presence_of :statusiteration
  validates_presence_of :external
 
end
