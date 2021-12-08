<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%
try{
    HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
    Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
        String id = request.getParameter("id");
        while (iterator.hasNext()) 
        {	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
            ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
  
            if(id.equals(product.get(0))){
                iterator.remove();
            }
        }
}catch(Exception e ){
    out.println(e);
}
%>
<jsp:forward page="showcart.jsp" />