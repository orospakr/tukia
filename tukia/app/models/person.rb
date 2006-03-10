class Person < ActiveRecord::Base
  has_and_belongs_to_many :editorof, :class_name => "Committee", :join_table => "committees_editors"
  has_and_belongs_to_many :convenorof, :class_name => "Committee", :join_table => "committees_convenors"
  has_many :document
  composed_of :tz, :class_name => 'TZInfo::Timezone', :mapping => %w(time_zone time_zone)
# again, just a submitted-by field for reference, not policy
  has_many :term
  belongs_to :nation
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :givenname
  validates_presence_of :surname
  validates_presence_of :password
  validates_presence_of :email
  validates_presence_of :nation_id
  attr_protected :created_at, :updated_at
  validates_presence_of :time_zone
end
