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
						if (loggedIn) out.println("<p><a href='myaccount.jsp' style='color:white'>My Account</a> <a href='logout.jsp' style='color:white'>LogOut</a></p>");
						else{
								out.println("Not currently logged in.");
						}
						%>
			</li>
		</ul>
	</div>
        
        <div>
                <h1 class="main">Proper Tech</h1>
                <p class="main"> The right solution for your gaming needs</p>
        </div>

<div class="main">

        <ul class="nav"> 
                <li class="nav"><a href="listprod.jsp">Shop</a></li>

                <li class="nav"><a href="listorder.jsp">Order Details</a></li>

                <li class="nav"><a href="customer.jsp">Customer Information</a></li>

                <li class="nav"><a href="admin.jsp">Administrators</a></li>
	
		<li class="nav"><a href="inventory.jsp">Inventory</a></li>
        </ul>
<div class='text'>
<h1 style="color:white;"><b>About Us</b></h1>
At Proper tech we specialize in providing cutting edge computer components. We pride ourselves on our extensive library of high-quality gaming components. Customer can build their ideal PC to suit their gaming needs. We aim to accommodate all gamers, whether you are looking for a high-end gaming rig, or a starter PC that can still give you the edge that you’re looking for.
</div>
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


