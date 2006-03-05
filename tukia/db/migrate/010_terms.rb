class Terms < ActiveRecord::Migration
  def self.up
    create_table :terms do |table|
      table.column :globalize_language_id, :integer
      table.column :globalize_country_id, :integer
      table.column :term, :string
      table.column :definition, :text
      table.column :gender_id, :integer
      table.column :copyright, :string
      table.column :licence, :string
      table.column :person_id, :integer
      table.column :created_at, :date
      table.column :deleted, :boolean
      table.column :comments, :text
      table.column :document_id, :integer
      table.column :document_section, :string
      table.column :synonmic_id, :integer
      table.column :parent_id, :integer
    end
  end

  def self.down
    drop_table :terms
  end
end
