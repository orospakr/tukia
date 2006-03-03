class Nations < ActiveRecord::Migration
  def self.up
    create_table :nations do |table|
      table.column :code, :string
      table.column :name, :string
    end
  end

  def self.down
  end
end
