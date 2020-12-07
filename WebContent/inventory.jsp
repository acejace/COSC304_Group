<!DOCTYPE html>
<html>

	<head>
		<link rel="stylesheet" href="css/homeStyle.css">
		<title>Proper Tech</title>

</head>
<style>
	table {
	  font-family: arial, sans-serif;
	  border-collapse: collapse;
	  width: 100%;
	}
	
	td, th {
	  border: 1px solid #dddddd;
	  text-align: left;
	  padding: 8px;
	}

</style>
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
						if (loggedIn) out.println("<a href='logout.jsp' style='color:white'>LogOut</a>");
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
        out.println("<table><tr><th>Product ID</th><th>Warehouse ID</th><th>Quantity</th><th>price</th></tr>");
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
<form name="MyForm" method=post action="editInventory.jsp"></form>
<table style="display:inline">

	<tr>
		<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Product ID:</font></div></td>
		<td><input type="text" name="pID"  size=10 maxlength=10></td>
	</tr>
	<tr>
		<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">New Quantity:</font></div></td>
		<td><input type="text" name="quant"  size=10 maxlength=10></td>
	</tr>	
	</table>
	<br/>
<input class="submit" type="submit" name="Submit" value="Update Inventory">
</form>
</div>
</body>
</html>

