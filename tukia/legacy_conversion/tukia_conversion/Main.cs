// project created on 28/06/2006 at 3:05 P
using System;
using System.Data;
using Npgsql;

namespace tukia_conversion
{
	class MainClass
	{
		private const string LegacyConnString = "Server=10.154.0.1;Database=definitions;Password=sausagepizza;User Id=definitions;Encoding=UNICODE";
		private const string NewConnString = "Server=10.154.2.244;Database=tukia_development;Password=deadlock;User Id=tukia;Encoding=UNICODE";
		
		public static void Main(string[] args)
		{
			Console.WriteLine("Retarded Interim-Definitions->Tukia Conversion Utility");
			Console.WriteLine("Connecting to legacy database...");
			NpgsqlDataAdapter legacyAdapter = new NpgsqlDataAdapter(
                 "SELECT * FROM \"Definitions\"",
                 LegacyConnString);
            DataSet legacyDataset = new DataSet();
	        legacyAdapter.Fill(legacyDataset);
	        DataTable legacyDefinitions = legacyDataset.Tables["Table"];

            Console.WriteLine("Success.");
            Console.WriteLine("Connecting to new Tukia database...");
            NpgsqlConnection newConn = new NpgsqlConnection(NewConnString);
    		newConn.Open();
    		Console.WriteLine("Success.  Now ready to begin migration.  Progress will be reported by English term.");
    		
    		// Autodiscover the IDs of the new projects we want to associate these terms to (by 
    		// "reference id"), and store them in memory for use below.
    		
    		foreach (DataRow term in legacyDefinitions.Rows)
    		{
    			int synonmic = 0;
    			System.Console.WriteLine("Currently migrating: " + term["English_Term"]);
    			NpgsqlTransaction t = newConn.BeginTransaction();
    			// first, create a new synonmic group.
    			(new NpgsqlCommand("INSERT INTO synonmics (\"comment\") VALUES ('Imported from legacy DB')", newConn)).ExecuteNonQuery();
    			synonmic = Convert.ToInt32((new NpgsqlCommand("SELECT currval('synonmics_id_seq')", newConn)).ExecuteScalar());
    			System.Console.WriteLine("  New synonmic group: " + synonmic.ToString());
    			// create a new Term. set the Language to English.
    			
    			try
    			{
	    			if (((string)term["English_Term"]).Length > 0)
	    			{
		    			NpgsqlCommand engTermInsert = new NpgsqlCommand("INSERT INTO terms (\"language_id\", \"term\", \"definition\", \"gender_id\", \"person_id\", \"created_at\", \"deleted\", \"comments\", \"project_id\", \"synonmic_id\", \"facet\", \"acronym\") VALUES (:language_id, :term, :definition, :gender_id, :person_id, now(), :deleted, :comments, :project_id, :synonmic_id, :facet, :acronym)", newConn);
		    			engTermInsert.Parameters.Add(new NpgsqlParameter("language_id", DbType.Int32));
		    			engTermInsert.Parameters[0].Value = 1819; // I could replace this with a search thing that will make this hard-coded value unecessary
		    			engTermInsert.Parameters.Add(new NpgsqlParameter("term", DbType.String));
		    			engTermInsert.Parameters[1].Value = term["English_Term"];
		    			engTermInsert.Parameters.Add(new NpgsqlParameter("definition", DbType.String));
		    			engTermInsert.Parameters[2].Value = term["English_Definition"];
		    			engTermInsert.Parameters.Add(new NpgsqlParameter("gender_id", DbType.Int32));
		    			engTermInsert.Parameters[3].Value = 1; // "-9", English N/A
		    			engTermInsert.Parameters.Add(new NpgsqlParameter("person_id", DbType.Int32));
		    			engTermInsert.Parameters[4].Value = 1; // me! :D
		    			engTermInsert.Parameters.Add(new NpgsqlParameter("deleted", DbType.Boolean));
		    			engTermInsert.Parameters[5].Value = false;
		    			engTermInsert.Parameters.Add(new NpgsqlParameter("comments", DbType.String));
		    			engTermInsert.Parameters[6].Value = "Migrated from the legacy database on " + System.DateTime.Now.ToString() + ".\n\n'MiscNotes' field contained:\n" + term["MiscNotes"] + "\n\nSource Authority: " + term["Source"];
		    			engTermInsert.Parameters.Add(new NpgsqlParameter("project_id", DbType.Int32));
		    			engTermInsert.Parameters[7].Value = GetSourceAuthority(term); // source authority. obviously this needs to be determined
		    			engTermInsert.Parameters.Add(new NpgsqlParameter("synonmic_id", DbType.Int32));
		    			engTermInsert.Parameters[8].Value = synonmic;
		    			engTermInsert.Parameters.Add(new NpgsqlParameter("facet", DbType.String));
		    			engTermInsert.Parameters[9].Value = term["English_facet"];
		    			engTermInsert.Parameters.Add(new NpgsqlParameter("acronym", DbType.String));
		    			engTermInsert.Parameters[10].Value = term["English_acronym"];
		    			engTermInsert.ExecuteNonQuery();
		    			AddProjectUsages(term, newConn, Convert.ToInt32((new NpgsqlCommand("SELECT currval('terms_id_seq')", newConn)).ExecuteScalar()));
	    			}
	    			else
	    			{
	    				System.Console.WriteLine("Skipping english term, it's blank.");
	    			}
	    		}
    			catch (InvalidCastException e)
    			{
    				System.Console.WriteLine("Skipping english term, it's null.");
    			}
    			
    			try
    			{
	    			if (((string)term["French_Term"]).Length > 0)
	    			{
	    				
	    				
		    			NpgsqlCommand fraTermInsert = new NpgsqlCommand("INSERT INTO terms (\"language_id\", \"term\", \"definition\", \"gender_id\", \"person_id\", \"created_at\", \"deleted\", \"comments\", \"project_id\", \"synonmic_id\", \"facet\", \"acronym\") VALUES (:language_id, :term, :definition, :gender_id, :person_id, now(), :deleted, :comments, :project_id, :synonmic_id, :facet, :acronym)", newConn);
		    			fraTermInsert.Parameters.Add(new NpgsqlParameter("language_id", DbType.Int32));
		    			fraTermInsert.Parameters[0].Value = 1930; // I could replace this with a search thing that will make this hard-coded value unecessary
		    			fraTermInsert.Parameters.Add(new NpgsqlParameter("term", DbType.String));
		    			fraTermInsert.Parameters[1].Value = term["French_Term"];
		    			fraTermInsert.Parameters.Add(new NpgsqlParameter("definition", DbType.String));
		    			fraTermInsert.Parameters[2].Value = term["French_Definition"];
		    			fraTermInsert.Parameters.Add(new NpgsqlParameter("gender_id", DbType.Int32));
		    			fraTermInsert.Parameters[3].Value = term["fgender"];
		    			fraTermInsert.Parameters.Add(new NpgsqlParameter("person_id", DbType.Int32));
		    			fraTermInsert.Parameters[4].Value = 1; // me! :D
		    			fraTermInsert.Parameters.Add(new NpgsqlParameter("deleted", DbType.Boolean));
		    			fraTermInsert.Parameters[5].Value = false;
		    			fraTermInsert.Parameters.Add(new NpgsqlParameter("comments", DbType.String));
		    			fraTermInsert.Parameters[6].Value = "Migrated from the legacy database on " + System.DateTime.Now.ToString() + ".\n\n'MiscNotes' field contained:\n" + term["MiscNotes"] + "\n\nSource Authority: " + term["Source"];
		    			fraTermInsert.Parameters.Add(new NpgsqlParameter("project_id", DbType.Int32));
		    			fraTermInsert.Parameters[7].Value = GetSourceAuthority(term); // source authority. obviously this needs to be determined
		    			fraTermInsert.Parameters.Add(new NpgsqlParameter("synonmic_id", DbType.Int32));
		    			fraTermInsert.Parameters[8].Value = synonmic;
		    			fraTermInsert.Parameters.Add(new NpgsqlParameter("facet", DbType.String));
		    			fraTermInsert.Parameters[9].Value = term["French_facet"];
		    			fraTermInsert.Parameters.Add(new NpgsqlParameter("acronym", DbType.String));
		    			fraTermInsert.Parameters[10].Value = term["French_acronym"];
		    			fraTermInsert.ExecuteNonQuery();
		    			AddProjectUsages(term, newConn, Convert.ToInt32((new NpgsqlCommand("SELECT currval('terms_id_seq')", newConn)).ExecuteScalar()));
	    			
		    			
	    			}
	    			else
	    			{
	    				System.Console.WriteLine("Skipping french term, it's blank.");
	    			}
    			}
    			catch (InvalidCastException e)
    			{
    				System.Console.WriteLine("Skipping french term, it's null.");
    			}
    			// associate the new term with the new synonmic group.
    			// put all the English-specific values of the old term into it.
    			// create a french term and do the same.  put the old miscnotes field
    			// in both new records in the comments field.
    			// go through each of the "source/usage" fields in the legacy DB and add JOIN records in the new
    			// db accordingly
    			t.Commit();
    			
    		}

    		//NpgsqlCommand command = new NpgsqlCommand("insert into table1 values(1, 1)", newConn);
    		
    		System.Console.WriteLine("Yay! Done!");
		}
		
