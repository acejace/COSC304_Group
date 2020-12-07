<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime"%>

<html>
<head>
<title>update inventory</title>
</head>
<body>
        
<%@ include file="header.jsp" %>


<%
    int productId = Integer.parseInt(request.getParameter("pID"));
    int quantity = Integer.parseInt(request.getParameter("quant"));
    try 
    {
        getConnection();
		String sql3 = String.format("UPDATE productinventory SET quantity = %d WHERE productId = %d", quantity, productId);
		PreparedStatement pstmt3 = con.prepareStatement(sql3);
		pstmt3.executeUpdate();
		out.println("<h2><a href=index.jsp>Back to Main Page</a></h2>");

        closeConnection();
        response.sendRedirect("inventory.jsp");
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
