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
<h2 class='login'>Enter your customer id and password to complete the transaction:</h2>

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

