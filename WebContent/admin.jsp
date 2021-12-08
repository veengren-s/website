<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<title>SpaceNStuff|Administration</title>
</head>
<body style="background-color: grey;">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<div class="text-white">
		<div class="navbar navbar-dark bg-white">
			<ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
			  <li><a href="listprod.jsp" class="nav-link px-2 link-dark">Shop</a></li>
			  <li><a href="customer.jsp" class="nav-link px-2 link-dark">Customer Info</a></li>
			  <li><a href="admin.jsp" class="nav-link px-2 link-secondary">Administration</a></li>
			  <li><a href="listOrder.jsp" class="nav-link px-2 link-dark">List all orders</a></li>
			  <li><a href="showcart.jsp" class="nav-link px-2 link-dark">Cart</a></li>
			</ul>
			<%
			String userNamez = (String) session.getAttribute("authenticatedUser");
			if (userNamez != null)
				out.println("<h6>Signed Into: "+userNamez+"</h6>");
		%>
		  </div>
<%
	String userName = (String) session.getAttribute("authenticatedUser");

	String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
	String uid = "SA";
	String pw = "YourStrong@Passw0rd";
	Connection con = DriverManager.getConnection(url, uid, pw);


// Print out total order amount by day
String sql = "select year(orderDate), month(orderDate), day(orderDate), SUM(totalAmount), COUNT(orderId) FROM OrderSummary GROUP BY year(orderDate), month(orderDate), day(orderDate)";

NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try 
{	
	out.println("<h3 align=\"center\">Administrator Sales Report by Day</h3>");
	
	
	ResultSet rst = con.createStatement().executeQuery(sql);		
	out.println("<table class=\"table table-hover text-white\" border=\"1\">");
	out.println("<tr><th>Order Date</th><th>Total Order Amount</th><th>Total orders </th>");	

	while (rst.next())
	{
		out.println("<tr><td>"+rst.getString(1)+"-"+rst.getString(2)+"-"+rst.getString(3)+"</td><td>"+currFormat.format(rst.getDouble(4))+"</td><td>"+rst.getString(5)+"</td></tr>");
	}
	out.println("</table>");	
	
	out.println("<h3 align=\"center\">Customer list</h3>");
	PreparedStatement pstmt2 = con.prepareStatement("SELECT firstName, lastName FROM customer");
	ResultSet rst2 = pstmt2.executeQuery();

	out.println("<table class=\"table table-hover text-white\" border=\"1\">");
	out.println("<tr><th>First Name</th><th>Last Name</th>");	

	while (rst2.next())
	{
		out.println("<tr><td>"+rst2.getString(1)+"</td><td>"+rst2.getString(2)+"</td></tr>");
	}
	out.println("</table>");	

	out.println("<h3 align=\"center\">Warehouse Inventory</h3>");
	PreparedStatement pstmt3 = con.prepareStatement("SELECT warehouseId, productId, quantity FROM productInventory");
	ResultSet rst3= pstmt3.executeQuery();

	out.println("<table class=\"table table-hover text-white\" border=\"1\">");
		out.println("<tr><th>WarehouseId</th><th>Product Id </th><th>Quantity</th>");	
	
		while (rst3.next())
		{
			out.println("<tr><td>"+rst3.getString(1)+"</td><td>"+rst3.getString(2)+"</td><td>"+rst3.getString(3)+"</td></tr>");
		}
		out.println("</table>");	
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
finally
{	
	closeConnection();	
}
%>
<h2 align="center"><a href="updateProdInventory.jsp"><button class="btn btn-outline-light">Manage Product Inventory</button></a> &nbsp;&nbsp;&nbsp;&nbsp;<a href="logout.jsp"><button class="btn btn-outline-light">Logout</button></a></h2>
</body>
</html>