class Report < ActiveRecord::Base
  # :template defines which report action should be used on the Reports controller.  Perhaps not
  # the most elegant method of introspection, but by far the simplest.
  
  # All the projects to include in this report.
  has_and_belongs_to_many :projects, :join_table => "projects_reports"
end
