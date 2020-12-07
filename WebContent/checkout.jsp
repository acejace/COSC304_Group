<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<html>
    <head>
        <link rel="stylesheet" href="css/homeStyle.css">
        <title>Proper Tech</title>
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
<h1 class="main">Checkout</h1>
<div class="main">
<%
if (loggedIn){
    try {
        getConnection();
        Statement stmt = con.createStatement();
        String sql = "SELECT customerId FROM Customer WHERE userid = '" + userName +"'";
        PreparedStatement pstmt = con.prepareStatement(sql);
        ResultSet rst = stmt.executeQuery(sql);
        rst.next();
        int customerID = rst.getInt(1);
        out.println("<h2 class='login'> Welcome, "+userName+"! Your customer ID is:"+customerID);
    } catch(Exception e){
        
    }
} else{
    out.println("<h2 class='login'> Welcome, you are not logged in. Log in to get your customer Id!");
}
    %>

<form method="get" action="order.jsp">
<table style="display:inline; width:10%">
<tr><td>Customer ID:</td><td><input type="text" name="customerId" size="20"></td></tr>
<tr><td>Password:</td><td><input type="password" name="password" size="20"></td></tr>
<tr><td><input type="submit" value="Submit"></td><td><input type="reset" value="Reset"></td></tr>
</table>
</form>
</div>
</body>
</html>

