class DocumentsTerms < ActiveRecord::Migration
  def self.up
    create_table :documents_terms, :id => false, :primary_key => false do |t|
      t.column :document_id, :integer
      t.column :term_id, :integer
    end
  end

  def self.down
    drop_table :documents_terms
  end
end
