<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);
	session.removeAttribute("loginMessage");
	try
	{
		authenticatedUser = validateLogin(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }

	if(authenticatedUser != null)
		response.sendRedirect("index.jsp");		// Successful login
	else
		response.sendRedirect("login.jsp");		// Failed login - redirect back to login page with a message 
%>


<%!
	String validateLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		username = username.toLowerCase();
		String retStr = null;

		if(username == null || password == null)
				return null;
		if((username.length() == 0) || (password.length() == 0))
				return null;


		try 
		{
			getConnection();		
			// TODO: Check if userId and password match some customer account. If so, set retStr to be the username.
			Statement stmt = con.createStatement();
			String sql = "SELECT userid, password FROM customer";
			ResultSet rst = stmt.executeQuery(sql);

			while (rst.next()) {
				String userId = rst.getString(1);
				userId = userId.toLowerCase();
				String pass = rst.getString(2);

				if (username.equals(userId) && password.equals(pass)) {
					retStr = userId;
					break;
				}
			
			}
						
		} 
		catch (SQLException ex) {
			out.println(ex);
		}
		finally
		{
			closeConnection();
		}	
		
		if(retStr != null)
		{	
			session.removeAttribute("loginMessage");
			session.setAttribute("authenticatedUser",username);
		}
		else
			session.setAttribute("loginMessage","Could not connect to the system using that username/password.");

		return retStr;
	}
%>

