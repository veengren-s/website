<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
	<title>SpaceNStuff</title>
</head>
<body style="background-color: grey;">
	<div class="navbar navbar-dark bg-white">
        <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
          <li><a href="listprod.jsp" class="nav-link px-2 link-dark">Shop</a></li>
          <li><a href="customer.jsp" class="nav-link px-2 link-dark">Customer Info</a></li>
          <li><a href="admin.jsp" class="nav-link px-2 link-dark">Administration</a></li>
          <li><a href="listOrder.jsp" class="nav-link px-2 link-dark">List all orders</a></li>
		  <li><a href="#" class="nav-link px-2 link-secondary">Cart</a></li>
		</ul>
		<%
		String userName = (String) session.getAttribute("authenticatedUser");
		if (userName != null)
			out.println("<h6>Signed Into: "+userName+"</h6>");
	%>
      </div>


	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<link href="style.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

<div class="text-center">
<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{	out.println("<H1>Your shopping cart is empty!</H1>");
	productList = new HashMap<String, ArrayList<Object>>();
}
else
{
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

	out.println("<h1 style=\"color: white;\">Your Shopping Cart</h1>");
	out.println("<table class=\"table text-white\">");
	out.print("<tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
	out.println("<th>Price</th><th>Subtotal</th><th></th></tr>");
	double total =0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) 
	{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		out.print("<tr><td>"+product.get(0)+"</td>");
		out.print("<td>"+product.get(1)+"</td>");
		out.println("<td align=\"center\">");
		//edit qty 
		String ur = "addcart.jsp?id=" +product.get(0) + "&price="+product.get(2);
		String ur2 = "removeCart.jsp?id=" +product.get(0) + "&price="+product.get(2);

		//add
		if(Integer.valueOf((String) product.get(4)) >= (Integer) product.get(3)+1 ){
		out.println("<button onclick =\"window.location.href=\'"+ur+"\';\" class=\"btn text-white\">+</button>");
		}

		out.print(product.get(3));
		//remove
		if((Integer)product.get(3)>0){
			out.println("<button onclick =\"window.location.href=\'"+ur2+"\';\" class=\"btn text-white\">-</button>");
			out.println("</td>");
		}

		
		Object price = product.get(2);
		Object itemqty = product.get(3);
		double pr = 0;
		int qty = 0;
		
		try
		{
			pr = Double.parseDouble(price.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid price for product: "+product.get(0)+" price: "+price);
		}
		try
		{
			qty = Integer.parseInt(itemqty.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
		}		

		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td><td><a style=\"text-decoration: none; color:white;\" href=\"removeItem.jsp?id=" +product.get(0) +"\">remove item</a></td></tr>");
		
		total = total +pr*qty;
	}
	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td><td></td></tr>");
			out.println("</table>");

	out.println("<h2><a style=\"text-decoration: none; color:white;\" href=\"checkout.jsp\"><button class=\"btn btn-outline-light\">Check Out</button></a></h2><a style=\"text-decoration: none; color:white;\" href=\"listprod.jsp\"><h2><button class=\"btn btn-outline-light\">Continue Shopping</button></h2></a>");

}
%>
</div>
</body>
</html> 