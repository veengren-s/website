<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<html>
<head>
	<title>SpaceNStuff</title>
</head>
<body   style="background-color:grey;">

	<div class="navbar navbar-dark bg-white">
        <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
          <li><a href="#" class="nav-link px-2 link-secondary">Shop</a></li>
          <li><a href="customer.jsp" class="nav-link px-2 link-dark">Customer Info</a></li>
          <li><a href="admin.jsp" class="nav-link px-2 link-dark">Administration</a></li>
          <li><a href="listOrder.jsp" class="nav-link px-2 link-dark">List all orders</a></li>
		  <li><a href="showcart.jsp" class="nav-link px-2 link-dark">Cart</a></li>
		</ul>
		  <%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
		out.println("<h6>Signed Into: "+userName+"</h6>");
%>
      </div>



	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

<div class="text-center">

<h1 class="text-white">Search for the products you want to buy:</h1>

<form class="text-white " method="get" action="listprod.jsp">
<p>Search by Name:</p>
<input type="text" name="productName" size="50"><br>
<p>Search by category</p>
<select class = "" name="cat" id="cat">
	<option value="0">None</option>
	<option value="1">Nebula</option>
	<option value="2">Star</option>
	<option value="3">Galaxies</option>
</select>
<br>
<br>
<input type="submit" class = "btn  btn-outline-light" value="Submit"><input class = "btn  btn-outline-light" type="reset" value="Reset"> (Leave blank for all products)
</form>
</div>


<% // Get product name to search for
String name = request.getParameter("productName");
String cat = request.getParameter("cat");

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
//changed to number of categories
List<Integer> id= new ArrayList<Integer>();

//conects and prints out names
try(Connection con = DriverManager.getConnection(url, uid, pw))
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	PreparedStatement Pstmt = con.prepareStatement("SELECT productName,product.productId,productPrice,categoryId,productImageURL,quantity FROM product JOIN productinventory ON product.productId = productinventory.productId WHERE productName LIKE ? AND quantity>0");
	Pstmt.setString(1,"%"+name+"%");
    ResultSet rst = Pstmt.executeQuery();
	out.println("<table class=\"table table-hover text-white\">");
	out.println("<th>Product Name</th><th>Quantity Remaining</th><th></th>");
	while(rst.next()){
		String pname= rst.getString(1);
		String pid= rst.getString(2);
		String price =  rst.getString(3);
		String addUrl="http://localhost/shop/addcart.jsp?id="+pid +"&name=" +pname+ "&price=" + price + "&rem=" + rst.getString(6);
		String addUrlDet="http://localhost/shop/product.jsp?id="+pid + "&img= " + rst.getString(5)+"&rem=" + rst.getString(6);
		if(cat.equals(rst.getString(4)) || cat.equals("0")){
			out.println("<tr><td><a style=\"text-decoration: none; color:inherit;\" href=  \" "+ addUrlDet + " \"><p>" +pname+ "</p><img width=\"300px\" src=\'" + rst.getString(5)+ "\' alt=\"No Image Found\"></a></td>");
			out.println("<td><a style=\"text-decoration: none; color:inherit;\" href=  \" "+ addUrlDet + " \">"+rst.getString(6)+"</a></td>");
			out.println("<td><a style=\"text-decoration: none; color:inherit;\" href=  \" "+ addUrl + " \"><button class=\"btn btn-outline-light\">Add to Cart</button></a></td></tr>");

		}
	}
	out.println("</table>");
}
//catch (Exception e)
//{
//	out.println("ClassNotFoundException: " +e);
//}

%>
</body>
</html>
