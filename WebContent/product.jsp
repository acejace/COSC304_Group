<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.util.Locale" %>

<html>
<head>
<title>Jace's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product
int productId = Integer.parseInt(request.getParameter("id"));
String sql = "SELECT productName, productPrice, productImageURL FROM product where productId=?";
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";	
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}
try 
{
    getConnection();
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setInt(1, productId);
    ResultSet rst = pstmt.executeQuery();
    if(!rst.next())
        out.println("<h1>Invalid product ID</h1>");
    else{
        String productName = rst.getString(1);
        String productImage = rst.getString(3);
        NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
        String productPrice = (currFormat.format(rst.getDouble(2)));
        double numPrice = rst.getDouble(2);
        String link =  String.format("addcart.jsp?id=%s&name=%s&price=%f",productId,rst.getString(1).replaceAll("'","%27"),numPrice);
        out.println("<h1>" + productName + "</h1>");
        
        // TODO: If there is a productImageURL, display using IMG tag
        if(productImage != null)
            out.println(String.format("<img src=displayImage.jsp?id=%s alt='image of product'>", productId)); 
            
        out.println("<p> <b>id:</b> " + productId + "</p> ");
        out.println("<p> <b>price:</b>" + productPrice + "</p>");
        
        // TODO: Add links to Add to Cart and Continue Shopping
        out.println("<h2> <a href=listprod.jsp?productName=''>Continue Shopping</a></h2>");
        out.println(String.format("<tr><td><a href='%s'>Click to add to cart</a></td><td>",link)+
            "</td></tr>");
        
    }
} catch (SQLException ex) 
{ 	out.println(ex); 
}
		
		
%>

</body>
</html>