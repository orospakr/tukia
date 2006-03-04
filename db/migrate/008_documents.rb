class Documents < ActiveRecord::Migration
  def self.up
    create_table :documents do |table|
      table.column :authorexternal, :string
      table.column :person_id, :integer
      table.column :title, :string
      table.column :committee_id, :integer
      table.column :register_number, :integer
      table.column :externalurl, :string
      table.column :externalfullname, :string
      table.column :status_id, :integer
      table.column :statusiteration, :integer
      table.column :modified, :date
      table.column :published, :date
      table.column :edition, :integer
      table.column :isbn, :string
      table.column :issn, :string
      table.column :external, :bool
      table.column :globalize_language_id, :integer
  end

  def self.down
    drop_table :documents
  end
end