		private static int GetSourceAuthority(DataRow dr)
		{
			try { if ((string)dr["ISO_15944_1"] == "1") return 1; } catch (InvalidCastException e) {}
			try { if ((string)dr["ISO_15944_2"] == "1") return 2; } catch (InvalidCastException e) {}
			try { if ((string)dr["ISO_15944_3"] == "1") return 4; } catch (InvalidCastException e) {}
			try { if ((string)dr["ISO_15944_4"] == "1") return 5; } catch (InvalidCastException e) {}
			try { if ((string)dr["ISO_15944_5"] == "1") return 6; } catch (InvalidCastException e) {}
			//if ((string)dr["ISO_15944_6"] == "1") return 7;
			try { if ((string)dr["VSEC_1"] == "1") return 8; } catch (InvalidCastException e) {}
			try { if ((string)dr["VSEC_2"] == "1") return 9; } catch (InvalidCastException e) {}
			try { if ((string)dr["VSEC_3"] == "1") return 10; } catch (InvalidCastException e) {}
			try { if ((string)dr["VSEC_4"] == "1") return 11; } catch (InvalidCastException e) {}
			try { if ((string)dr["VSEC_5"] == "1") return 12; } catch (InvalidCastException e) {}
			try { if ((string)dr["ppt-104"] == "1") return 18; } catch (InvalidCastException e) {}
			try { if ((string)dr["ppt-106"] == "1") return 19; } catch (InvalidCastException e) {}
			try { if ((string)dr["ISO_24751_1"] == "1") return 20; } catch (InvalidCastException e) {}
			try { if ((string)dr["ISO_24751_2"] == "1") return 21; } catch (InvalidCastException e) {}
			try { if ((string)dr["ISO_24751_3"] == "1") return 22; } catch (InvalidCastException e) {}
			System.Console.WriteLine("Orphan term!");
			return 23;
		}
		
