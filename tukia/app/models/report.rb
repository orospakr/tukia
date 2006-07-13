class Report < ActiveRecord::Base
  # :template defines which report action should be used on the Reports controller.  Perhaps not
  # the most elegant method of introspection, but by far the simplest.
  
  # All the projects to include in this report.
  has_and_belongs_to_many :projects, :join_table => "projects_reports"
  
  validates_presence_of :name
  validates_presence_of :template
  
  @@find_all_no_synonmics_query = <<EOQ
SELECT * FROM terms WHERE
(
  (
    id IN
    (
      SELECT term_id FROM usages WHERE project_id IN
      (
        SELECT id FROM projects WHERE id IN
        (
          SELECT project_id FROM projects_reports WHERE report_id = ?
        )
      )
    )
  ) OR
  (
    project_id IN
    (
      SELECT id FROM projects WHERE id IN
      (
        SELECT project_id FROM projects_reports WHERE report_id = ?
      )
    )
  )
) ORDER BY UPPER( REPLACE (term, '(', '0' ));
EOQ

  @@find_all_with_synonmics_query = <<EOQ
SELECT * FROM terms WHERE 
(
  id IN
  (
    SELECT id FROM terms WHERE synonmic_id IN
    (
      SELECT synonmic_id FROM terms WHERE
      (
        id IN
        (
          SELECT term_id FROM usages WHERE project_id IN
          (
            SELECT id FROM projects WHERE id IN
            (
              SELECT project_id FROM projects_reports WHERE report_id = ?
            )
          )
        )
      ) OR
      (
        project_id IN
        (
          SELECT id FROM projects WHERE id IN
          (
            SELECT project_id FROM projects_reports WHERE report_id = ?
          )
        )
      )
    ) AND language_id = ?
  )
) ORDER BY UPPER( REPLACE (term, '(', '0' ));
EOQ
  
  def before_save
    if ( projects.count < 1)
      errors.add("projects", "list must have at least one project selected.")
      return false
    end
    true
  end
  
  # find all the terms associated with all of the reports in this term.
  # uses the RDBMS directly instead of the AR polymorphic associations, for perf. reasons
  def all_terms()
    Term.find_by_sql([@@find_all_no_synonmics_query, self.id, self.id])
  end
  
  def all_terms_synonyms(language)
    Term.find_by_sql([@@find_all_with_synonmics_query, self.id, self.id, language.id])
  end
  
  # returns true if the term's source authority is any of the projects in this report.
  def term_sourced_from_any_project(term)
    for p in self.projects
      if (term.project == p)
        return true
      end
    end
    false
  end
end
