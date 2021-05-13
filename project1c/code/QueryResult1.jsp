<%@page import="jdk.internal.misc.FileSystemOption"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*, java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Query Result 1</title>
</head>
<body>

<% 
            Connection connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/college", "root", "password");

            Statement statement = connection.createStatement() ;
            ResultSet resultSet = 
                statement.executeQuery("select distinct snum, ssn\n" + 
    		      		"from students\n" + 
    		      		"where students.name = 'Becky';") ; 
        %>
        
        <p>This is the result of query 1</p>
        <p>1)	The student number and ssn of the student whose name is "Becky"</p>

        <TABLE BORDER="1">
            <TR>
                <TH>ssn</TH>
                <TH>snum</TH>
            </TR>
            <% while(resultSet.next()){ %>
            <TR>
                <TD> <%= resultSet.getInt("ssn") %></td>
                <TD> <%= resultSet.getInt("snum") %></TD>
            </TR>
            <% } %>
        </TABLE>

	
</body>
</html>