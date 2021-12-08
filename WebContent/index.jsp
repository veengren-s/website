<!DOCTYPE html>
<html>
<head>
	<title>SpaceNStuff</title>
</head>
<body   style="background-color:grey;">



	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

<h1 align="center" class="text-white">SpaceNStuff</h1>

<h2 align="center"><a class="text-white" style="text-decoration: none;color: inherit;" href="login.jsp"><button class="btn btn-outline-light"><h2 align="center">Login</h2></button></a></h2>

<h2 align="center"><a class="text-white" style="text-decoration: none;color: inherit;" href="listprod.jsp"><button class="btn btn-outline-light"><h2 align="center">Begin Shopping</h2></button></a></h2>

<h2 align="center"><a class="text-white" style="text-decoration: none;color: inherit;" href="listorder.jsp"><button class="btn btn-outline-light"><h2 align="center">List All Orders</h2></button></a></h2>

<h2 align="center"><a class="text-white" style="text-decoration: none;color: inherit;" href="customer.jsp"><button class="btn btn-outline-light"><h2 align="center">Customer Info</h2></button></a></h2>

<h2 align="center"><a class="text-white" style="text-decoration: none;color: inherit;" href="adminAuth.jsp"><button class="btn btn-outline-light"><h2 align="center">Administrators</h2></button></a></h2>

<h2 align="center"><a class="text-white" style="text-decoration: none;color: inherit;" href="logout.jsp"><button class="btn btn-outline-light"><h2 align="center">Log Out</h2></button></a></h2>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
		out.println("<h3 align=\"center\" class=\"text-white\">Signed in as: "+userName+"</h3>");
%>
</body>
</head>





