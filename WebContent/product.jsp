<%@ page import="java.util.HashMap" %>
<%@ page import="java.io.File" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<html>
<head>
  <title>SpaceNStuff</title>
  <link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="background-color: grey; padding: 5px;">
    
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link href="style.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<div class="navbar navbar-dark bg-white">
    <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
      <li><a href="listprod.jsp" class="nav-link px-2 link-secondary">Shop</a></li>
      <li><a href="customer.jsp" class="nav-link px-2 link-dark">Customer Info</a></li>
      <li><a href="admin.jsp" class="nav-link px-2 link-dark">Administration</a></li>
      <li><a href="listOrder.jsp" class="nav-link px-2 link-dark">List all orders</a></li>
      <li><a href="showcart.jsp" class="nav-link px-2 link-dark">Cart</a></li>
    </ul>
  </div>

<div class="text-center">
<%
// Get product name to search for

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

try ( Connection con = DriverManager.getConnection(url, uid, pw)){
    String productId = request.getParameter("id");
    String img = request.getParameter("img");
    String rem = request.getParameter("rem");


    //sql query
    PreparedStatement Pstmt = con.prepareStatement("SELECT productName,productId,productPrice,productDesc FROM product where productId = ?");
    Pstmt.setString(1,productId);
    ResultSet rst = Pstmt.executeQuery();

    //display
    while(rst.next()){
        String addUrl="http://localhost/shop/addcart.jsp?id="+rst.getString(2) +"&name=" +rst.getString(1)+ "&price=" + rst.getString(3)+"&rem=" + rem;
        String im = "displayImage.jsp?id=" + rst.getString(2);
        out.println("<h1 class=\"text-white\" >" + rst.getString(1)+ "</h1>");
        out.println("<img width=\"600\" src = \""+img+"\" alt=\"No Image Found\">");
        out.println("<h3 class=\"text-white\"> Id: " + rst.getString(2)+ "</h3>");
        out.println("<h3 class=\"text-white\"> Price: " + rst.getString(3)+ "</h3>");
        out.println("<h3 class=\"text-white\"> Description: " + rst.getString(4)+ "</h3><br><br>");
        out.println("<a class=\"text-white\" style=\"text-decoration: none; color:inherit;\" href=  \" "+ addUrl + " \"> <button class=\"btn btn-outline-light\"><h2>Add To Cart</h2></button></a>");
        out.println("<a class=\"text-white\" style=\"text-decoration: none; color:inherit;\" href= \" http://localhost/shop/listprod.jsp \" ><button class=\"btn btn-outline-light\"><h2> continue shopping</h2></button></a>");
    }


    //display reviews
    PreparedStatement Pstmt2 = con.prepareStatement("SELECT reviewRating,reviewDate,reviewComment FROM review where productId = ? ");
    Pstmt2.setString(1,productId);
    ResultSet rst2 = Pstmt2.executeQuery();
    out.println("</div><h2 class=\"text-white\">Reviews:</h2>");
    out.println("<a class=\"text-white\" style=\"text-decoration: none; color:inherit;\" href= \" http://localhost/shop/createReview.jsp \" ><button class=\"btn btn-outline-light\"><h6> Write a review</h6></button></a>");
    out.println("<table class=\"table table-hover text-white\">");
    while(rst2.next()){
        out.println("<tr>");
        //rating
        out.println("<td><p>Rating:</p>"+ rst2.getInt(1));
        //date
        out.println("<p>Date Reviewed:</p>"+rst2.getDate(2));
        //comments
        out.println("<p>Comments:</p>"+rst2.getString(3) +"</td>");

        out.println("</tr>");
    }
    out.println("</table>");

}

%>

</body>
</html>

