class Terms < ActiveRecord::Migration
  def self.up
    create_table :terms do |table|
      table_column :globalize_language_id, :integer
      table_column :globalize_country_id, :integer
      table_column :term, :string
      table_column :definition, :text
      table_column :gender_id, :integer
      table_column :copyright, :string
      table_column :licence, :string
      table_column :person_id, :integer
      table_column :created, :date
      table_column :deleted, :boolean
      table_column :comments, :text
      table_column :document_id, :integer
      table_column :document_section, :string
      table_column :synonmic_id, :integer
      table_column :parent_id, :integer
  end

  def self.down
    drop_table :terms
  end
end
