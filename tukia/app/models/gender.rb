class Gender < ActiveRecord::Base
  belongs_to :language, :class_name => "Globalize::Language"
  translates :name
  has_many :terms
  validates_presence_of :name
  validates_presence_of :code
end
