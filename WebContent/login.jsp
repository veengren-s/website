<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
</head>
<body style="background-color: grey;">

<div style="margin:0 auto;text-align:center;display:inline" class="text-white">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<br>
	<br><br><br><br><br><br><br><br><br>
<h3>Please Login to System</h3>
<br>

<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null)
	out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
%>


<form name="MyForm" method=post action="validateLogin.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
	<td><input type="text" name="username"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
	<td><input type="password" name="password" size=10 maxlength="10"></td>
</tr>
</table>

<br>
<input class="btn btn-outline-light" type="submit" name="Submit2" value="Log In">
</form>

</div>
<br><br>
<p align="center"><a href="createuser.jsp" style="text-decoration: none;color: inherit;"><button class="btn btn-outline-light"> new User</button></a></p>
<p align="center"><a href="forgot.jsp" style="text-decoration: none;color: inherit;"><button class="btn btn-outline-light">forgot pasword</button></a></p>
</body>
</html>

