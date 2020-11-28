<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
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
    String sql = "SELECT orderDate, totalAmount FROM ordersummary GROUP BY orderDate, totalAmount";
    getConnection();
    Statement stmt = con.createStatement();
    ResultSet rst = stmt.executeQuery(sql);
    out.println("<h2>Administrator Sales Report by Day</h2>");
    out.println("<table>");
    
			while (rst.next()) {
                Date orderDate = rst.getDate(1);

				String totalAmount = rst.getString(2);
				out.println("<tr><td>"+ orderDate +"</td><td>"+ totalAmount +"</td></tr>");
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

