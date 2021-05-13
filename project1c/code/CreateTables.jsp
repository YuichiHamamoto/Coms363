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
		      System.out.println("Creating table in given database...");
		      stmt = conn.createStatement();
		      String sql = "create database if not exists college;"; 
		      stmt.executeUpdate(sql);
		      sql = "use college; "; 
		      stmt.executeUpdate(sql);
		      sql = "drop table if exists students;\n";    		
		      stmt.executeUpdate(sql);
		      sql = "drop table if exists department;";    		
		      stmt.executeUpdate(sql);
		      sql = "drop table if exists degrees;";    		
		      stmt.executeUpdate(sql);
		      sql = "drop table if exists courses;";    		
		      stmt.executeUpdate(sql);
		      sql = "drop table if exists register;";    		
		      stmt.executeUpdate(sql);
		      sql = "drop table if exists major;";    		
		      stmt.executeUpdate(sql);
		      sql = "drop table if exists minor;";    		
		      stmt.executeUpdate(sql);
		      
		      sql = "create table students(\n" + 
		      		"	snum integer unique,\n" + 
		      		"    ssn integer,\n" + 
		      		"    primary key(ssn),\n" + 
		      		"    name varchar(10),\n" + 
		      		"    gender varchar(1),\n" + 
		      		"    dob datetime,\n" + 
		      		"    c_addr varchar(20),\n" + 
		      		"    c_phone varchar(10),\n" + 
		      		"    p_addr varchar(20),\n" + 
		      		"    p_phone varchar(10)\n" + 
		      		"	);"; 
		      stmt.executeUpdate(sql);
		      
		      sql = "create table department(\n" + 
		      		"	code integer,\n" + 
		      		"    primary key(code),\n" + 
		      		"    name varchar(50) unique,\n" + 
		      		"    phone varchar(10),\n" + 
		      		"    college varchar(20)\n" + 
		      		"	);  "; 
			  stmt.executeUpdate(sql);
			  
			  sql = "create table degrees(\n" + 
			  		"	name varchar(50),\n" + 
			  		"    level varchar(5),\n" + 
			  		"    primary key(name,level),\n" + 
			  		"    department_code integer references departments(code)\n" + 
			  		");"; 
			  stmt.executeUpdate(sql);
			  
			  sql = "create table courses(\n" + 
			  		"	number integer,\n" + 
			  		"    primary key(number),\n" + 
			  		"    name varchar(50) unique, \n" + 
			  		"    description varchar(50), \n" + 
			  		"    credithours integer, \n" + 
			  		"    level varchar(20), \n" + 
			  		"    department_code integer references departments(code)\n" + 
			  		");"; 
			  stmt.executeUpdate(sql);
			  
			  sql = "create table register(\n" + 
			  		"	snum integer references students(snum), \n" + 
			  		"    course_number integer references courses(course_number), \n" + 
			  		"    primary key(snum,course_number),\n" + 
			  		"    regtime varchar(20), \n" + 
			  		"    grade integer\n" + 
			  		");"; 
			  stmt.executeUpdate(sql);
			  
			  sql = "create table major(\n" + 
			  		"	snum integer references students(snum), \n" + 
			  		"    name varchar(50) references degrees(name), \n" + 
			  		"    level varchar(5) references degrees(level)\n" + 
			  		");"; 
			  stmt.executeUpdate(sql);
			  
			  sql = "create table minor(\n" + 
			  		"	snum integer references students(snum), \n" + 
			  		"    name varchar(50) references degrees(name), \n" + 
			  		"    level varchar(5) references degrees(level)\n" + 
			  		");"; 
			  stmt.executeUpdate(sql);
			  System.out.println("Created table in given database...");	  
			 
			
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
		out.println("Click \"Submit\" To Make Tables");
		
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