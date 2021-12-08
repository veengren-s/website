<%@ page import="java.sql.Date" %>
<%@ page import="java.util.*" %>

<%@ page import="java.io.File" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%String id = request.getParameter("id");%>


<html>
<head>
    <title>SpaceNStuff</title>
</head>
<body style="background-color: grey;">   
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<div class="text-center ">
    <h1 class="text-white" >Write a review</h1>
    <form action="saveReview.jsp">
        <h3 class="text-white" >What is the product ID:</h3>
        <input name="pid" >
        <h3 class="text-white" >What is your customer ID:</h3>
        <input type="text" name="cid">
        <h3 class="text-white" >How many stars: </h3>
        <input type="radio" name="stars" value="1"> <p class="text-white"  >1 Star</p>
        <input type="radio" name="stars" value="2"> <p class="text-white" >2 Stars</p>
        <input type="radio" name="stars" value="3"> <p class="text-white" >3 Stars</p>
        <input type="radio" name="stars" value="4"> <p class="text-white" >4 Stars</p>
        <input type="radio" name="stars" value="5"> <p class="text-white" >5 Stars</p>
        <h3 class="text-white" >Write your thoughts: </h3>
        <textarea name="text" rows="10" cols="40"></textarea>
        <br>
        <input type="submit" value="Submit" class="btn-primary" /> 
    </form>
</div>


</body>
</html>
