class DocumentsGlobalizeLanguages < ActiveRecord::Migration
  def self.up
    create_table :documents_languages, :id => false, :primary_key => false do |table|
      table.column :document_id, :integer
      table.column :language_id, :integer
    end
  end

  def self.down
    drop_table :documents_globalize_languages
  end
end
