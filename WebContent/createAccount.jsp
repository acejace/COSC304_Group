<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>

<%
// GET DATA
String firstName = request.getParameter("firstName");
String lastName = request.getParameter("lastName");
String email = request.getParameter("email");
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
}else if(email == null || email.equals("")) {
    session.setAttribute("createMessage","Please Fill In Your Email");
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
        /**
        String sql1 = "SET IDENTITY_INSERT customer ON";
        PreparedStatement pstmt1 = con.prepareStatement(sql1);
        pstmt1.executeUpdate();
        **/
		String sql = "INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country,userid, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = con.prepareStatement(sql);
        //pstmt.setInt(1, 15);            // cust id
        pstmt.setString(1, firstName);
        pstmt.setString(2, lastName);
        pstmt.setString(3, email);
        pstmt.setString(4, phone);
        pstmt.setString(5, address);
        pstmt.setString(6, city);
        pstmt.setString(7, state);
        pstmt.setString(8, postal);
        pstmt.setString(9, country);
        pstmt.setString(10, username);
        pstmt.setString(11, password);
		pstmt.executeUpdate();

        // SEND USER BACK TO LOGIN PAGE
        closeConnection();
        session.setAttribute("loginMessage","You Have Succsessfully Created Your account");
        response.sendRedirect("login.jsp");
    }catch(SQLException ex) {
        out.println(ex);
    }finally {
    
    }
    
}
%>