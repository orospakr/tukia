require_dependency "language"

class Document < ActiveRecord::Base
  # the languages of this document.
  has_and_belongs_to_many :languages, :class_name => "Globalize::Language"
  
  # this document is the source authority for...
  has_many :terms, :through => :usages
  
  # creator, for informative purposes, not security policy
  belongs_to :person
  validates_presence_of :person_id
  
  # project this document pertains to, if any
  belongs_to :project
  
  # owning committee, used for security policy
  belongs_to :committee
  validates_presence_of :committee_id
  
  def upload=(upload_field)
    #self.name = base_part_of(picture_field.original_filename)
    #self.content_type = picture_field.content_type.chomp
    return if (upload_field.length <= 0)
    self.file = upload_field.read
    self.extension = File.extname(upload_field.original_filename)
  end
  
  def pdfupload=(upload_field)
    #self.name = base_part_of(picture_field.original_filename)
    #self.content_type = picture_field.content_type.chomp
    return if (upload_field.length <= 0)
    self.pdffile = upload_field.read
  end
  
  def get_full_name
    self.committee.get_full_name + self.title
  end

  attr_protected :created_at, :updated_at, :extension
  
  validates_presence_of :title
  validates_presence_of :register_number
  validates_presence_of :file
  validates_presence_of :copyright
  validates_presence_of :licence
end
 