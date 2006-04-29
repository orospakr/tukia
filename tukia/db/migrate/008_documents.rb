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
      table.column :created_at, :datetime
      table.column :updated_at, :datetime
      table.column :published_on, :date
      table.column :edition, :integer
      table.column :licence, :text
      table.column :copyright, :string
      table.column :isbn, :string
      table.column :issn, :string
      table.column :external, :bool
      table.column :language_id, :integer
      table.column :file, :binary
      table.column :extension, :string
      table.column :pdffile, :binary
      # TODO should I keep this or do something fancier with MIME types?
      # after all, I think I do want a "separate PDF" feature
    end
  end

  def self.down
    drop_table :documents
  end
end
