<!DOCTYPE html>
<%@ include file="jdbc.jsp" %>
<html>
<head>
        <link rel="stylesheet" href="css/homeStyle.css">
        <title>Proper Tech</title>
</head>
<body>
        <div class="header">
                <ul class="header"> 
                        <li class="header"><a href="login.jsp" style="color:white">Login</a> OR <a href="login.jsp" style="color:white">Register</a></li>
                        <li class="header"><a href="index.jsp" style="color:white">Home</a></li>
                        <li class="header"><a href="logout.jsp" style="color:white">LogOut</a></li>
                </ul>
        </div>
        
        <div>
                <h1 class="main">Proper Tech</h1>
                <p class="main"> The right solution for your gaming needs</p>
        </div>

<div class="main">

        <ul class="nav" > 
                <li class="nav"><a href="listprod.jsp">Begin Shopping</a></li>

                <li class="nav"><a href="listorder.jsp">List All Orders</a></li>

                <li class="nav"><a href="customer.jsp">Customer Info</a></li>

                <li class="nav"><a href="admin.jsp">Administrators</a></li>
        </ul>

</div>

<%
// TODO: Display user name that is logged in (or nothing if not logged in)
String username = (String)session.getAttribute("authenticatedUser");

if (username != null) {
        out.println("<h3 align='center'>Signed In As: "+ username +"</h1>");
}

%>
</body>
</head>


