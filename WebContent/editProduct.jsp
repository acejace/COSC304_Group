<html>
<head>
    <title>Edit User</title>
    //gets ajax lib for use
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script>
        const inputs = new Array();
        //waits for document to fully load
        $(document).ready(function () {
            //If the change button is clicked this function is executed
            $("#Change").click(function (e) {
                //prevents redirect and regurlar submission
                e.preventDefault();
                inputs[0] = (document.getElementById("name").value);
                //Changes so spaces can be within the name
                inputs[0] = inputs[0].replaceAll(' ', '%27');
                inputs[1] = (document.getElementById("price").value);
                inputs[2] = (document.getElementById("url").value);
                inputs[3] = (document.getElementById("desc").value);
                inputs[3] = inputs[3].replaceAll(' ', '%27');
                inputs[4] = (document.getElementById("catId").value);
                inputs[5] = (document.getElementById("id").value);
                //Any out.print will be printed to form-msg and async redirects to the backend to update
                $("#form-msg").load("editProductBackend.jsp?id=" + inputs[5] + "&name=" + inputs[0] + "&price=" + inputs[1] + "&url=" + inputs[2] + "&desc=" + inputs[3] + "&catId=" + inputs[4] + "&requests=0");
            });

            $("#Delete").click(function (e) {
                e.preventDefault();
                inputs[0] = (document.getElementById("name").value);
                inputs[0] = inputs[0].replaceAll(' ', '%27');
                inputs[1] = (document.getElementById("price").value);
                inputs[2] = (document.getElementById("url").value);
                inputs[3] = (document.getElementById("desc").value);
                inputs[3] = inputs[3].replaceAll(' ', '%27');
                inputs[4] = (document.getElementById("catId").value);
                inputs[5] = (document.getElementById("id").value);
                $("#form-msg").load("editProductBackend.jsp?id=" + inputs[5] + "&name=" + inputs[0] + "&price=" + inputs[1] + "&url=" + inputs[2] + "&desc=" + inputs[3] + "&catId=" + inputs[4] + "&requests=1");
            });
        });
    </script>
</head>


<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
String firstId = request.getParameter("id");
int id = Integer.parseInt(firstId);

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
Connection con = DriverManager.getConnection(url, uid, pw);

String sql = "Select * From product Where productId = " + id;
Statement stmt = con.createStatement();
ResultSet rst = stmt.executeQuery(sql);

rst.next();
id = rst.getInt(1);
String name = rst.getString(2);
double price = rst.getDouble(3);
String picURL = rst.getString(4);
String image = rst.getString(5);
String productDesc = rst.getString(6);
int categoryId = rst.getInt(7);

%>

<body>
    <div style="text-align:center; display: block;">
        <h1>Change Product</h1>
        <form name="updateForm" method=POST action="admin.jsp">
            <table style="display:inline">
                <tr>
                    <td>
                        <div align="right">
                            <font face="Arial, Helvetica, sans-serif" size="2">Product Name:</font>
                        </div>
                    </td>
                    <td><input type="text" id="name" name="Product Name" value='<%out.print(String.format("%s",name));%>'>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div align="right">
                            <font face="Arial, Helvetica, sans-serif" size="2">Price:</font>
                        </div>
                    </td>
                    <td><input type="number" id="price" name="Price" value=<%out.print(String.format("%s",price));%>>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div align="right">
                            <font face="Arial, Helvetica, sans-serif" size="2">imageURL</font>
                        </div>
                    </td>
                    <td><input type="text" id=url name="URL" value='<%out.print(String.format("%s",picURL));%>'></td>
                </tr>
                <tr>
                    <td>
                        <div align="right">
                            <font face="Arial, Helvetica, sans-serif" size="2">Product Description:</font>
                        </div>
                    </td>
                    <td><input type="text" id="desc" name="Description"
                            value='<%out.print(String.format("%s",productDesc));%>'></td>
                </tr>
                <tr>
                    <td>
                        <div align="right">
                            <font face="Arial, Helvetica, sans-serif" size="2">Category ID:</font>
                        </div>
                    </td>
                    <td><input type="number" id="catId" name="address"
                            value=<%out.print(String.format("%d",categoryId));%>></td>
                </tr>
                <tr>
                    <td><input type="number" hidden=true id="id" name="productId"
                            value=<%out.print(String.format("%d",id));%>></td>
                </tr>
            </table>
            <br />
            <input class="submit" type="submit" name="Change" id="Change" value="Change Product">
            <input class="submit" type="submit" name="Delete" id="Delete" value="Delete Product">
            <p id="form-msg"></p>
        </form>


    </div>
</body>

</html>