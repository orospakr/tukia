class Committees < ActiveRecord::Migration
  def self.up
    create_table :committees do |table|
      table.column :name, :string
      table.column :title, :string
      table.column :parent_id, :integer
      table.column :created_at, :datetime
      table.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :committees
  end
end
