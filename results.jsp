<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<%-- Get user input --%>
<% String radioCount = request.getParameter("radiocount"); %>
<% String radioType = request.getParameter("radiotype"); %>
<% String text1 = request.getParameter("textinput1"); %>
<% String text2 = request.getParameter("textinput2"); %>

<%-- Output user input --%>
<% out.println("Count: " + radioCount + "<br>"); %>
<% out.println("Type: " + radioType + "<br>"); %>
<% out.println("Input 1: " + text1 + "<br>"); %>
<% out.println("Input 2: " + text2 + "<br><br>"); %>

<%-- Java Methods --%>
<%! 

   /*
   * Connect to SQL
   */
   
   /*
   * Get the N most common restaurants in the US
   */
   private static String topRestaurantsEverywhere(int N, Connection connection) throws SQLException {

      N = 4;

      String sql = "SELECT name, count(*) as number " +
               "FROM restaurants " +
               "GROUP BY name " +
               "ORDER BY count(*) DESC " +
               "LIMIT " + N;

      Statement statement = connection.createStatement();
      ResultSet resultSet = statement.executeQuery(sql);
      StringBuilder stringBuilder = new StringBuilder();

      while (resultSet.next()) {
         stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append("\n");
      }

      return stringBuilder.toString();

   }

%>



<%

      String url = "jdbc:mysql://localhost:3306/termproject";
      String password = "password";
      String username = "root";
      Class.forName("com.mysql.jdbc.Driver");
      Connection connection = DriverManager.getConnection(url, username, password);
        
      // Get information about the entire United States
      if (radioCount.equalsIgnoreCase("All") && radioType.equalsIgnoreCase("Restaurant")) {
         out.println("<p>Returning information about the entire United States.</p>");
         out.println("The top 5 most popular restaurants in the United States: " + topRestaurantsEverywhere(5, connection));
      }

%>
