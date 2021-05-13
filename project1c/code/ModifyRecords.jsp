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
	public void modifyRecord(){
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
		      
		      //Execute a query
		      stmt = conn.createStatement();
		      String sql = "create database if not exists college;"; 
		      stmt.executeUpdate(sql);
		      sql = "use college; "; 
		      stmt.executeUpdate(sql);
		      sql = "update students set name = 'Scott' where ssn = 746897816;";
		      stmt.executeUpdate(sql);
		      sql = "SET SQL_SAFE_UPDATES=0;";
		      stmt.executeUpdate(sql);
		      sql = "update major \n" + 
		      		"set name= 'Computer Science',level='MS' where snum in (select s.snum \n" + 
		      		"																	from students s \n" + 
		      		"                                                                    where s.ssn = 746897816);";
		      stmt.executeUpdate(sql);
		      sql = "delete from register where regtime = 'Spring2021';";
		      stmt.executeUpdate(sql);
		      
			 
			
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
		out.println("Click \"Submit\" to modify record");

		if ("Submit".equals(button)) {
			modifyRecord();
			String redirectURL = "ModifyRecordsResult.jsp";
			response.sendRedirect(redirectURL);
		}
	%>

	<form method="post">
		<input type="submit" name="button1" value="Submit" />

	</form>
</body>
</html>