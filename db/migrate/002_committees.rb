class Committees < ActiveRecord::Migration
  def self.up
    create_table :committees do |table|
      table.column :name, :string
      table.column :parent_id, :integer
    end
  end

  def self.down
    drop_table :committees
  end
end
