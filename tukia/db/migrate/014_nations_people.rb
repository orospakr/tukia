class NationsPeople < ActiveRecord::Migration
  def self.up
    create_table :nations_people, :id => false, :primary_key => false do |table|
      table.column :nation_id, :integer
      table.column :person_id, :integer
    end
  end

  def self.down
    drop_table :nations_people
  end
end
