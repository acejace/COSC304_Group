<%@ page language="java" import="java.io.*,java.sql.*,java.util.ArrayList"%>
<%@ include file="jdbc.jsp" %>
<html>

<head>
    <title>Edit User</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script>
    $(document).ready(function (){
        alert("this loaded");
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
    Statement stmt = con.createStatement();
    String sql = "";
    String delOrChange = request.getParameter("requests");
    String id = request.getParameter("id");
    //int check = Integer.parseInt(delOrChange);
    //out.print(delOrChange);
    if(delOrChange.equalsIgnoreCase("0")){
        String name = request.getParameter("name");
        String price = request.getParameter("price");
        String imgURL = request.getParameter("url");
        String desc = request.getParameter("desc");
        String catId = request.getParameter("catId");
        sql = String.format("UPDATE product SET productName = %s, productPrice = %s, ",name,price);
        sql += String.format("productImageURL = %s, productDesc = %s, categoryId = %s ",imgURL, desc, catId);
        sql += String.format("WHERE productId = %s ", id);
        out.print("has been updated");
    
    }else{
        sql = String.format("Delete product WHERE productId = %s", id);
        out.print("Has been deleted");
    }

    
    ResultSet rst = stmt.executeQuery(sql);
 
    
}catch(Exception ex){
    System.out.print(ex);
}
%>
</body>
</html>