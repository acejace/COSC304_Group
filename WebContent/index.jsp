<!DOCTYPE html>
<%@ include file="jdbc.jsp" %>
<html>
<head>
        <link rel="stylesheet" href="homeStyle.css">
        <title>PcSolutions</title>
</head>
<body>
        <div class="background">
                <h1 align="center">PcSolutions</h1>
        </div>


<h2 align="center"><a href="login.jsp">Login</a></h2>

<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

<h2 align="center"><a href="logout.jsp">Log out</a></h2>

<%
// TODO: Display user name that is logged in (or nothing if not logged in)
String username = (String)session.getAttribute("authenticatedUser");

if (username != null) {
        out.println("<h3 align='center'>Signed In As: "+ username +"</h1>");
}

%>
</body>
</head>


