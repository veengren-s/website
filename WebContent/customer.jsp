<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>


<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body style="background-color: grey;">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<div class="navbar navbar-dark bg-white">
	<ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
	  <li><a href="listprod.jsp" class="nav-link px-2 link-dark">Shop</a></li>
	  <li><a href="customer.jsp" class="nav-link px-2 link-secondary">Customer Info</a></li>
	  <li><a href="admin.jsp" class="nav-link px-2 link-dark">Administration</a></li>
	  <li><a href="listOrder.jsp" class="nav-link px-2 link-dark">List all orders</a></li>
	  <li><a href="showcart.jsp" class="nav-link px-2 link-dark">Cart</a></li>
	</ul>
	<%
	String userNamez = (String) session.getAttribute("authenticatedUser");
	if (userNamez != null)
		out.println("<h6>Signed Into: "+userNamez+"</h6>");
%>
  </div>
<div style = "padding: 5px;" class="text-white">

<%
String userName = (String) session.getAttribute("authenticatedUser");
if (userName != null)
	out.println("<h3 align=\"center\">Signed in as: "+userName+"</h3>");

// Print Customer information
String sql = "select customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password FROM Customer WHERE userid = ?";
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

Connection con = DriverManager.getConnection(url, uid, pw);

	out.println("<h3 align=\"center\">Customer Profile</h3>");
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, userName);	
	ResultSet rst = pstmt.executeQuery();
	
	if (rst.next())
	{
		out.println("<table align=\"center\" class=\"table table-hover text-white\" border=\"1\">");
		out.println("<tr><th>Id</th><td>"+rst.getString(1)+"</td></tr>");	
		out.println("<tr><th>First Name</th><td>"+rst.getString(2)+"</td></tr>");
		out.println("<tr><th>Last Name</th><td>"+rst.getString(3)+"</td></tr>");
		out.println("<tr><th>Email</th><td>"+rst.getString(4)+"</td></tr>");
		out.println("<tr><th>Phone</th><td>"+rst.getString(5)+"</td></tr>");
		out.println("<tr><th>Address</th><td>"+rst.getString(6)+"</td></tr>");
		out.println("<tr><th>City</th><td>"+rst.getString(7)+"</td></tr>");
		out.println("<tr><th>State</th><td>"+rst.getString(8)+"</td></tr>");
		out.println("<tr><th>Postal Code</th><td>"+rst.getString(9)+"</td></tr>");
		out.println("<tr><th>Country</th><td>"+rst.getString(10)+"</td></tr>");
		out.println("<tr><th>User id</th><td>"+rst.getString(11)+"</td></tr>");		
		out.println("</table>");
	}

%>
<br>
<h2 align="center"><a class="text-white" style="text-decoration: none;color: inherit;" href="editInformation.jsp"><button class="btn btn-outline-light"> Edit your personal information</button></a>&nbsp;&nbsp;&nbsp;&nbsp;<a class="text-white" style="text-decoration: none;color: inherit;" href="index.jsp"><button class="btn btn-outline-light"> to Main Shop</button></a></h2>
</div>
</body>
</html>

