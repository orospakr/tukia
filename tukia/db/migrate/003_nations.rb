class Nations < ActiveRecord::Migration
  def self.up
    create_table :nations do |table|
      table.column :country_id, :integer
      table.column :name, :string
      table.column :url, :string
      table.column :created_at, :datetime
      table.column :updated_at, :datetime
      table.column :committee_id, :integer
      # 0 = Liason, 1 = Observer, 2 = Full Participant
      table.column :participation_level, :integer
    end
  end

  def self.down
    drop_table :nations
  end
end
