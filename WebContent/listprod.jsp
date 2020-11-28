<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Ethan Grocery</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input id="search" type="text" name="productName" size="50" >
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for

String name = request.getParameter("productName");

if (name == null || name.isEmpty()) {
	out.print(String.format("<h1>All Products</h1>"));
}else {
	out.print(String.format("<h1>Products containing '%s'</h1>",name));
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
	out.println("<table id='myTable'><tr><th>Add to cart</th><th>Product Name</th><th>Price</th></tr>");
	while (rst.next()){
		String productId = rst.getString(1);
		String productName = rst.getString(2);
		double productPrice = rst.getDouble(3);
		String link = String.format("addcart.jsp?id=%s&name=%s&price=%s",productId,productName,productPrice);
		if (name==null || name.isEmpty()){
			out.println(String.format("<tr><td><a href='%s'>Click to add to cart</a></td><td>",link)+
				String.format("<a href='product.jsp?id=%s'>",productId)+productName+"</a>"+
				"</td><td>"+
				productPrice+
				"</td></tr>");
		}else{
			if (productName.toLowerCase().contains(name.toLowerCase())){
			 	out.println(String.format("<tr><td><a href='%s'>Click to add to cart</a></td><td>",link)+
					productName+
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

</body>
</html>