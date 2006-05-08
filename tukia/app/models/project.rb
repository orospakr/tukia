class Project < ActiveRecord::Base
  # documents created by committees that pertain to this standard/project. things like CDs, WDs, FCDs, etc.
  has_many :documents
  
  belongs_to :committee
  
  attr_protected :created_at, :updated_at
  
  def get_full_name
    @committee.get_full_name + " " + @title + "-" + @part
  end
end
