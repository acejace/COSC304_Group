<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<head>
	<link rel="stylesheet" href="css/homeStyle.css">
	<title>Proper Tech</title>
</head>
<body>        <div class="header">
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
<h1 class="main">Register Your Account</h1>
<div class='main'>
<%
// Print prior error login message if present
if (session.getAttribute("createMessage") != null)
	out.println("<p>"+session.getAttribute("createMessage").toString()+"</p>");
%>

<form name="MyForm" method=post action="createAccount.jsp">
<table style="display:inline">

<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">First Name:</font></div></td>
	<td><input type="text" name="firstName"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Last Name:</font></div></td>
	<td><input type="text" name="lastName"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Email:</font></div></td>
	<td><input type="text" name="email"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Phone Number:</font></div></td>
	<td><input type="text" name="phonenum"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Address:</font></div></td>
	<td><input type="text" name="address"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">City:</font></div></td>
	<td><input type="text" name="city"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">State:</font></div></td>
	<td><input type="text" name="state"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">PostalCode:</font></div></td>
	<td><input type="text" name="postalcode"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Country:</font></div></td>
	<td><input type="text" name="country"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
	<td><input type="text" name="username"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
	<td><input type="password" name="password" size=10 maxlength="10"></td>
</tr>

</table>
<br/>

<input class="submit" type="submit" name="Submit3" value="Create Account">
</form>


</div>


</body>
</html>