		private static void AddProjectUsages(DataRow oldterm, NpgsqlConnection conn, int newterm)
		{
			NpgsqlCommand usage = new NpgsqlCommand("INSERT INTO usages (\"project_id\", \"term_id\") VALUES (:project_id, :term_id)", conn);
			usage.Parameters.Add(new NpgsqlParameter("project_id", DbType.Int32));
			usage.Parameters.Add(new NpgsqlParameter("term_id", DbType.Int32));
			
			try
			{
				if ((string)oldterm["ISO_15944_1"] == "2")
				{
					usage.Parameters[0].Value = 1;
					usage.Parameters[1].Value = newterm;
					usage.ExecuteNonQuery();
				}
			}
			catch (InvalidCastException e) {}
			try
			{
				if ((string)oldterm["ISO_15944_2"] == "2")
				{
					usage.Parameters[0].Value = 2;
					usage.Parameters[1].Value = newterm;
					usage.ExecuteNonQuery();
				}
			}
			catch (InvalidCastException e) {}
			try
			{
				if ((string)oldterm["ISO_15944_3"] == "2")
				{
					usage.Parameters[0].Value = 4;
					usage.Parameters[1].Value = newterm;
					usage.ExecuteNonQuery();
				}
			}
			catch (InvalidCastException e) {}
			try
			{
				if ((string)oldterm["ISO_15944_4"] == "2")
				{
					usage.Parameters[0].Value = 5;
					usage.Parameters[1].Value = newterm;
					usage.ExecuteNonQuery();
				}
			}
			catch (InvalidCastException e) {}
			try
			{
				if ((string)oldterm["ISO_15944_5"] == "2")
				{
					usage.Parameters[0].Value = 6;
					usage.Parameters[1].Value = newterm;
					usage.ExecuteNonQuery();
				}
			}
			catch (InvalidCastException e) {}
			try
			{
				//if ((string)oldterm["ISO_15944_6"] == "1") return 7;
				if ((string)oldterm["VSEC_1"] == "2")
				{
					usage.Parameters[0].Value = 8;
					usage.Parameters[1].Value = newterm;
					usage.ExecuteNonQuery();
				}
			}
			catch (InvalidCastException e) {}
			try
			{
				if ((string)oldterm["VSEC_2"] == "2")
				{
					usage.Parameters[0].Value = 9;
					usage.Parameters[1].Value = newterm;
					usage.ExecuteNonQuery();
				}
			}
			catch (InvalidCastException e) {}
			try
			{
				if ((string)oldterm["VSEC_3"] == "2")
				{
					usage.Parameters[0].Value = 10;
					usage.Parameters[1].Value = newterm;
					usage.ExecuteNonQuery();
				}
			}
			catch (InvalidCastException e) {}
			try
			{
				if ((string)oldterm["VSEC_4"] == "2")
				{
					usage.Parameters[0].Value = 11;
					usage.Parameters[1].Value = newterm;
					usage.ExecuteNonQuery();
				}
			}
			catch (InvalidCastException e) {}
			try
			{
				if ((string)oldterm["VSEC_5"] == "2")
				{
					usage.Parameters[0].Value = 12;
					usage.Parameters[1].Value = newterm;
					usage.ExecuteNonQuery();
				}
			}
			catch (InvalidCastException e) {}
			try
			{
				if ((string)oldterm["ppt-104"] == "2")
				{
					usage.Parameters[0].Value = 18;
					usage.Parameters[1].Value = newterm;
					usage.ExecuteNonQuery();
				}
			}
			catch (InvalidCastException e) {}
			try
			{
				if ((string)oldterm["ppt-106"] == "2")
				{
					usage.Parameters[0].Value = 19;
					usage.Parameters[1].Value = newterm;
					usage.ExecuteNonQuery();
				}
			}
			catch (InvalidCastException e) {}
			try
			{
				if ((string)oldterm["ISO_24751_1"] == "2")
				{
					usage.Parameters[0].Value = 20;
					usage.Parameters[1].Value = newterm;
					usage.ExecuteNonQuery();
				}
			}
			catch (InvalidCastException e) {}
			try
			{
				if ((string)oldterm["ISO_24751_2"] == "2")
				{
					usage.Parameters[0].Value = 21;
					usage.Parameters[1].Value = newterm;
					usage.ExecuteNonQuery();
				}
			}
			catch (InvalidCastException e) {}
			try
			{
				if ((string)oldterm["ISO_24751_3"] == "2")
				{
					usage.Parameters[0].Value = 22;
					usage.Parameters[1].Value = newterm;
					usage.ExecuteNonQuery();
				}
			}
			catch (InvalidCastException e) {}
		}
		
	}
}