class CommitteesConvenors < ActiveRecord::Migration
  def self.up
    create_table :committees_convenors, :id => false, :primary_key => false do |table|
      table.column :committee_id, :integer, :null => false
      table.column :person_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :committees_convenors
  end
end
