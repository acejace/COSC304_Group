<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>

<%
// GET DATA
String firstName = request.getParameter("firstName");
String lastName = request.getParameter("lastName");
String phone = request.getParameter("phonenum");
String address = request.getParameter("address");
String city = request.getParameter("city");
String state = request.getParameter("state");
String postal = request.getParameter("postalcode");
String country = request.getParameter("country");
String username = request.getParameter("username");
String password = request.getParameter("password");

// VALIDATE DATA
session.removeAttribute("createMessage"); //reset to Null

if(firstName == null || firstName.equals("")) {
    session.setAttribute("createMessage","Please Fill In Your First Name");
    response.sendRedirect("createuser.jsp");
}else if(lastName == null || lastName.equals("")) {
    session.setAttribute("createMessage","Please Fill In Your Last Name");
    response.sendRedirect("createuser.jsp");
}else if(phone == null || phone.equals("")) {
    session.setAttribute("createMessage","Please Fill In Your Phone Number");
    response.sendRedirect("createuser.jsp");
}else if(address == null || address.equals("")) {
    session.setAttribute("createMessage","Please Fill In Your Address");
    response.sendRedirect("createuser.jsp");
}else if(city == null || city.equals("")) {
    session.setAttribute("createMessage","Please Fill In Your City");
    response.sendRedirect("createuser.jsp");
}else if(state == null || state.equals("")) {
    session.setAttribute("createMessage","Please Fill In Your State");
    response.sendRedirect("createuser.jsp");
}else if(postal == null || postal.equals("")) {
    session.setAttribute("createMessage","Please Fill In Your Postal");
    response.sendRedirect("createuser.jsp");
}else if(country == null || country.equals("")) {
    session.setAttribute("createMessage","Please Fill In Your Country");
    response.sendRedirect("createuser.jsp");
}else if(username == null || username.equals("")){
	session.setAttribute("createMessage","Please Fill In Your UserName");
    response.sendRedirect("createuser.jsp");
}else if(password == null || password.equals("")) {
    session.setAttribute("createMessage","Please Fill In Your Password");
    response.sendRedirect("createuser.jsp");
}else {
    // CREATE USER
    try {
        getConnection();
        con = DriverManager.getConnection(url, uid, pw);
		String sql = "INSERT INTO customer VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, firstName);
        pstmt.setString(2, lastName);
        pstmt.setString(3, phone);
        pstmt.setString(4, address);
        pstmt.setString(5, city);
        pstmt.setString(6, state);
        pstmt.setString(7, postal);
        pstmt.setString(8, country);
        pstmt.setString(9, username);
        pstmt.setString(10, password);
		pstmt.executeUpdate();

    }catch(SQLException ex) {
        out.println(ex);
    }finally {
    // SEND USER BACK TO LOGIN PAGE
        closeConnection();
        session.setAttribute("loginMessage","You Have Succsessfully Created Your account");
        response.sendRedirect("login.jsp");
    }
}
%>