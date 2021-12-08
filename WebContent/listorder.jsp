<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
	<title>SpaceNStuff</title>
</head>
<body style="background-color: grey;">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<div class="navbar navbar-dark bg-white">
	<ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
	  <li><a href="listprod.jsp" class="nav-link px-2 link-dark">Shop</a></li>
	  <li><a href="customer.jsp" class="nav-link px-2 link-dark">Customer Info</a></li>
	  <li><a href="admin.jsp" class="nav-link px-2 link-dark">Administration</a></li>
	  <li><a href="listOrder.jsp" class="nav-link px-2 link-secondary">List all orders</a></li>
	  <li><a href="showcart.jsp" class="nav-link px-2 link-dark">Cart</a></li>
	</ul>
	<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
		out.println("<h6>Signed Into: "+userName+"</h6>");
%>
  </div>

<div class="text-white">

<h1 align="center">Order List</h1>

<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

// Write query to retrieve all order summary records
try ( Connection con = DriverManager.getConnection(url, uid, pw)){


    PreparedStatement Opstmt = con.prepareStatement("SELECT ordersummary.orderId, orderDate, ordersummary.customerId, firstName, totalAmount FROM ordersummary JOIN customer ON ordersummary.customerId = customer.customerId");
    PreparedStatement OPpstmt = con.prepareStatement("SELECT productId, quantity, price FROM orderproduct WHERE orderId = ?");
    ResultSet rst = Opstmt.executeQuery();
	out.println("<table align=\"center\" border='1' class=\"table table-hover text-white\"><tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");
    while(rst.next()){
        out.println("<tr><td>"+rst.getString(1)+"</td>"+"<td>"+rst.getString(2)+"</td>"+"<td>"+rst.getString(3)+"</td>"+"<td>"+rst.getString(4)+"</td>"+"<td>"+rst.getString(5)+"</td></tr>");
		OPpstmt.setString(1,rst.getString(1));
		ResultSet rstIn=OPpstmt.executeQuery();
        out.println("<tr><td></td><td></td><td></td><td></td><td ><table border='1'><tr><th>Product Id</th><th>Quantity</th><th>Price</th></tr><td></tr>");
		while(rstIn.next()){
			out.println("<tr><td>"+rstIn.getString(1)+"</td><td>"+rstIn.getString(2)+"</td><td> $"+rstIn.getString(3)+"</td></tr>");
		}
 	out.println("</table></tr>");		
    }
	out.println("</table>");
}
catch (SQLException ex) 
{     out.println(ex); 
}

%>
</div>
</body>
</html>

