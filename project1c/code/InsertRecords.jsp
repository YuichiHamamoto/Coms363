<%@page import="jdk.internal.misc.FileSystemOption"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*, java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<%!
	public void insertRecord(){
		String DB_URL = "jdbc:mysql://localhost:3306/";

		   //  Database credentials
		String USER = "root";
		String PASS = "password";
		
		Connection conn = null;
		Statement stmt = null;
		
		try {			
			Class.forName("com.mysql.jdbc.Driver");
			//Open a connection
		      System.out.println("Connecting to a selected database...");
		      conn = DriverManager.getConnection(DB_URL, USER, PASS);
		      System.out.println("Connected database successfully...");
		      
		      System.out.println("Inserting records...");
		      
		      //Execute a query
		      stmt = conn.createStatement();
		      String sql = "use college; "; 
		      stmt.executeUpdate(sql);
		      
		      sql = "INSERT INTO students VALUES (1001,654651234,'Randy','M','2000-12-01','301 E Hall','5152700988','121 Main','7083066321');"; 
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO students VALUES (1002,123097834,'Victor','M','2000-05-06','270 W Hall','5151234578','702 Walnut','7080366333');";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO students VALUES (1003,978012431,'John','M','1999-07-08','201 W Hall','5154132805','888 University','5152012011');";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO students VALUES (1004,746897816,'Seth','M','1998-12-30','199 N Hall','5158891504','21 Green','5154132907');";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO students VALUES (1005,186032894,'Nicole','F','2001-04-01','178 S Hall','5158891155','13 Gray','5157162071');";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO students VALUES (1006,534218752,'Becky','F','2001-05-16','12 N Hall','5157083698','189 Clark','2034367632');";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO students VALUES (1007,432609519,'Kevin','M','2000-08-12','75 E Hall','5157082497','89 National','7182340772');";
		      stmt.executeUpdate(sql);
		      
		      sql = "INSERT INTO department VALUES(401,'Computer Science','5152982801','LAS');";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO department VALUES(402,'Mathematics','5152982802','LAS');";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO department VALUES(403,'Chemical Engineering','5152982803','Engineering');";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO department VALUES(404,'Landscape Architect','5152982804','Design');";
		      stmt.executeUpdate(sql);
		      
		      sql = "INSERT INTO degrees VALUES ('Computer Science','BS',401);";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO degrees VALUES ('Software Engineering','BS',401);";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO degrees VALUES ('Computer Science','MS',401);";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO degrees VALUES ('Computer Science','PhD',401);";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO degrees VALUES ('Applied Mathematics','MS',402);";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO degrees VALUES ('Chemical Engineering','BS',403);";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO degrees VALUES ('Landscape Architect','BS',404);";
		      stmt.executeUpdate(sql);
		      
		      sql = "INSERT INTO major VALUES (1001,'Computer Science','BS');";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO major VALUES (1002,'Software Engineering','BS');";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO major VALUES (1003,'Chemical Engineering','BS');";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO major VALUES (1004,'Landscape Architect','BS');";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO major VALUES (1005,'Computer Science','MS');";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO major VALUES (1006,'Applied Mathematics','MS');";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO major VALUES (1007,'Computer Science','PhD');";
		      stmt.executeUpdate(sql);
		      
		      sql = "INSERT INTO minor VALUES (1007,'Applied Mathematics','MS');";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO minor VALUES (1005,'Applied Mathematics','MS');";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO minor VALUES (1001,'Software Engineering','BS');";
		      stmt.executeUpdate(sql);
		      
		      sql = "INSERT INTO courses VALUES (113,'Spreadsheet','Microsoft Excel and Access',3,'Undergraduate',401);";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO courses VALUES (531,'Theory of Computation','Theorem and Probability ',3,'Graduate',401);";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO courses VALUES (363,'Database','Design Principle',3,'Undergraduate',401);";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO courses VALUES (412,'Water Management','Water Management',3,'Undergraduate',404);";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO courses VALUES (228,'Special Topics','Interesting Topics about CE',3,'Undergraduate',403);";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO courses VALUES (101,'Calculus','Limit and Derivative',4,'Undergraduate',402);";
		      stmt.executeUpdate(sql);
		      
		      sql = "INSERT INTO register VALUES (1001,363,'Fall2020',3);";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO register VALUES (1002,311,'Fall2020',4);";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO register VALUES (1003,228,'Fall2020',4);";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO register VALUES (1004,363,'Spring2021',3);";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO register VALUES (1005,531,'Spring2021',4);";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO register VALUES (1006,363,'Fall2020',3);";
		      stmt.executeUpdate(sql);
		      sql = "INSERT INTO register VALUES (1007,531,'Spring2021',4);";
		      stmt.executeUpdate(sql);
		      
		      System.out.println("Inserted records successfully...");
		       
			 
			
		}catch(SQLException se){
		      //Handle errors for JDBC
		      se.printStackTrace();
		   }catch(Exception e){
		      //Handle errors for Class.forName
		      e.printStackTrace();
		   }finally{
		      //finally block used to close resources
		      try{
		         if(stmt!=null)
		            conn.close();
		      }catch(SQLException se){
		      }// do nothing
		      try{
		         if(conn!=null)
		            conn.close();
		      }catch(SQLException se){
		         se.printStackTrace();
		      }//end finally try
		   }
	}
	
	%>
		<%
		String button = request.getParameter("button1");
		out.println("Click \"Submit\" To Insert data records");

		if ("Submit".equals(button)) {
			insertRecord();
			String redirectURL = "InsertRecordsResult.jsp";
			response.sendRedirect(redirectURL);
		}
	%>

	<form method="post">
		<input type="submit" name="button1" value="Submit" />

	</form>
</body>
</html>