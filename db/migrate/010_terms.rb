class Terms < ActiveRecord::Migration
  def self.up
    create_table :terms do |table|
      table.column :language_id, :integer
      #table.column :globalize_country_id, :integer
      table.column :term, :string
      table.column :definition, :text
      table.column :acronym, :text
      table.column :facet, :text
      table.column :gender_id, :integer
      table.column :person_id, :integer
      table.column :created_at, :datetime
      table.column :updated_at, :datetime
      table.column :deleted, :boolean
      table.column :comments, :text
      table.column :project_id, :integer
      table.column :synonmic_id, :integer
      table.column :parent_id, :integer
      table.column :source_section, :string
    end
  end

  def self.down
    drop_table :terms
  end
end
