<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
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

<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>
<%@ page language="java" import="java.io.*,java.sql.*"%>

<%
// TODO: Include files auth.jsp and jdbc.jsp

%>

<%

try {
// TODO: Write SQL query that prints out total order amount by day
    String sql = " SELECT DATEADD(dd, 0, DATEDIFF(dd, 0, orderDate)), SUM(totalAmount) FROM ordersummary GROUP BY DATEADD(dd, 0, DATEDIFF(dd, 0, orderDate))";
    getConnection();
    Statement stmt = con.createStatement();
    ResultSet rst = stmt.executeQuery(sql);
    out.println("<h2>Administrator Sales Report by Day</h2>");
    out.println("<table>");
        out.println("<table><tr><th>Order Date</th><th>Total Order Amount</th></tr>");
			while (rst.next()) {
                Date orderDate = rst.getDate(1);

				String totalAmount = rst.getString(2);
                out.println("<tr><td>" + orderDate + "</td><td>" + totalAmount + "</td></tr>");
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

</body>
</html>

