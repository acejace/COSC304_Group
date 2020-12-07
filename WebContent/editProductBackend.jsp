<%@ page language="java" import="java.io.*,java.sql.*,java.util.ArrayList"%>
<%@ include file="jdbc.jsp" %>
<html>
<head>
    <title>Edit User</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script>
    $(document).ready(function (){
        
    });
    </script>
</head>
<body>
<% 
try{
    String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
    String uid = "SA";
    String pw = "YourStrong@Passw0rd";
    Connection con = DriverManager.getConnection(url, uid, pw);
    String sql = "";
    String delOrChange = request.getParameter("requests");
    String id = request.getParameter("id");
    if(delOrChange.equalsIgnoreCase("0")){
        String name = request.getParameter("name");
        String price = request.getParameter("price");
        String imgURL = request.getParameter("url");
        String desc = request.getParameter("desc");
        String catId = request.getParameter("catId");
        sql = String.format("UPDATE product SET productName = '%s', productPrice = %s, ",name,price);
        sql += String.format("productImageURL = '%s', productDesc = '%s', categoryId = %s ",imgURL, desc, catId);
        sql += String.format("WHERE productId = %s", id);
        out.println("Has been Updated\n");
    
    }else{
        sql = String.format("Delete product WHERE productId = %s", id);
        out.println("Has been Deleted\n");
    }

    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.executeUpdate();
 
    
}catch(Exception ex){
    out.println(ex);
}
%>
</body>
</html>