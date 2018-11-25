<%-- Imports --%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.math.BigDecimal" %>

<%-- CSS for columns --%>
<style>
.column {
    float: left;
    width: 50%;
}
.row:after {
    content: "";
    display: table;
    clear: both;
}
</style>

<%-- Get user input --%>
<% String radioCount = request.getParameter("radiocount"); %>
<% String radioType = request.getParameter("radiotype"); %>
<% String text1 = request.getParameter("textinput1"); %>
<% String text2 = request.getParameter("textinput2"); %>

<%-- All The Java Methods --%>
<%! 

    /*
     * Get the top N Restaurants in a ZIP code
     */
    private static String topRestaurantsInZIP(int zipCode, int N, Connection connection) throws SQLException {

        String sql = "SELECT name, count(*) as number\n" +
                "    FROM restaurants\n" +
                "    WHERE zipcode = " + zipCode + "\n" +
                "    GROUP BY name\n" +
                "    ORDER BY count(*) DESC\n" +
                "    LIMIT " + N;

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append(" locations<br>");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the top N Restaurants in a County
     */
    private static String topRestaurantsInCounty(String county, String state, int N, Connection connection) throws SQLException {

        String sql = "SELECT name, count(*) as number\n" +
                "FROM restaurants\n" +
                "WHERE zipcode IN (\n" +
                "\tSELECT zipcode\n" +
                "    FROM taxdatasum\n" +
                "    WHERE county = '" + county + "' AND state = '" + state + "')\n" +
                "GROUP BY name \n" +
                "ORDER BY count(*) DESC \n" +
                "LIMIT " + N;

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append(" locations<br>");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the average income for a ZIP code
     */
    private static String averageIncomeInZIP(int zip, Connection connection) throws SQLException {

        String sql = "SELECT avgIncome\n" +
                "FROM taxdatasum\n" +
                "WHERE zipcode = " + zip + "";

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getDouble(1)).append("\n");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the average income for a County
     */
    private static String averageIncomeInCounty(String county, String state, Connection connection) throws SQLException {

        String sql = "SELECT ROUND((sum(totalIncome) * 1.0) / nullif(sum(numReturns), 0), 6)\n" +
                "FROM taxdatasum\n" +
                "WHERE  county = '" + county + "' AND state = '" + state + "'";

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getDouble(1)).append("\n");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the total returns in a ZIP code
     */
    private static String totalReturnsInZIP(int zip, Connection connection) throws SQLException {

        String sql = "SELECT numReturns\n" +
                "FROM taxdatasum\n" +
                "WHERE zipcode = " + zip + "";

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getInt(1)).append("\n");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the top total returns in a county
     */
    private static String totalReturnsInCounty(String county, String state, Connection connection) throws SQLException {

        String sql = "SELECT sum(numReturns)\n" +
                "FROM taxdatasum\n" +
                "WHERE  county = '" + county + "' AND state = '" + state + "'";

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getString(1)).append("\n");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the top N Restaurants in a county
     */
    private static String topRestaurantsInState(String state, int N, Connection connection) throws SQLException {

        String sql = "SELECT name, count(*) as number\n" +
                "FROM restaurants\n" +
                "WHERE zipcode IN (\n" +
                "\tSELECT zipcode\n" +
                "    FROM taxdatasum\n" +
                "    WHERE state = '" + state + "')\n" +
                "GROUP BY name \n" +
                "ORDER BY count(*) DESC \n" +
                "LIMIT " + N;

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append(" locations<br>");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the average income for a state
     */
    private static String averageIncomeInState(String state, Connection connection) throws SQLException {

        String sql = "SELECT avgIncome\n" +
                "FROM taxdatasum\n" +
                "WHERE state = '" + state + "' AND zipcode = 0;";

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getDouble(1)).append("\n");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the total returns in a state
     */
    private static String totalReturnsInState(String state, Connection connection) throws SQLException {

        String sql = "SELECT numReturns\n" +
                "FROM taxdatasum\n" +
                "WHERE state = '" + state + "' AND zipcode = 0;";

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getInt(1)).append("\n");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the N richest counties in a state
     */
    private static String richestCountiesInState(String state, int N, Connection connection) throws SQLException {

        String sql = "SELECT county, ROUND((sum(totalIncome) * 1.0) / nullif(sum(numReturns), 0), 6) as avgIncome\n" +
                "FROM taxdatasum\n" +
                "WHERE state = '" + state + "'\n" +
                "GROUP BY county\n" +
                "ORDER BY ROUND((sum(totalIncome) * 1.0) / nullif(sum(numReturns), 0), 6) DESC\n" +
                "LIMIT " + N;

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append("<br>");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the N poorest counties in a state
     */
    private static String poorestCountiesInState(String state, int N, Connection connection) throws SQLException {

        String sql = "SELECT county, ROUND((sum(totalIncome) * 1.0) / nullif(sum(numReturns), 0), 6) as avgIncome\n" +
                "FROM taxdatasum\n" +
                "WHERE state = '"+ state + "'\n" +
                "GROUP BY county\n" +
                "ORDER BY ROUND((sum(totalIncome) * 1.0) / nullif(sum(numReturns), 0), 6)\n" +
                "LIMIT " + N;

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append("<br>");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the N most common restaurants in the richest counties in a state
     */
    private static String mostCommonRestaurantsInRichestCountiesInState(String state, int N, Connection connection) throws SQLException {

        String sql = "SELECT name, count(*) as number\n" +
                "FROM restaurants\n" +
                "WHERE zipcode IN (\n" +
                "\tSELECT zipcode\n" +
                "    FROM taxdatasum\n" +
                "    WHERE county IN (\n" +
                "\t\tSELECT * from (SELECT county\n" +
                "\t\tFROM taxdatasum\n" +
                "\t\tWHERE state = '" + state + "'\n" +
                "\t\tGROUP BY county\n" +
                "\t\tORDER BY ROUND((sum(totalIncome) * 1.0) / nullif(sum(numReturns), 0), 6) DESC\n" +
                "\t\tLIMIT " + N + ") as t1\n" +
                "    )\n" +
                "\n" +
                ")\n" +
                "GROUP BY name \n" +
                "ORDER BY count(*) DESC \n" +
                "LIMIT " + N + ";";

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append("<br>");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the N most common restaurants in the poorest counties in a state
     */
    private static String mostCommonRestaurantsInPoorestCountiesInState(String state, int N, Connection connection) throws SQLException {

        String sql = "SELECT name, count(*) as number\n" +
                "FROM restaurants\n" +
                "WHERE zipcode IN (\n" +
                "\tSELECT zipcode\n" +
                "    FROM taxdatasum\n" +
                "    WHERE county IN (\n" +
                "\t\tSELECT * from (SELECT county\n" +
                "\t\tFROM taxdatasum\n" +
                "\t\tWHERE state = '" + state + "'\n" +
                "\t\tGROUP BY county\n" +
                "\t\tORDER BY ROUND((sum(totalIncome) * 1.0) / nullif(sum(numReturns), 0), 6)\n" +
                "\t\tLIMIT " + N + ") as t1\n" +
                "    )\n" +
                "\n" +
                ")\n" +
                "GROUP BY name \n" +
                "ORDER BY count(*) DESC \n" +
                "LIMIT " + N;

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append("<br>");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the N most common restaurants in the US
     */
    private static String topRestaurantsEverywhere(int N, Connection connection) throws SQLException {

        String sql = "SELECT name, count(*) as number\n" +
                "FROM restaurants\n" +
                "GROUP BY name \n" +
                "ORDER BY count(*) DESC \n" +
                "LIMIT " + N;

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append("<br>");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the average income in the US
     */
    private static String averageIncomeEverywhere(Connection connection) throws SQLException {

        String sql = "SELECT ROUND((sum(totalIncome) * 1.0) / nullif(sum(numReturns), 0), 6)\n" +
                "FROM taxdatasum\n" +
                "WHERE zipcode = 0";

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getInt(1)).append("\n");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the total returns in the US
     */
    private static String totalReturnsEverywhere(Connection connection) throws SQLException {

        String sql = "SELECT sum(numReturns)\n" +
                "FROM taxdatasum\n" +
                "WHERE zipcode = 0";

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getInt(1)).append("\n");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the N richest states in the US
     */
    private static String richestStatesEverywhere(int N, Connection connection) throws SQLException {

        String sql = "SELECT state, avgIncome\n" +
                "FROM taxdatasum\n" +
                "WHERE zipcode = 0\n" +
                "ORDER BY avgIncome DESC\n" +
                "LIMIT " + N;

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            NumberFormat currencyFormat = NumberFormat.getCurrencyInstance();
            Double averageIncome = resultSet.getDouble(2) * 1000;
            stringBuilder.append(resultSet.getString(1)).append(": ").append(currencyFormat.format(averageIncome)).append("<br>");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the N poorest states in the US
     */
    private static String poorestStatesEverywhere(int N, Connection connection) throws SQLException {

        String sql = "SELECT state, avgIncome\n" +
                "FROM taxdatasum\n" +
                "WHERE zipcode = 0\n" +
                "ORDER BY avgIncome\n" +
                "LIMIT " + N;

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            NumberFormat currencyFormat = NumberFormat.getCurrencyInstance();
            Double averageIncome = resultSet.getDouble(2) * 1000;
            stringBuilder.append(resultSet.getString(1)).append(": ").append(currencyFormat.format(averageIncome)).append("<br>");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the N most common restaurants in the M richest states in the US
     */
    private static String mostCommonRestaurantsInRichestStates(int N, int M, Connection connection) throws SQLException {

        String sql = "SELECT name, count(*) as number\n" +
                "FROM restaurants\n" +
                "WHERE zipcode IN (\n" +
                "\tSELECT zipcode\n" +
                "    FROM taxdatasum\n" +
                "    WHERE state IN (\n" +
                "\t\tSELECT * from (SELECT state\n" +
                "\t\tFROM taxdatasum\n" +
                "\t\tWHERE zipcode = 0\n" +
                "\t\tORDER BY avgIncome DESC\n" +
                "\t\tLIMIT " + M + ") as t1\n" +
                "    )\n" +
                "\n" +
                ")\n" +
                "GROUP BY name \n" +
                "ORDER BY count(*) DESC \n" +
                "LIMIT " + N;

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append(" locations<br>");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the N most common restaurants in the M poorest states in the US
     */
    private static String mostCommonRestaurantsInPoorestStates(int N, int M, Connection connection) throws SQLException {

        String sql = "SELECT name, count(*) as number\n" +
                "FROM restaurants\n" +
                "WHERE zipcode IN (\n" +
                "\tSELECT zipcode\n" +
                "    FROM taxdatasum\n" +
                "    WHERE state IN (\n" +
                "\t\tSELECT * from (SELECT state\n" +
                "\t\tFROM taxdatasum\n" +
                "\t\tWHERE zipcode = 0\n" +
                "\t\tORDER BY avgIncome\n" +
                "\t\tLIMIT " + M + ") as t1\n" +
                "    )\n" +
                "\n" +
                ")\n" +
                "GROUP BY name \n" +
                "ORDER BY count(*) DESC \n" +
                "LIMIT " + N;

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append(" locations<br>");
        }

        return stringBuilder.toString();

    }
    
    /*
     * Get the number of a certain restaurant in a zip code
     */
    private static String numRestaurantsZip(String name, int zip, Connection connection) throws SQLException {

        String sql = "SELECT name, zipcode, count(*) as number" +
                "FROM restaurants" +
                "WHERE name = " + name +" AND zipcode = " + zip;

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append("\n");
        }

        return stringBuilder.toString();

    }
    /*
     * Get the number of a certain restaurant in a county
     */
    private static String numRestaurantsCounty(String name, String state, String county, Connection connection) throws SQLException {

        String sql = "SELECT r.name, count(*)"
                + "FROM restaurants r"
                +"WHERE name= "+ name +" AND zipcode IN ("
                +"SELECT zipcode"
                +"FROM taxdatasum"
                +"WHERE state = "+ state +" AND county = "+ county +"  )";

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append("\n");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the number of a certain restaurant in a state
     */
    private static String numRestaurantsState(String name, String state, Connection connection) throws SQLException {

        String sql = "SELECT name, count(*) as number" +
                "FROM restaurants"+
                "WHERE name = " + name +" AND zipcode IN ("+
                "SELECT zipcode"+
                "FROM taxdatasum"+
                "WHERE state = " + state +"  )";

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append("\n");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the N most common counties for a certain restaurant in a state
     */
    private static String mostCommonCounties(String name, String state, int N, Connection connection) throws SQLException {

        String sql = "SELECT t.county, count(*) as locations" +
                "FROM restaurants r, taxdatasum t" +
                "WHERE r.name= "+ name +" AND r.zipcode = t.zipcode AND t.state = " + state +
                "GROUP BY county" +
                "ORDER BY count(*) DESC" +
                "LIMIT " + N;
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append("<br>");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the average income of the most common counties for a certain restaurant in a state
     */
    private static String commonCountyAvgIncome(String name, String state, int N, Connection connection) throws SQLException {

        String sql = "SELECT county, ROUND((sum(totalIncome) * 1.0) / nullif(sum(numReturns), 0), 6) as avgIncome"+
                "FROM taxdatasum"+
                "WHERE  state = " + state + " AND county in ("+
                "SELECT * from("+
                "SELECT t.county"+
                "FROM restaurants r, taxdatasum t"+
                "WHERE r.name= " + name + " AND r.zipcode = t.zipcode AND t.state = " + state +
                "GROUP BY county"+
                "ORDER BY count(*) DESC" +
                "LIMIT " + N +
                ") as t1" +
                ")"+
                "GROUP BY county";

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append("<br>");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the number of a certain restaurant in all states
     */
    private static String numRestaurantsAllStates(String name, Connection connection) throws SQLException {

        String sql = "SELECT count(*)"+
                "FROM restaurants"+
                "WHERE name = " + name;

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getString(1)).append("\n");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the N most common states for a certain restaurant
     */
    private static String mostCommonStates(String name, String state, int N, Connection connection) throws SQLException {

        String sql = "SELECT t.state, count(*) as locations" +
                "FROM restaurants r, taxdatasum t" +
                "WHERE r.name= "+ name +" AND r.zipcode = t.zipcode" +
                "GROUP BY state" +
                "ORDER BY count(*) DESC" +
                "LIMIT " + N;
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append("<br>");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the N most common counties for a certain restaurant overall
     */
    private static String mostCommonCountiesOverall(String name, int N, Connection connection) throws SQLException {

        String sql = "SELECT t.county, t.state, count(*) as locations" +
                "FROM restaurants r, taxdatasum t" +
                "WHERE r.name= "+ name +" AND r.zipcode = t.zipcode"+
                "GROUP BY state, county" +
                "ORDER BY count(*) DESC" +
                "LIMIT " + N;
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append(": ").append(resultSet.getInt(3)).append("<br>");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the average income of the most common counties for a certain restaurant overall
     */
    private static String commonCountyOverallAvgIncome(String name, int N, Connection connection) throws SQLException {

        String sql = "SELECT county, state, ROUND((sum(totalIncome) * 1.0) / nullif(sum(numReturns), 0), 6) as avgIncome"+
                "FROM taxdatasum"+
                "WHERE  county in ("+
                "SELECT * from("+
                "SELECT t.county"+
                "FROM restaurants r, taxdatasum t"+
                "WHERE r.name= " + name +" AND r.zipcode = t.zipcode "+
                "GROUP BY t.state, t.county"+
                "ORDER BY count(*) DESC"+
                "LIMIT " + N +
                ") as t1)"+
                "AND state in ("+
                "SELECT * from("+
                "SELECT t.state"+
                "FROM restaurants r, taxdatasum t"+
                "WHERE r.name= " + name +" AND r.zipcode = t.zipcode"+
                "GROUP BY t.state, t.county"+
                "ORDER BY count(*) DESC"+
                "LIMIT " + N +
                ") as t1"+


                ")"+
                "GROUP BY state, county";

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append(": ").append(resultSet.getInt(3)).append("<br>");

        }


        return stringBuilder.toString();

    }
    /*
     * Get the average income of the most common states for a certain restaurant
     */
    private static String commonStateAvgIncome(String name, int N, Connection connection) throws SQLException {

        String sql = "SELECT state, avgIncome"+
                "FROM taxdatasum" +
        "WHERE state in ( SELECT * from("+
                "SELECT t.state"+
                "FROM restaurants r, taxdatasum t"+
                "WHERE r.name= " + name + " AND r.zipcode = t.zipcode"+
                "GROUP BY t.state"+
                "ORDER BY count(*) DESC"+
                "LIMIT " + N +") as t1) AND zipcode = '0'"+
                "GROUP BY state";


        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append("<br>");

        }


        return stringBuilder.toString();

    }

%>

<%-- Display the correct information, depending on user input --%>
<%

      // Create MySQL Connection
      String url = "jdbc:mysql://localhost:3306/termproject";
      String password = "password";
      String username = "root";
      Class.forName("com.mysql.jdbc.Driver");
      Connection connection = DriverManager.getConnection(url, username, password);

      // Data formats
      NumberFormat currencyFormat = NumberFormat.getCurrencyInstance();
      DecimalFormat numberFormat = new DecimalFormat("#,###");

      // One ZIP Code
      if (radioCount.equalsIgnoreCase("One") && radioType.equalsIgnoreCase("ZIP")) {
         out.println("<p><h2>ZIP Code: " + text1 + ".</h2></p>");
         Double averageIncome = Double.parseDouble(averageIncomeInZIP(Integer.parseInt(text1), connection)) * 1000;
         out.println("<p><b>Average household income in " + text1 + ":</b></br>" + currencyFormat.format(averageIncome) + "</p>");
         Double totalReturns = Double.parseDouble(totalReturnsInZIP(Integer.parseInt(text1), connection));
         out.println("<p><b>Total Returns in " + text1 + ":</b></br>" + numberFormat.format(totalReturns) + "</p>");
      }
      // Two ZIP Codes
      if (radioCount.equalsIgnoreCase("Two") && radioType.equalsIgnoreCase("ZIP")) {
         out.println("<p><h2>Two ZIP Codes: " + text1 + " and " + text2 + ".</h2></p>");

         out.println("<div class=\"row\">");
         out.println("<div class=\"column\">");

         out.println("<p><u><strong>ZIP Code: " + text1 + ".</strong></u></p>");
         Double averageIncome = Double.parseDouble(averageIncomeInZIP(Integer.parseInt(text1), connection)) * 1000;
         out.println("<p><b>Average household income in " + text1 + ":</b></br>" + currencyFormat.format(averageIncome) + "</p>");
         Double totalReturns = Double.parseDouble(totalReturnsInZIP(Integer.parseInt(text1), connection));
         out.println("<p><b>Total Returns in " + text1 + ":</b></br>" + numberFormat.format(totalReturns) + "</p>");

         out.println("</div>");
         out.println("<div class=\"column\">");

         out.println("<p><u><strong>ZIP Code: " + text2 + ".</strong></u></p>");
         averageIncome = Double.parseDouble(averageIncomeInZIP(Integer.parseInt(text2), connection)) * 1000;
         out.println("<p><b>Average household income in " + text2 + ":</b></br>" + currencyFormat.format(averageIncome) + "</p>");
         totalReturns = Double.parseDouble(totalReturnsInZIP(Integer.parseInt(text2), connection));
         out.println("<p><b>Total Returns in " + text2 + ":</b></br>" + numberFormat.format(totalReturns) + "</p>");

         out.println("</div>");
         out.println("</div>");

      }
      // All ZIP codes
      if (radioCount.equalsIgnoreCase("All") && radioType.equalsIgnoreCase("ZIP")) {
         out.println("<p><h2>All ZIP Codes</h2></p>");
      }

      // One State
      if (radioCount.equalsIgnoreCase("One") && radioType.equalsIgnoreCase("State")) {
         out.println("<p><h2>State: " + text1 + ".</h2></p>");
         out.println("<p><b>Top 5 restaurants in " + text1 + ":</b></br>" + topRestaurantsInState(text1, 5, connection) + "</p>");
         Double averageIncome = Double.parseDouble(averageIncomeInState(text1, connection)) * 1000;
         out.println("<p><b>Average household income in " + text1 + ":</b></br>" + currencyFormat.format(averageIncome)  + "</p>");
         Double totalReturns = Double.parseDouble(totalReturnsInState(text1, connection));
         out.println("<p><b>Total returns in in " + text1 + ":</b></br>" +  numberFormat.format(totalReturns) + "</p>");
         out.println("<p><b>Richest counties in " + text1 + ":</b></br>" + richestCountiesInState(text1, 5, connection) + "</p>");
         out.println("<p><b>Poorest counties in " + text1 + ":</b></br>" + poorestCountiesInState(text1, 5, connection) + "</p>");
         out.println("<p><b>Most common restaurants in the richest counties in " + text1 + ":</b></br>" + mostCommonRestaurantsInRichestCountiesInState(text1, 5, connection) + "</p>");
         out.println("<p><b>Most common restaurants in the poorest counties in " + text1 + ":</b></br>" + mostCommonRestaurantsInPoorestCountiesInState(text1, 5, connection) + "</p>");
      }
      // Two States
      if (radioCount.equalsIgnoreCase("Two") && radioType.equalsIgnoreCase("State")) {
         out.println("<p><h2>Two States: " + text1 + " and " + text2 + ".</h2></p>");

         out.println("<div class=\"row\">");
         out.println("<div class=\"column\">");

         out.println("<p><u><strong>State: " + text1 + ".</strong></u></p>");
         out.println("<p><b>Top 5 restaurants in " + text1 + ":</b></br>" + topRestaurantsInState(text1, 5, connection) + "</p>");
         Double averageIncome = Double.parseDouble(averageIncomeInState(text1, connection)) * 1000;
         out.println("<p><b>Average household income in " + text1 + ":</b></br>" + currencyFormat.format(averageIncome)  + "</p>");
         Double totalReturns = Double.parseDouble(totalReturnsInState(text1, connection));
         out.println("<p><b>Total returns in in " + text1 + ":</b></br>" +  numberFormat.format(totalReturns) + "</p>");
         out.println("<p><b>Richest counties in " + text1 + ":</b></br>" + richestCountiesInState(text1, 5, connection) + "</p>");
         out.println("<p><b>Poorest counties in " + text1 + ":</b></br>" + poorestCountiesInState(text1, 5, connection) + "</p>");
         out.println("<p><b>Most common restaurants in the richest counties in " + text1 + ":</b></br>" + mostCommonRestaurantsInRichestCountiesInState(text1, 5, connection) + "</p>");
         out.println("<p><b>Most common restaurants in the poorest counties in " + text1 + ":</b></br>" + mostCommonRestaurantsInPoorestCountiesInState(text1, 5, connection) + "</p>");

         out.println("</div>");
         out.println("<div class=\"column\">");

         out.println("<p><u><strong>State: " + text2 + ".</strong></u></p>");
         out.println("<p><b>Top 5 restaurants in " + text2 + ":</b></br>" + topRestaurantsInState(text2, 5, connection) + "</p>");
         averageIncome = Double.parseDouble(averageIncomeInState(text2, connection)) * 1000;
         out.println("<p><b>Average household income in " + text2 + ":</b></br>" + currencyFormat.format(averageIncome)  + "</p>");
         totalReturns = Double.parseDouble(totalReturnsInState(text2, connection));
         out.println("<p><b>Total returns in in " + text2 + ":</b></br>" +  numberFormat.format(totalReturns) + "</p>");
         out.println("<p><b>Richest counties in " + text2 + ":</b></br>" + richestCountiesInState(text2, 5, connection) + "</p>");
         out.println("<p><b>Poorest counties in " + text2 + ":</b></br>" + poorestCountiesInState(text2, 5, connection) + "</p>");
         out.println("<p><b>Most common restaurants in the richest counties in " + text2 + ":</b></br>" + mostCommonRestaurantsInRichestCountiesInState(text2, 5, connection) + "</p>");
         out.println("<p><b>Most common restaurants in the poorest counties in " + text2 + ":</b></br>" + mostCommonRestaurantsInPoorestCountiesInState(text2, 5, connection) + "</p>");

         out.println("</div>");
         out.println("</div>");

      }
      // All States
      if (radioCount.equalsIgnoreCase("All") && radioType.equalsIgnoreCase("State")) {
        out.println("<p><h2>All States</h2></p>");
        out.println("<p><b>Top restaurants total:</b></br>" + topRestaurantsEverywhere(5, connection) + "</p>");
        out.println("<p><b>Average income everywhere:</b></br>" + averageIncomeEverywhere(connection) + "</p>");
        Double totalReturns = Double.parseDouble(totalReturnsEverywhere(connection));
        out.println("<p><b>Total returns everywhere:</b></br>" + numberFormat.format(totalReturns) + "</p>");
        out.println("<p><b>Richest states (and average household income):</b></br>" + richestStatesEverywhere(5, connection) + "</p>");
        out.println("<p><b>Poorest states (and average household income):</b></br>" + poorestStatesEverywhere(5, connection) + "</p>");
        out.println("<p><b>Most common restaurants in richest states:</b></br>" + mostCommonRestaurantsInRichestStates(5, 5, connection) + "</p>");
        out.println("<p><b>Most common restaurants in poorest states:</b></br>" + mostCommonRestaurantsInPoorestStates(5, 5, connection) + "</p>");
      }

      // One Restaurant
      if (radioCount.equalsIgnoreCase("One") && radioType.equalsIgnoreCase("Restaurant")) {
         out.println("<p><strong>Restaurant: " + text1 + ".</strong></p>");
      }
      // Two Restaurants
      if (radioCount.equalsIgnoreCase("Two") && radioType.equalsIgnoreCase("Restaurant")) {
         out.println("<p><strong>Two Restaurants: " + text1 + " and " + text2 + ".</strong></p>");
      }
      // All Restaurants
      if (radioCount.equalsIgnoreCase("All") && radioType.equalsIgnoreCase("Restaurant")) {
         out.println("<p><strong>All Restaurants</strong></p>");
         out.println("<p><b>The top 5 most popular restaurants in the entire United States:</b></br>" + topRestaurantsEverywhere(5, connection) + "</p>");
      }

      out.println("<p><b><a href=\"index.jsp\">Go Back</a></p>");

%>
