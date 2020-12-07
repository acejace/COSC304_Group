<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>

<%
// Get Data
String address = request.getParameter("address");
String password = request.getParameter("password");
String userName = (String) session.getAttribute("authenticatedUser");

// Validate Data
session.removeAttribute("editMessage"); //reset to Null

if (address == null || address.equals("")) {
    session.setAttribute("editMessage","Please Fill In Your Address");
    response.sendRedirect("myaccount.jsp");
}else if(password == null || password.equals("")) {
    session.setAttribute("editMessage","Please Fill In Your Password");
    response.sendRedirect("myaccount.jsp");
}else {
    // UPDATE USER INFORMATION
    try {
        getConnection();
        con = DriverManager.getConnection(url, uid, pw);
        String sql = "UPDATE customer SET address = '"+address+"', password = '"+password+"' WHERE userId = '"+userName+"'";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.executeUpdate();

        // SEND USER BACK TO MyAccount Page
        closeConnection();
        session.setAttribute("editMessage","You Have Succsessfully Made Changes To Your account");
        response.sendRedirect("myaccount.jsp");
    }catch(SQLException ex) {
        out.println(ex);
    }finally {
        closeConnection();
    }
    
}
%>