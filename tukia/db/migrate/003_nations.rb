class Nations < ActiveRecord::Migration
  def self.up
    create_table :nations do |table|
      table.column :globalize_country_id, :integer
      table.column :name, :string
      table.column :url, :string
      table.column :created_at, :datetime
      table.column :updated_at, :datetime
      table.column :committee_id, :datetime
    end
  end

  def self.down
    drop_table :nations
  end
end
