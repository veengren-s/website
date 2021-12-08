<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<html>
    <title>SpaceNStuff</title>

    <body   style="background-color:grey;padding: 6px;">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        
<%
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
try(Connection con = DriverManager.getConnection(url, uid, pw))
{	// Load driver class
    String newz = request.getParameter("new");
    String id = request.getParameter("id");

	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	PreparedStatement Pstmt = con.prepareStatement("UPDATE customer SET password = ? WHERE customerId=?");
    Pstmt.setString(1,newz);
    Pstmt.setString(2,id);
    Pstmt.executeUpdate();
    
    out.println("<h1 class=\"text-white\" align=\"center\">Password has been reset</h1>");
    out.println("<h1  align=\"center\"><a  href = \"logout.jsp\"> <button class=\"btn btn-outline-light\"><h1 class=\"text-white\">Return to Main Page</h1></button></a></h1>");

}
%></body></html?