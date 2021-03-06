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
	<h1 class="main">Administrator Page</h1>
	<div class="main">
		<%@ include file="jdbc.jsp" %>
		<%@ include file="auth.jsp" %>
		<%@ page language="java" import="java.io.*,java.sql.*"%>

		<%
// TODO: Include files auth.jsp and jdbc.jsp

try {
// TODO: Write SQL query that prints out total order amount by day
    String sql = " SELECT DATEADD(dd, 0, DATEDIFF(dd, 0, orderDate)), SUM(totalAmount) FROM ordersummary GROUP BY DATEADD(dd, 0, DATEDIFF(dd, 0, orderDate))";
    getConnection();
    Statement stmt = con.createStatement();
    ResultSet rst = stmt.executeQuery(sql);
    out.println("<h2 style='color:white;'>Administrator Sales Report by Day</h2>");
    out.println("<table>");
        out.println("<table><tr><th>Order Date</th><th>Total Order Amount</th></tr>");
			while (rst.next()) {
                Date orderDate = rst.getDate(1);

				String totalAmount = rst.getString(2);
                out.println("<tr><td>" + orderDate + "</td><td>" + totalAmount + "</td></tr>");
            }
    out.println("</table>");

	// List All Customers 
	sql = "SELECT firstName, lastName FROM customer";
	rst = stmt.executeQuery(sql);
	out.println("<h2 style='color:white;'>Customers</h2>");
	out.println("<table><tr><th>First Name</th><th>Last Name</th></tr>");
	while(rst.next()) {
		String firstname = rst.getString(1);
		String lastname = rst.getString(2);
		out.println("<tr><td>" + firstname + "</td><td>" + lastname + "</td></tr>");
	}
	out.println("</table>");
	
	//Lists products
	out.println("<h2 style='color:white;'>Products</h2>");
	out.println("<table><tr>");
	sql = "SELECT productId, productName FROM product";
	Statement stmt1 = con.createStatement();
	ResultSet rst1 = stmt1.executeQuery(sql);
	int index = 0;
	while(rst1.next()){
		int id = rst1.getInt(1);
		String proName = rst1.getString(2);
		if(index % 2 != 0){
			out.println("</tr><tr>");
		}
		out.println("<td><a href = editProduct.jsp?id=" + id + ">" + proName + "</a></td>");
		index++;
	}
%>
</tr>		
</table>

		<%
}
catch (SQLException ex) {
	out.println(ex);
}
finally {
    closeConnection();
}

%>
	</div>
</body>

</html>