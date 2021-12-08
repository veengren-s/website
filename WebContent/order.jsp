<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
	<title>SpaceNStuff|Processing</title>
</head>
<body style="background-color: grey;">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<div class="text-white">
        
<%
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
Connection con = DriverManager.getConnection(url, uid, pw);


// Get customer id
String custId = request.getParameter("customerId");
// Get password
String password = request.getParameter("password");
// Get shopping cart
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
                
try 
{	
	if (custId == null || custId.equals(""))
		out.println("<h1 align=\"center\">Invalid customer id.  Go back to the previous page and try again.</h1>");
	else if (productList == null)
		out.println("<h1 align = \"center\">Your shopping cart is empty!</h1>");
	else
	{	
		// Check if customer id is a number
		int num=-1;
		try
		{
			num = Integer.parseInt(custId);
		} 
		catch(Exception e)
		{
			out.println("<h1 align=\"center\">Invalid customer id.  Go back to the previous page and try again.</h1>");
			return;
		}		
        
		// Get database connection
       
	                		
        String sql = "SELECT customerId, firstName+' '+lastName, password FROM customer WHERE customerId = ?";	
				      
   		con = DriverManager.getConnection(url, uid, pw);
   		PreparedStatement pstmt = con.prepareStatement(sql);
   		pstmt.setInt(1, num);
   		ResultSet rst = pstmt.executeQuery();
   		int orderId=0;
   		String custName = "";

   		if (!rst.next())
   		{
   			out.println("<h1 align=\"center\">Invalid customer id.  Go back to the previous page and try again.</h1>");
   		}
   		else
   		{	
   			custName = rst.getString(2);
			String dbpassword = rst.getString(3);
				    		
			// make sure the password on the database is the same as the one the user entered
			if (!dbpassword.equals(password)) 
			{
				out.println("<h1 align=\"center\">The password you entered was not correct.  Please go back and try again.</h1><br>"); 
				return;
			}
		
   			// Enter order information into database
   			sql = "INSERT INTO OrderSummary (customerId, totalAmount, orderDate) VALUES(?, 0, ?);";

   			// Retrieve auto-generated key for orderId
   			pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
   			pstmt.setInt(1, num);
   			pstmt.setTimestamp(2, new java.sql.Timestamp(new Date().getTime()));
   			pstmt.executeUpdate();
   			ResultSet keys = pstmt.getGeneratedKeys();
   			keys.next();
   			orderId = keys.getInt(1);

   			out.println("<h1 align=\"center\">Your Order Summary</h1>");
         	  	out.println("<table class=\"table table-hover text-white\"><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");

           	double total =0;
           	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
           	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
						
           	while (iterator.hasNext())
           	{ 
           		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
                   ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
   				String productId = (String) product.get(0);
                   out.print("<tr><td>"+productId+"</td>");
                   out.print("<td>"+product.get(1)+"</td>");
   				out.print("<td >"+product.get(3)+"</td>");
                   String price = (String) product.get(2);
                   double pr = Double.parseDouble(price);
                   int qty = ( (Integer)product.get(3)).intValue();
   				out.print("<td  >"+currFormat.format(pr)+"</td>");
                  	out.print("<td >"+currFormat.format(pr*qty)+"</td></tr>");
                   out.println("</tr>");
                   total = total +pr*qty;

               	sql = "INSERT INTO OrderProduct (orderId, productId, quantity, price) VALUES(?, ?, ?, ?)";
   				pstmt = con.prepareStatement(sql);
   				pstmt.setInt(1, orderId);
   				pstmt.setInt(2, Integer.parseInt(productId));
   				pstmt.setInt(3, qty);
   				pstmt.setString(4, price);
   				pstmt.executeUpdate();	

				   sql = "SELECT quantity FROM productinventory WHERE productId=?";
				   pstmt = con.prepareStatement(sql);
				   pstmt.setInt(1,Integer.parseInt(productId));
				   ResultSet s = pstmt.executeQuery();
				   s.next();
				   
				   sql = "UPDATE productinventory SET quantity=? WHERE productId=?";
				   pstmt = con.prepareStatement(sql);
				   pstmt.setInt(1,s.getInt(1)-qty);
				   pstmt.setInt(2,Integer.parseInt(productId));
				   pstmt.executeUpdate();
           	}
           	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
                          	+"<td aling=\"right\">"+currFormat.format(total)+"</td></tr>");
           	out.println("</table>");

   			// Update order total
   			sql = "UPDATE OrderSummary SET totalAmount=? WHERE orderId=?";
   			pstmt = con.prepareStatement(sql);
   			pstmt.setDouble(1, total);
   			pstmt.setInt(2, orderId);			
   			pstmt.executeUpdate();	

	

   			out.println("<h1 align=\"center\">Order completed.  Will be shipped soon...</h1>");
   			out.println("<h1 align=\"center\">Your order reference number is: "+orderId+"</h1>");
   			out.println("<h1 align=\"center\">Shipping to customer: "+custId+" Name: "+custName+"</h1>");   			
   			
   			// Clear session variables (cart)
   			session.setAttribute("productList", null);    
   		}
   	}
}
catch (SQLException ex)
{ 	out.println(ex);
}
finally
{
	try
	{
		if (con != null)
			con.close();
	}
	catch (SQLException ex)
	{       out.println(ex);
	}
}  
%>                       				
<h2 align="center"><a href="index.jsp"><button class = "btn bt-outling-light"><button class="btn btn-outline-light"> to Main Page</button></a></h2>
</div>
</body>
</html>