<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<% String radioCount = request.getParameter("radioCount"); %>
<% String radioType = request.getParameter("radioType"); %>
<% String text1 = request.getParameter("text1"); %>
<% String text2 = request.getParameter("text2"); %>

<% out.println("Count: " + radioCount + "<br>"); %>
<% out.println("Type: " + radioType + "<br>"); %>
<% out.println("Text 1: " + text1 + "<br>"); %>
<% out.println("Text 2: " + text2 + "<br><br>"); %>

<%

if (radioCount.equals("all")) {
   out.println("User has selected to view information about the entire United States.<br><br>");
   out.println("Top restaurants in the United States: " );
}

%>
