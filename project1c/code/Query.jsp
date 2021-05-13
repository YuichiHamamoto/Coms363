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
		<%
		String button1 = request.getParameter("button1");

		if ("Q1".equals(button1)) {
			String redirectURL = "QueryResult1.jsp";
			response.sendRedirect(redirectURL);
		}
		
		String button2 = request.getParameter("button2");

		if ("Q2".equals(button2)) {
			String redirectURL = "QueryResult2.jsp";
			response.sendRedirect(redirectURL);
		}
		
		String button3 = request.getParameter("button3");

		if ("Q3".equals(button3)) {
			String redirectURL = "QueryResult3.jsp";
			response.sendRedirect(redirectURL);
		}
	%>

	<form method="post">
	<p>Click "Q1" to see result of query 1</p>
		<input type="submit" name="button1" value="Q1" />

	</form>
	<form method="post">
	<p>Click "Q2" to see result of query 2</p>
		<input type="submit" name="button2" value="Q2" />

	</form>
	<form method="post">
	<p>Click "Q3" to see result of query 3</p>
		<input type="submit" name="button3" value="Q3" />

	</form>
</body>
</html>