<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<title>SpaceNStuff</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<body style="background-color: grey;padding: 6px;">
<div class="text-white">
<%
	
	session = request.getSession(true);

String username1 = request.getParameter("username");
String password1 = request.getParameter("password");
String firstname1 = request.getParameter("firstname");
String lastname1 = request.getParameter("lastname");
String email1 = request.getParameter("email");
String pnum1 = request.getParameter("phonenum");
String address1 = request.getParameter("address");
String city1 = request.getParameter("city");
String state1 = request.getParameter("state");
String postcode1 = request.getParameter("postalCode");
String country1 = request.getParameter("country");



String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
Connection con = DriverManager.getConnection(url, uid, pw);
String name = request.getParameter("productName");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

boolean valid = true;

if((username1.length() == 0) || (password1.length() == 0) || (firstname1.length() == 0) || (lastname1.length() == 0) || (email1.length() == 0) || (pnum1.length() == 0) || (city1.length() == 0) || (state1.length() == 0) || (postcode1.length() == 0) || (country1.length() == 0)){
    out.println("<h1 align=\"center\">Invalid information please try again</h1>");
    valid = false;
    
}

if(valid == true){
PreparedStatement pstmt4 = con.prepareStatement("SELECT userid FROM customer WHERE userid = ?");
pstmt4.setString(1, username1);
ResultSet rst4 = pstmt4.executeQuery();

while(rst4.next()){
    if(rst4.getString(1).equals(username1)){
        out.println("<h1 align=\"center\">Username already exists please try again</h1>");
        valid = false;
    }

}
}

if(valid == true){
PreparedStatement pstmt = con.prepareStatement("INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?,?,?,?,?,?,?,?,?,?,?)");
pstmt.setString(10,username1);
pstmt.setString(11,password1);
pstmt.setString(1,firstname1);
pstmt.setString(2,lastname1);
pstmt.setString(3,email1);
pstmt.setString(4,pnum1);
pstmt.setString(5,address1);
pstmt.setString(6,city1);
pstmt.setString(7,state1);
pstmt.setString(8,postcode1);
pstmt.setString(9,country1);

pstmt.executeUpdate();
out.println("<h1 align=\"center\">User successful created</h1>");
}

%>
<h2 align="center"><a href="login.jsp"><button class="btn btn-outline-light"> to login Page</button></a></h2>
</div>
</body>
