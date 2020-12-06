<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Create Account</title>
</head>
<body>

<div style="margin:0 auto;text-align:center;display:inline">

<h1>Create Account</h1>

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
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Phone Number:</font></div></td>
	<td><input type="text" name="phonenum"  size=11 maxlength=11></td>
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
	<td><input type="text" name="postalCode"  size=10 maxlength=10></td>
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
