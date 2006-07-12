class Report < ActiveRecord::Base
  # :template defines which report action should be used on the Reports controller.  Perhaps not
  # the most elegant method of introspection, but by far the simplest.
  
  # All the projects to include in this report.
  has_and_belongs_to_many :projects, :join_table => "projects_reports"
  
  validates_presence_of :name
  validates_presence_of :template
  
  def before_save
    if ( projects.count < 1)
      errors.add("projects", "list must have at least one project selected.")
      return false
    end
    true
  end
  
  # find all the terms associated with all of the reports in this term.
  # uses the RDBMS directly instead of the AR polymorphic associations, for perf. reasons
  def all_terms(sorted_on)
    project_id_array = []
    for p in projects
      
    end
    Term.find(:all, :conditions => ["(project_id == ? OR )AND ", 454356], :order => ["? DESC",sorted_on], :joins => "")
  end
end
