class Synonmics < ActiveRecord::Migration
  def self.up
    create_table :synonmics do |table|
    end
  end

  def self.down
    drop_table :synonmics
  end
end
