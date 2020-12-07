<!DOCTYPE html>
<html>

	<head>
		<link rel="stylesheet" href="css/homeStyle.css">
		<title>Proper Tech</title>

</head>

<body>
	<div class="header">
		<ul class="header">
			<li class="header">
				<%
						String userName = (String) session.getAttribute("authenticatedUser");
						boolean loggedIn= false;
					if(userName == null)
						out.println("<a href='login.jsp' style='color:white'>Login</a> OR <a href='login.jsp' style='color:white'>Register</a>");
						else{
								loggedIn= true;
								out.println("Logged in: "+ userName) ;
						}
						%>
			</li>
			<li class="header"><a href="index.jsp" style="color:white">Home</a></li>
			<li class="header">
				<%
						if (loggedIn) out.println("<p><a href='myaccount.jsp' style='color:white'>My Account</a> <a href='logout.jsp' style='color:white'>LogOut</a></p>");
						else{
								out.println("Not currently logged in.");
						}
						%>
			</li>
		</ul>
	</div>
	<h1 class="main">Inventory</h1>
	<div class="main">
<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>
<%@ page language="java" import="java.io.*,java.sql.*"%>

<%

try {

    String sql = " SELECT * FROM productinventory";
    getConnection();
    Statement stmt = con.createStatement();
    ResultSet rst = stmt.executeQuery(sql);
   
    out.println("<table>");
        out.println("<table class='inventory'><tr><th>Product ID</th><th>Warehouse ID</th><th>Quantity</th><th>Price</th></tr>");
			while (rst.next()) {
                out.println("<tr><td>" + rst.getString(1)+ "</td><td>" + rst.getString(2) + "</td><<td>" + rst.getString(3) + "</td><<td>" + rst.getString(4) + "</td></tr>");
            }
	out.println("</table>");
	

}
catch (SQLException ex) {
	out.println(ex);
}
finally {
    closeConnection();
}

%>
<form name="MyForm" method=post action="editInventory.jsp">
<table style="display:inline">

	<tr>
		<td><div align="right"><font face="Arial, Helvetica, sans-serif" style="width:100%">Product ID:</font></div></td>
		<td><input type="text" name="pID"  size=10 maxlength=10 style="width:100%"></td>
	</tr>
	<tr>
		<td><div align="right"><font face="Arial, Helvetica, sans-serif" style="width:100%">New Quantity:</font></div></td>
		<td><input type="text" name="quant"  size=10 maxlength=10 style="width:100%"></td>
	</tr>
	<tr>
		<td colspan="2"> <input class="submit" type="submit" name="Submit" value="Update Inventory" style="width:100%; margin-left: 5%; margin-top: 5%;"> </td>
	</tr>	
	</table>
	<br/>
</form>
</div>
</body>
</html>

