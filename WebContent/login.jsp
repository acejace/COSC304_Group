<!DOCTYPE html>
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
                                out.println("<a href='login.jsp' style='color:white'>Login</a> OR <a href='createuser.jsp' style='color:white'>Register</a>");
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
        
        <div>
                <h1 class="main">Proper Tech</h1>
                <p class="main"> The right solution for your gaming needs</p>
        </div>
<div class='main'>
	<h2 class='login' style='color: white;' >Please Login to System</h2>

<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null)
	out.println("<p style='color:white;'>"+session.getAttribute("loginMessage").toString()+"</p>");
%>

<br>
<form name="MyForm" method=post action="validateLogin.jsp">
<table style="display:inline; width=10%">
<tr>
	<td><div align="left">Username:</div></td>
	<td><input type="text" name="username"  maxlength=10></td>
</tr>
<tr>
	<td><div align="left">Password:</div></td>
	<td><input type="password" name="password" maxlength="10"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Log In" >
</form>

<form name="createAcc" method=post action="createuser.jsp">
<table style="display:inline">
<input class="submit" type="submit" name="Submit3" value="Create Account">
</table>
</form>

</div>

</body>
</html>

