<%@page import="jdk.internal.misc.FileSystemOption"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*, java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Query Result 2</title>
</head>
<body>

<% 
            Connection connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/college", "root", "password");

            Statement statement = connection.createStatement() ;
            ResultSet resultSet = 
                statement.executeQuery("select d.name,d.level\n" + 
    		      		"from degrees d\n" + 
    		      		"where d.department_code in (select d.code\n" + 
    		      		"						   from department d\n" + 
    		      		"                           where d.name = 'Computer Science');") ; 
        %>
        <p>This is the result of query 2</p>
        <p>2)	All degree names and levels offered by the department of Computer Science</p>

        <TABLE BORDER="1">
            <TR>
                <TH>name</TH>
                <TH>level</TH>
            </TR>
            <% while(resultSet.next()){ %>
            <TR>
                <TD> <%= resultSet.getString("name") %></td>
                <TD> <%= resultSet.getString("level") %></TD>
            </TR>
            <% } %>
        </TABLE>

	
</body>
</html>