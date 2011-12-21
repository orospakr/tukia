class Reports < ActiveRecord::Migration
  def self.up
    create_table :reports do |table|
      table.column :name, :string
      table.column :template, :string
    end
  end

  def self.down
    drop_table :reports
  end
end
