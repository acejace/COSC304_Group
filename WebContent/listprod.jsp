<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
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
<h1 class="main">Products</h1>
<div class="main" >
	<br>
<h2 class='products' style="font-size: 2vw;"> Search for your product: </h2>
<form method="get" action="listprod.jsp">
<input id="search" class='search' type="text" name="productName" size="50" >
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for

String name = request.getParameter("productName");

if (name == null || name.isEmpty()) {
	out.print(String.format("<h2 class='products'>Currently Displaying All Products</h2>"));
}else {
	out.print(String.format("<h2 class='products'>Products containing '%s'</h3>",name));
}


String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";		

//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection
try ( Connection con = DriverManager.getConnection(url, uid, pw);
      PreparedStatement pstmt = con.prepareStatement("SELECT productId,productName,productPrice FROM product");) 
{		
	ResultSet rst = pstmt.executeQuery();		
	out.println("<table id='myTable' class='products'><tr><th>Add to cart</th><th>Product Name</th><th>Price</th></tr>");
	while (rst.next()){
		String productId = rst.getString(1);
		String productName = rst.getString(2);
		NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
		String productPrice = (currFormat.format(rst.getDouble(3)));
		double numPrice = rst.getDouble(3);

		String link = String.format("addcart.jsp?id=%s&name=%s&price=%f",productId,rst.getString(2).replaceAll("'","%27"),numPrice);
		if (name==null || name.isEmpty()){
			out.println(String.format("<tr><td><a href='%s'>Click to add to cart</a></td><td>",link)+
				String.format("<a href='product.jsp?id=%s'>",productId)+productName+"</a>"+
				"</td><td>"+
				productPrice+
				"</td></tr>");
		}else{
			if (productName.toLowerCase().contains(name.toLowerCase())){
				out.println(String.format("<tr><td><a href='%s'>Click to add to cart</a></td><td>",link)+
					String.format("<a href='product.jsp?id=%s'>",productId)+productName+"</a>"+
					"</td><td>"+
					productPrice+
					"</td></tr>");
			}
			
		}
	}
	out.println("</table>");
	out.close();
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
%>
</div>
</body>
</html>