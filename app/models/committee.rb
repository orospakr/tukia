class Committee < ActiveRecord::Base
  acts_as_tree
  has_and_belongs_to_many :editor, :class_name => "Person"
  has_and_belongs_to_many :members, :class_name => "Nation"
  has_and_belongs_to_many :convenors, :class_name => "Person"
end
