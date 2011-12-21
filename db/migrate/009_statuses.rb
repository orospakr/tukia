require 'csv'

class Statuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |table|
      table.column :name, :string
    end
    load_from_csv("statuses",status_data)
  end

  def self.down
    drop_table :statuses
  end

  def self.load_from_csv(table_name, data)
    column_clause = nil
    is_header = false
    cnx = ActiveRecord::Base.connection
    ActiveRecord::Base.silence do
      reader = CSV::Reader.create(data)

      columns = reader.shift.map {|column_name| cnx.quote_column_name(column_name) }
      columns.shift # added for PostgreSQL
      column_clause = columns.join(', ')

      reader.each do |row|
        next if row.first.nil? # skip blank lines
        raise "No table name defined" if !table_name
        raise "No header defined" if !column_clause
        # Changed for PostgreSQL
        #values_clause = row.map {|v| cnx.quote(v).gsub('\\n', "\n").gsub('\\r', "\r") }.join(', ')
        values = row.map {|v| cnx.quote(v).gsub('\\n', "\n").gsub('\\r', "\r") }
        values.shift
        values_clause = values.join(', ')

        sql = "INSERT INTO #{table_name} (#{column_clause}) VALUES (#{values_clause})"
        cnx.insert(sql)
      end
    end
  end

    def self.status_data
    <<'END_OF_DATA'
"id","name"
"1","WD"
"2","CD"
"3","FCD"
"4","FDIS"
"5","IS"
END_OF_DATA
  end
end
