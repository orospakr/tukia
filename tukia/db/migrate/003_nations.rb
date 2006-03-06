class Nations < ActiveRecord::Migration
  def self.up
    create_table :nations do |table|
      table.column :globalize_country_id, :integer
      table.column :name, :string
    end
  end

  def self.down
    drop_table :nations
  end
end
