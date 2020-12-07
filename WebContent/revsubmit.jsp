<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime"%>
<%@ page language="java" import="java.io.*,java.sql.*"%>

<%@ include file="revprod.jsp" %>
<html>
<head>
    <link href="css/bootstrap.min.css" rel="stylesheet">
        <title>Proper Tech</title>
</head>
<body>
<%

int rating = Integer.parseInt(request.getParameter("myRange"));
String review = request.getParameter("review");

int prodId = Integer.parseInt(productId);
int custId = Integer.parseInt(customerId);

try 
{
    getConnection();
    String sqlcheck = "Select * FROM review WHERE productId = ? and customerId = ?";
    PreparedStatement pstmt = con.prepareStatement(sqlcheck);
    pstmt.setInt(1, prodId);
    pstmt.setInt(2, custId);
    ResultSet rst = pstmt.executeQuery();
   
    if(!rst.next()){
    
    String sql = "INSERT INTO review(reviewRating,reviewDate,customerId,productId,reviewComment) VALUES(?,?,?,?,?)";
    pstmt = con.prepareStatement(sql);

    pstmt.setInt(1, rating);

    DateTimeFormatter sdtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	LocalDateTime currenttime = LocalDateTime.now(); 
    pstmt.setString(2, sdtf.format(currenttime));

    pstmt.setInt(3, custId);
    pstmt.setInt(4, prodId);

    pstmt.setString(5, review);

    pstmt.executeUpdate();  
    out.println(String.format("<h1>Review submitted.</h1>"));
}else
    out.println(String.format("<h1>You have alread reviewed this product.</h1>"));
	
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
</head>