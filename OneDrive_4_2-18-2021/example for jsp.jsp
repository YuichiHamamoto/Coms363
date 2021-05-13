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
	public void createTable(){
		String connectionURL = "jdbc:mysql://127.0.0.1:3306/?user=coms363";
		Connection connection = null;
		
		
		Statement statement = null;
		
		try {			
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(connectionURL, "coms363", "password");

			statement = connection.createStatement();
			statement.addBatch("drop database if exists project1;");
			statement.addBatch("create database project1;");
			statement.addBatch("use project1;");
			statement.addBatch("CREATE TABLE students (\r\n" + 
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
			
			
			statement.executeBatch();
			
			System.out.println("Tables are created");
			 
			
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Error with in create table: "+ e.getMessage());
			e.printStackTrace();
		}
	}
	
	%>
		<%
		String button = request.getParameter("button1");
		out.println("Click Submit To Make Tables");

		if ("Submit".equals(button)) {
			createTable();
			String redirectURL = "CreateTablesResult.jsp";
			response.sendRedirect(redirectURL);
		}
	%>

	<form method="post">
		<input type="submit" name="button1" value="Submit" />

	</form>
</body>
</html>