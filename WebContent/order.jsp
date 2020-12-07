<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Jace's Grocery Order Processing</title>
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

<% 

String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";


if (custId == null || custId.equals("")) {
	out.println("<h1>Invalid Customer Id</h1>");
}else if (productList == null) {
	out.println("<h1>Your Shopping Cart Is Empty</h1>");
	
}else{
	out.println(custId);

	// check if customer id is a number
	int num = -1;
	try {
		num = Integer.parseInt(custId);
	} catch (Exception e) {
		out.println("<h1>Invalid Customer Id. Try Again</h1>");
		return;
	}
}

String sql = "SELECT customerId, firstName+ ' ' +lastName From Customer WHERE customerId = ?";
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

try ( Connection con = DriverManager.getConnection(url, uid, pw);)
{
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, Integer.parseInt(custId));
	ResultSet rst = pstmt.executeQuery();
	int orderId = 0;
	String custName = "";

	if (!rst.next()) {
		out.println("<h1>Invalid customer id.</h1>");
	}else {
		custName = rst.getString(2);
		
	sql = "INSERT INTO ordersummary(orderDate,customerId) VALUES(?, ?) "; 

	DateTimeFormatter sdtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	LocalDateTime currenttime = LocalDateTime.now(); 

	pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
	pstmt.setString(1, sdtf.format(currenttime));
	pstmt.setString(2, custId);
	pstmt.executeUpdate();

	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	orderId = keys.getInt(1);

	out.println("<h1>Your Order Summary</h1>");
	out.println("<table><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th>");

	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();

	Double total = 0.00;
	while (iterator.hasNext()){ 
		try {
			Map.Entry<String, ArrayList<Object>> entry = iterator.next();
			ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		
			String productId = (String) product.get(0);
       		String price = (String) product.get(2);
			double pr = Double.parseDouble(price);
			int qty = ( (Integer)product.get(3)).intValue();
		
			sql = "INSERT INTO orderproduct (orderId, productId, Quantity, price) VALUES(?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, orderId);
			pstmt.setInt(2, Integer.parseInt(productId));
			pstmt.setInt(3, qty);
			pstmt.setString(4, price);
			pstmt.executeUpdate();
		
			total = total + pr*qty;

			sql = "SELECT productName FROM product WHERE productId = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, productId);
			rst = pstmt.executeQuery();
			
			while(rst.next()) 
			out.println("<tr><td>" + productId + "</td><td>" + rst.getString(1) + "</td><td>"+ qty + "</td><td>" + currFormat.format(pr) + "</td><td>"+ currFormat.format(pr*qty) + "</td></tr>");
			
		}
			catch(Exception e){
			out.println(e);
		}
	
	}

	out.println("<tr><th>Order Total</th><td>" + currFormat.format(total) + "</td></tr></table>");

	sql = "UPDATE orderSummary SET totalAmount = ? WHERE orderId= ?";
	pstmt = con.prepareStatement(sql);
	pstmt.setDouble(1, total); 
	pstmt.setInt(2, orderId); 
	pstmt.executeUpdate();

	out.println("<h1>Order completed. Will be shipped soon</h1>");
	out.println("<h1>Your order reference number is: " + orderId + "</h1>");
	out.println("<h1>Shipping to customer: " + custId + " Name: " + custName +"</h1>");
	String link = String.format("ship.jsp?id=%d&cusID=%s",orderId,custId);
	out.println(String.format("<h2><a href='%s'>Shipment details</a></h2>",link));
	out.println("<h2><a href = \"shop.html\">Return to shopping</a></h2>");

	session.setAttribute("productList", null);

}

} catch(SQLException ex){
	out.print(ex);
}

%>
</BODY>
</HTML>

