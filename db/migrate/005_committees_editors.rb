class CommitteesEditors < ActiveRecord::Migration
  def self.up
    create_table :committees_editors do |table|
      table.column :committee_id, :integer
      table.column :person_id, :integer
    end
  end

  def self.down
     drop_table :committees_editors
  end
end
