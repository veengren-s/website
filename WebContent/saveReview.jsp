<%@ page import="java.sql.Date" %>
<%@ page import="java.util.*" %>

<%@ page import="java.io.File" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<% 
String id = request.getParameter("pid");
String com = request.getParameter("cid");
String stars = request.getParameter("stars");
String text = request.getParameter("text");

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
java.util.Date d = new java.util.Date();
java.sql.Date sqlDate = new java.sql.Date(d.getTime());
try(Connection con = DriverManager.getConnection(url, uid, pw))
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	PreparedStatement Pstmt = con.prepareStatement("INSERT INTO review (reviewRating,reviewDate,productId,reviewComment) VALUES (?,?,?,?) ");
	Pstmt.setString(1,stars);
    Pstmt.setDate(2,sqlDate);
	Pstmt.setString(3,id);
	Pstmt.setString(4,text);
    Pstmt.executeUpdate();
}
%>
 <jsp:forward page="listprod.jsp" />