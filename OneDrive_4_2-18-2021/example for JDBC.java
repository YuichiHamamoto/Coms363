package coms363;
import java.sql.*;
public class CreateTables {
	private static Connection connect = null;

	public static void main(String[] args) 
	{

		try {
			//Set up connection parameters
			String userName = "coms363";
			String password = "password";
			String dbServer = "jdbc:mysql://localhost:3306/project1";
			//String dbServer = "jdbc:mysql://mysql.cs.iastate.edu/[schema]";
			//Set up connection
			connect = DriverManager.getConnection(dbServer,userName,password);
		} catch(Exception e) {

		}

		Statement stmt = null;
		try {
			stmt = connect.createStatement();
			stmt.addBatch("CREATE TABLE students (\r\n" + 
					"	snum INT,\r\n" + 
					"	ssn INTEGER,\r\n" + 
					"    name VARCHAR(10),\r\n" + 
					"    gender VARCHAR(1),\r\n" + 
					"    dob DATE, \r\n" + 
					"    c_addr VARCHAR(20),\r\n" + 
					"    c_phone VARCHAR(10),\r\n" + 
					"    p_addr VARCHAR(20),\r\n" + 
					"    p_phone VARCHAR(10),\r\n" + 
					"    PRIMARY KEY(ssn),\r\n" + 
					"    UNIQUE(snum)\r\n" + 
					");");
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			
			stmt.executeBatch();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				// Close connection
				if (stmt != null) {
					stmt.close();
				}
				if (connect != null) {
					connect.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}