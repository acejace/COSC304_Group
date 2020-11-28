<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>YOUR NAME Grocery Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
	// TODO: Get order id
	String orderId = request.getParameter("orderId");

	String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
	String uid = "SA";
	String pw = "YourStrong@Passw0rd";		

	try{
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	}catch (java.lang.ClassNotFoundException e){
		out.println("ClassNotFoundException: " +e);
	}
	String sql = "";

	try ( Connection con = DriverManager.getConnection(url, uid, pw);
      Statement stmt = con.createStatement();){
		// TODO: Check if valid order id
		if(orderId == null){
			out.println("<h1>invalid Id</h1>");
		}else {
			// TODO: Start a transaction (turn-off auto-commit)
			con.setAutoCommit(false);
			// TODO: Retrieve all items in order with given id
			ResultSet rst = stmt.executeQuery(String.format("SELECT productId, quantity FROM orderproduct WHERE orderId = %s",orderId));

			// TODO: Create a new shipment record. -----------------------------DONT UNDERSTAND THIS at all someone help
			//stmt.executeUpdate("INSERT INTO shipment")--

			// TODO: For each item verify sufficient quantity available in warehouse 1.
			boolean validOrder = true;
			while(rst.next()){
				String productId = rst.getString(1);
				int orderQuant = rst.getInt(2);
				String sql2 = String.format("SELECT quantity FROM productinventory WHERE productId =%s", productId);
				ResultSet rst2 = stmt.executeQuery(sql2);
				int warehouseQuant = rst.getInt(1);
				// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
				int newQuant = warehouseQuant - orderQuant;
				out.println(String.format("<h2>Ordered product: %s Qty: %s Previous inventory: %s New inventory: %s", productId, orderQuant, warehouseQuant, newQuant));
				if(newQuant >= 0){
					out.println(String.format("<h1>Shipment not done. Insufficient inventory for product id: %s </h1>",productId));
					con.rollback();
					validOrder = false;
					break;
				}else
					stmt.executeUpdate("UPDATE productinventory SET quantity = %s WHERE productId = %s", newQuant, productId);

			}
			if(validOrder){
				con.commit();
				out.println("<h1>Shipment successfully processed.</h1>");
			}
			out.println("<h2><a href=index.jsp>Back to Main Page</a></h2>")
			// TODO: Auto-commit should be turned back on
			con.setAutoCommit(true);


		}

}
	
	
	
	
	
	
%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>
