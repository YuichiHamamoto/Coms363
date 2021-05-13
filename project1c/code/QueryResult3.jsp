<%@page import="jdk.internal.misc.FileSystemOption"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*, java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Query Result 3</title>
</head>
<body>

<% 
            Connection connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/college", "root", "password");

            Statement statement = connection.createStatement() ;
            ResultSet resultSet = 
                statement.executeQuery("select number, name from courses where courses.department_code in( select code from department where name = 'Computer Science' or name ='Landscape Architect');") ; 
        %>
        <p>This is the result of query 3</p>
        <p>3)	The course numbers and names of all courses offered by either Department of Computer Science or Department of Landscape Architect.</p>
        <TABLE BORDER="1">
            <TR>
                <TH>number</TH>
                <TH>name</TH>
            </TR>
            <% while(resultSet.next()){ %>
            <TR>
                <TD> <%= resultSet.getInt("number") %></td>
                <TD> <%= resultSet.getString("name") %></TD>
            </TR>
            <% } %>
        </TABLE>

	
</body>
</html>