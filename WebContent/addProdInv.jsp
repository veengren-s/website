<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<title>SpaceNStuff</title>
<body style="background-color: grey;">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<div class="text-white">
<%
String userName = (String) session.getAttribute("authenticatedUser");
	session = request.getSession(true);

String pid = request.getParameter("pid");
String price = request.getParameter("price");
String quantity = request.getParameter("quantity");

Integer pid1 = Integer.valueOf(pid);
Integer price1 = Integer.valueOf(price);
Integer quantity1 = Integer.valueOf(quantity);

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

boolean valid = false;
boolean valid2 = true;





if(price1 <= 0 || quantity1 <= 0){
    valid2 = false;
    
}

if(valid == false & valid2 == true){
    PreparedStatement pstmt4 = con.prepareStatement("SELECT productId FROM productinventory WHERE productId = ?");
    pstmt4.setInt(1, pid1);
    ResultSet rst4 = pstmt4.executeQuery();
    
    while(rst4.next()){
        if(rst4.getInt(1) == pid1 ){
               valid = true;
        }
    
    }
}

if(valid == true & valid2 == true){
    PreparedStatement pstmt = con.prepareStatement("UPDATE productinventory SET quantity = ?, price = ? WHERE productId = ?");
	pstmt.setInt(3,pid1);
	pstmt.setInt(1,quantity1);
    pstmt.setInt(2, price1);
    pstmt.executeUpdate();

    out.println("<h1 align=\"center\">Information Successfully Updated</h1>");
}else{
    out.println("You have entered invalid information please try again");
}


%>
<br><br><br>
<h2 align="center"><a href="admin.jsp"><button class="btn btn-outline-light">Back to Admin Page </button></a></h2>
</div>
</body>
