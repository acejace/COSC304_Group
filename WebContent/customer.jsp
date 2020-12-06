<!DOCTYPE html>
	<html>
		<head>
			<link rel="stylesheet" href="css/homeStyle.css">
			<title>Proper Tech</title>
	</head>
	
	</head>
	<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<div class="header">
	<ul class="header"> 
			<li class="header"><a href="login.jsp" style="color:white">Login</a> OR <a href="login.jsp" style="color:white">Register</a></li>
			<li class="header"><a href="index.jsp" style="color:white">Home</a></li>
			<li class="header"><a href="logout.jsp" style="color:white">LogOut</a></li>
	</ul>
</div>
<h1 class="main">Customer Details</h1>
<div class="main">
<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if(userName == null)
	out.println("<h2><a href=\"login.jsp\"></a></h2>");
%>

<%

try 
{
getConnection();
Statement stmt = con.createStatement();
String sql = "SELECT customerId, firstName ,lastName ,email , phonenum ,address ,city ,state ,postalCode, country, userid FROM Customer WHERE userid = '" + userName +"'";
PreparedStatement pstmt = con.prepareStatement(sql);
ResultSet rst = stmt.executeQuery(sql);
rst.next();
out.println("<table class='customerDetails'><tr><th>Customer ID</th><td>" + rst.getInt(1) + "</td></tr>");
out.println("<tr><th>First Name</th><td>" + rst.getString(2) + "</td></tr>");
out.println("<tr><th>Last Name</th><td>" + rst.getString(3) + "</td></tr>");
out.println("<tr><th>Email</th><td>" + rst.getString(4) + "</td></tr>");
out.println("<tr><th>Phone</th><td>" + rst.getString(5) + "</td></tr>");
out.println("<tr><th>Address</th><td>" + rst.getString(6) + "</td></tr>");
out.println("<tr><th>City</th><td>" + rst.getString(7) + "</td></tr>");
out.println("<tr><th>State</th><td>" + rst.getString(8) + "</td></tr>");
out.println("<tr><th>Postal Code</th><td>" + rst.getString(9) + "</td></tr>");
out.println("<tr><th>Country</th><td>" + rst.getString(10) + "</td></tr>");
out.println("<tr><th>User ID</th><td>" + rst.getString(11) + "</td></tr></table>");

} 
catch (SQLException ex) {
	out.println(ex);
}
finally
{
	closeConnection();
}		

%>

</body>
</html>

