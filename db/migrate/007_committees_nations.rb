class CommitteesNations < ActiveRecord::Migration
  def self.up
    create_table :committees_nations do |table|
      table.column :committee_id, :integer
      table.column :nation_id, :integer
    end
  end

  def self.down
    drop_table :committees_nations
  end
end
