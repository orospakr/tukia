class Committee < ActiveRecord::Base
  acts_as_tree
  has_and_belongs_to_many :editors, :class_name => "Person", :join_table => "committees_editors"
  has_and_belongs_to_many :members, :class_name => "Nation"
  has_and_belongs_to_many :convenors, :class_name => "Person", :join_table => "committees_convenors"
  has_many :document
  attr_protected :created_at, :updated_at
  validates_presence_of :name

  def get_full_name
    ffff
  end
end
