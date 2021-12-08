<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<html>
    <title>SpaceNStuff</title>

<body   style="background-color:grey;padding: 6px;">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<div class="text-white">
<% // Get product name to search for
String fname = request.getParameter("fname");
String lname = request.getParameter("lname");
String email = request.getParameter("email");

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
//changed to number of categories
List<Integer> id= new ArrayList<Integer>();

//conects and prints out names
try(Connection con = DriverManager.getConnection(url, uid, pw))
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	PreparedStatement Pstmt = con.prepareStatement("SELECT firstName,lastName,email,customerId FROM customer WHERE firstName = ? AND lastName = ? AND email=?");
	Pstmt.setString(1,fname);
    Pstmt.setString(2,lname);
	Pstmt.setString(3,email);
    ResultSet rst = Pstmt.executeQuery();	
    if(rst.next()){
        out.println("<h1 >Enter new Password: </h1>");
        out.println("<form  action=\"saveNew.jsp\"><input align=\"center\" type=\"text\" name=\"new\"><br>Check this box to prove you not a robot. <input align=\"center\" type=\"checkbox\" name=\"id\" value=\"" +rst.getInt(4)+"\"><br><input align=\"center\" type=\"submit\" Value=\"Submit\" class=\"btn btn-outline-light\"></form>");
    }else{
        out.println("<p>  THAT ISNT RIGHT, TRY AGAIN.</p>");
    }
}
%>
</div>
</html>