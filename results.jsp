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

if (radioCount.equals("one")) {
   // Get information about the first input
} else if (radioCount.equals("two")) {
   // Get information about the second input
} else if (radioCount.equals("all")) {
   // Get information about the entire United States
}

if (radioType.equals("zip")) {
   // Get information about ZIP codes
} else if (radioType.equals("state")) {
   // Get information about States
} else if (radioType.equals("restaurant")) {
   // Get information about Restaurants
}

%>
