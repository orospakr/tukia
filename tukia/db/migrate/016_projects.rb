class Projects < ActiveRecord::Migration
  def self.up
    create_table :projects do |table|
      table.column :title, :string
      table.column :referenceid, :string
      table.column :bodyissuedinternalid, :string
     
      table.column :committee_id, :integer

      table.column :status_id, :integer
      table.column :statusiteration, :integer
      
      table.column :created_at, :datetime
      table.column :updated_at, :datetime
      
      table.column :published_on, :date
      table.column :edition, :integer
      
      table.column :licence, :text
      table.column :copyright, :string
      table.column :isbn, :string
      table.column :issn, :string
      
      table.column :externalbody, :string
      table.column :externalurl, :string
      
      table.column :do_not_show_committee_in_report, :boolean
    end
  end

  def self.down
    drop_table :projects
  end
end
