<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
	<title>Products</title>
	<link rel="stylesheet" href="css/homeStyle.css">
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
							if (loggedIn) out.println("<a href='logout.jsp' style='color:white'>LogOut</a>");
							else{
									out.println("Not currently logged in.");
							}
							%>
					</li>
			</ul>
		</div>
		<h1 class="main">Product</h1>
<div class="main">
<%
// Get product name to search for
String productId = request.getParameter("id");

String sql = "SELECT productId, productName, productPrice, productImageURL, productImage FROM Product P  WHERE productId = ?";

try 
{
	getConnection();
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, Integer.parseInt(productId));			
	
	ResultSet rst = pstmt.executeQuery();
			
	if (!rst.next())
	{
		out.println("Invalid product");
	}
	else
	{		
		out.println("<h2 class='products' style='padding-left:0%'>"+rst.getString(2)+"</h2>");
		NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
		String productPrice = (currFormat.format(rst.getDouble(3)));
		int prodId = rst.getInt(1);
		out.println("<table style=><tr>");
		out.println("<th style='text-align: right;'> Product Id</th><td style='text-align: left;'>" + prodId + "</td></tr>"				
				+ "<tr><th style='text-align: right;'>Price</th><td style='text-align: left;'>" + productPrice + "</td></tr>");
		
		//  Retrieve any image with a URL
		String imageLoc = rst.getString(4);
		if (imageLoc != null)
			out.println("<img src=\""+imageLoc+"\">");
		
		// Retrieve any image stored directly in database
		String imageBinary = rst.getString(5);
		if (imageBinary != null)
			out.println("<img src=\"displayImage.jsp?id="+prodId+"\">");	
		out.println("</table>");
		

		out.println("<h3><a href=\"addcart.jsp?id="+prodId+ "&name=" + rst.getString(2)
								+ "&price=" + rst.getDouble(3)+"\">Add to Cart</a></h3>");		
		
		out.println("<h3><a href=\"listprod.jsp\">Continue Shopping</a>");
	}
} 
catch (SQLException ex) {
	out.println(ex);
}
finally
{
	closeConnection();
}
%>
</div>
</body>
</html>

