class People < ActiveRecord::Migration
  def self.up
    create_table :people do |table|
      table.column :name, :string
      table.column :password, :string
      table.column :givenname, :string
      table.column :surname, :string
      table.column :email, :string
      table.column :url, :string
      table.column :phone, :string
      table.column :organisation, :string
      table.column :enabled, :boolean
      table.column :admin, :boolean
      table.column :created, :date
      table.column :lastlogin, :date
    end
  end

  def self.down
    drop_table :people
  end
end
