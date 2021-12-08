<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
Connection con = DriverManager.getConnection(url, uid, pw);

		
//Note: Forces loading of SQL Server driver
%>
<title>SpaceNStuff</title>
<body style="background-color: grey;padding: 5px;">
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
		  </div>
<div class="text-white">
<h1 align="center">Enter Product ID new Price and new Quantity  </h1>
<form align="center" name="MyForm" method=post action="addProdInv.jsp">
    <table align="center" class="text-white">
    <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">ProductId:</font></div></td>
            <td><input type="text" name="pid"  size=50 maxlength=40></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Price:</font></div></td>
        <td><input type="text" name="price"  size=50 maxlength=40></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Quantity:</font></div></td>
        <td><input type="text" name="quantity"  size=50 maxlength=50></td>
</tr>
</table>
<br/>
<h1 align="center"><input class="btn btn-outline-light" type="submit" name="Submit2" value="Create"></h1>
</form>
</div>
</body>



<h2 align = "center"><a href="admin.jsp"><button class="btn btn-outline-light">Back to Admin Page</button></a></h2>
