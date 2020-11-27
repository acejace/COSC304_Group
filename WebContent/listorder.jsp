<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<html>
<head>
<title>TECH Grocery Order List</title>
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
</head>
<body>

<h1>Order List</h1>

<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

try
( Connection con = DriverManager.getConnection(url,uid,pw);
	Statement stmt = con.createStatement(); )
{ 
	String sql = "SELECT orderId, orderDate, customer.customerId, firstName + ' ' + lastName, totalAmount FROM ordersummary JOIN customer ON customer.customerId = ordersummary.customerId";
	String sql2 = "SELECT productId, quantity, price FROM orderproduct JOIN ordersummary ON orderproduct.orderId = ordersummary.orderId WHERE orderproduct.orderID = ?";
	PreparedStatement pstmt = con.prepareStatement(sql2);

			ResultSet rst = stmt.executeQuery(sql);
			out.println("<table><tr><th>Order ID</th><th>Order Date</th><th>Customer ID</th><th>Customer Name</th><th>Total Amount</th></tr>");
		
			while (rst.next())
			{
				
				int OrderID = rst.getInt(1);
				Object OrderDate = rst.getObject(2);
				int CustomerId = rst.getInt(3);
				String CustomerName = rst.getString(4);
				NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
				String TotalAmount = (currFormat.format(rst.getDouble(5)));

				
				out.println("<tr><td>" + OrderID + "</td><td> " + OrderDate + "</td><td>" + CustomerId + "</td><td>" + CustomerName + "</td><td>" + TotalAmount + "</td></tr>");
				
				pstmt.setInt(1, OrderID);
				
				ResultSet rst2 = pstmt.executeQuery();
				
				out.println("<td colspan=3></td><td colspan=2><table><tr><th>Product ID</th><th>Quantity</th><th>Price</th></tr></td>");
				
				while (rst2.next()) {
					
					int ProductID = rst2.getInt(1);
					int Quantity = rst2.getInt(2);
					String Price = (currFormat.format(rst2.getDouble(3)));
				
					out.println("<tr><td>" + ProductID + "</td><td> " + Quantity + "</td><td>" + Price + "</td></tr>");

				}
				out.println("</table></td>");

				System.out.println("\n");
			}
			out.close();
}
catch (SQLException ex)
{
	System.out.println("SQLException: " + ex);
}		

%>


</body>
</html>