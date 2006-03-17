class DocumentsGlobalizeLanguages < ActiveRecord::Migration
  def self.up
    create_table :documents_globalize_languages, :id => false, :primary_key => false do |table|
      table.column :document_id, :integer
      table.column :globalize_language_id, :integer
    end
  end

  def self.down
    drop_table :documents_globalize_languages
  end
end
