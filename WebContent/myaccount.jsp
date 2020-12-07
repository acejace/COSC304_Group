<%@ include file="jdbc.jsp" %>
<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ page import="java.DateTime.*"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<!DOCTYPE html>
<html>
<head>
<title>MyAccount</title>
</head>
<body>

<div style="margin:0 auto;text-align:center;display:inline">

<form name="MyForm" method=post action="editAccount.jsp">
<table style="display:inline">

<h2>Edit Account Information</h2>

<%
// Print prior error login message if present
if (session.getAttribute("editMessage") != null)
	out.println("<p>"+session.getAttribute("editMessage").toString()+"</p>");
%>

<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Address:</font></div></td>
	<td><input type="text" name="address"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
	<td><input type="text" name="password"  size=10 maxlength=10></td>
</tr>

</table>
<br/>

<input class="submit" type="submit" name="Submit4" value="Edit Account">
</form>

<h2>My Orders</h2>

<%
try {
    getConnection();
    Statement stmt = con.createStatement();
    String userName = (String) session.getAttribute("authenticatedUser");
    String sql1 = "SELECT customerId FROM customer WHERE userid = '"+userName+"'";
    PreparedStatement pstmt = con.prepareStatement(sql1);
    ResultSet rst = stmt.executeQuery(sql1);
    int customerId = 0;
    while (rst.next()) {
        customerId = rst.getInt(1);
    }

    String sql2 = "SELECT * FROM ordersummary WHERE customerId = '"+customerId+"'";
    rst = stmt.executeQuery(sql2);
    out.println("<table>");
    out.println("<table><tr><th>Order Id</th><th>Order Date</th><th>TotalAmount</th></tr>");
    NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

    while(rst.next()) {
		    int orderId = rst.getInt(1);
		    Object orderDate = rst.getObject(2);
            String totalAmount = (currFormat.format(rst.getDouble(3)));
            

	    	out.println("<tr><td>" + orderId + "</td><td>" + orderDate + "</td><td>" + totalAmount + "</td></tr>");
    }
    out.println("</table>");

}catch (SQLException ex) {
	out.println(ex);
}finally {
    closeConnection();
}
%>

</div>


</body>
</html>