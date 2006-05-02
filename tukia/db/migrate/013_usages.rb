class Usages < ActiveRecord::Migration
  def self.up
    create_table :usages, :id => false, :primary_key => false do |t|
      t.column :document_id, :integer, :null => false
      t.column :term_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :usages
  end
end
