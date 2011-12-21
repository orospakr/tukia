require 'csv'

class Genders < ActiveRecord::Migration
  def self.up
    create_table :genders do |table|
      table.column :name, :string
      table.column :code, :integer
      table.column :language_id, :integer
    end
    
    load_from_csv("genders", genders_data)
  end

  def self.down
    drop_table :genders
  end
  
  def self.genders_data
    <<'END_OF_DATA'
"id","name","code","language_id"
1,"Not Applicable",9,1819
2,"Masculin",1,1930
3,"Feminin",2,1930
4,"Neutre",3,1930
5,"Non Applicable",9,1930
END_OF_DATA
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
end
