class Synonmics < ActiveRecord::Migration
  def self.up
    create_table :synonmics do |table|
      table.column :comment, :text
    end
  end

  def self.down
    drop_table :synonmics
  end
end
