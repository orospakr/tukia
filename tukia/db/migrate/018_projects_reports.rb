class ProjectsReports < ActiveRecord::Migration
  def self.up
    create_table :projects_reports, :id => false, :primary_key => false do |table|
      table.column :project_id, :integer, :null => false
      table.column :report_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :projects_reports
  end
end
