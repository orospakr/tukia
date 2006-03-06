class Genders < ActiveRecord::Migration
  def self.up
    create_table :genders do |table|
      table.column :name, :string
      table.column :code, :integer
      table.column :globalize_language_id, :integer
    end
  end

  def self.down
    drop_table :genders
  end
end
