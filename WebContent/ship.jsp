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
<title>Jace's Grocery Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>


<%
	// TODO: Get order id
	Integer orderId = Integer.parseInt(request.getParameter("id"));
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
	  Statement stmt = con.createStatement();
	  Statement stmt2 = con.createStatement();){
		
		// TODO: Check if valid order id
		if(orderId == null){
			out.println("<h1>invalid Id</h1>");
		}else {
			// TODO: Start a transaction (turn-off auto-commit)
			con.setAutoCommit(false);
			
			// TODO: Retrieve all items in order with given id
			ResultSet rst = stmt.executeQuery(String.format("SELECT productId, quantity FROM orderproduct WHERE orderId = %d",orderId));
			
			// TODO: Create a new shipment record. -----------------------------
			LocalDateTime currenttime = LocalDateTime.now(); 
			DateTimeFormatter sdtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			
			PreparedStatement pstmt = con.prepareStatement(String.format("INSERT shipment (shipmentDate, shipmentDesc) VALUES (?,'')"));
			pstmt.setString(1, sdtf.format(currenttime));
			pstmt.executeUpdate();

			// TODO: For each item verify sufficient quantity available in warehouse 1.
			boolean validOrder = true;
			int warehouseQuant = 0;
			while(rst.next()){
				int productId = rst.getInt(1);
				int orderQuant = rst.getInt(2);
				
				String sql2 = String.format("SELECT quantity FROM productinventory WHERE productId = ?");
				PreparedStatement pstmt2 = con.prepareStatement(sql2);
				pstmt2.setInt(1, productId);  
				ResultSet rst2 = pstmt2.executeQuery();
				
				while(rst2.next()){
				warehouseQuant = rst2.getInt(1);}

				// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
				int newQuant = warehouseQuant - orderQuant;
				if(newQuant < 0){
					out.println(String.format("<h1>Shipment not done. Insufficient inventory for product id: %d </h1>",productId));
					con.rollback();
					validOrder = false;
					break;
				}else{
					out.println(String.format("<h2>Ordered product: %s Qty: %s Previous inventory: %d New inventory: %d", productId, orderQuant, warehouseQuant, newQuant));
					
					String sql3 = String.format("UPDATE productinventory SET quantity = %d WHERE productId = %d", newQuant, productId);
					PreparedStatement pstmt3 = con.prepareStatement(sql3);
					pstmt3.executeUpdate();
				}
			}

			if(validOrder){
				con.commit();
				out.println("<h1>Shipment successfully processed.</h1>");
			}
			out.println("<h2><a href=index.jsp>Back to Main Page</a></h2>");

			// TODO: Auto-commit should be turned back on
			con.setAutoCommit(true);
		}
}
%>                       				

</body>
</html>
