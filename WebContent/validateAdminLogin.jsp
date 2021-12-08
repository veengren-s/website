<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);

	String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
	String uid = "SA";
	String pw = "YourStrong@Passw0rd";
	Connection con = DriverManager.getConnection(url, uid, pw);


	String username = request.getParameter("ausername");
	String password = request.getParameter("apassword");
	boolean valid = false;
	
    if(username.equals("Admin") & password.equals("12345")){
        valid = true;
    }

	if(valid == true){
		response.sendRedirect("admin.jsp");		// Successful login
		session.removeAttribute("loginMessage");
		session.setAttribute("authenticatedUser",username);
	}else{
		response.sendRedirect("adminAuth.jsp");		// Failed login - redirect back to login page with a message
		session.setAttribute("loginMessage","Could not connect to the Admin system using that username/password.");
	}
	
	
	

		
	
%>