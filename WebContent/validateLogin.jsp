<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);

	String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
	String uid = "SA";
	String pw = "YourStrong@Passw0rd";
	Connection con = DriverManager.getConnection(url, uid, pw);


	String username = request.getParameter("username");
	String password = request.getParameter("password");
	boolean valid = false;
	PreparedStatement pstmt4 = con.prepareStatement("SELECT userid,password FROM customer WHERE userid = ? and password = ?");
	pstmt4.setString(1,username);
	pstmt4.setString(2, password);
	ResultSet rst4 = pstmt4.executeQuery();
	
	if(rst4.next()){
		valid = true;
	}

	 
	if(valid == true){
		response.sendRedirect("index.jsp");		// Successful login
		session.removeAttribute("loginMessage");
		session.setAttribute("authenticatedUser",username);
	}else{
		response.sendRedirect("login.jsp");		// Failed login - redirect back to login page with a message
		session.setAttribute("loginMessage","Could not connect to the system using that username/password.");
	}
	
	
	

		
	
%>