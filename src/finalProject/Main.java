package finalProject;

import java.sql.*;

public class Main {

    private static Connection connection;

    static {
        try {
            String url = "jdbc:mysql://localhost:3306/termproject";
            String password = "password";
            String username = "root";
            connection = DriverManager.getConnection(url, username, password);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws SQLException {

        System.out.println(topRestaurantsInZIP(30303, 4));
        System.out.println(topRestaurantsInCounty("Fulton County","GA", 4));
        System.out.println(averageIncomeInZIP(30303));
        System.out.println(averageIncomeInCounty("Fulton County","GA"));
        System.out.println(totalReturnsInZIP(30303));
        System.out.println(totalReturnsInCounty("Fulton County","GA"));
        System.out.println(topRestaurantsInState("GA", 4));
        System.out.println(averageIncomeInState("GA"));
        System.out.println(totalReturnsInState("GA"));
        System.out.println(richestCountiesInState("GA", 4));
        System.out.println(poorestCountiesInState("GA", 4));
        System.out.println(mostCommonRestaurantsInRichestCountiesInState("GA", 4));
        System.out.println(mostCommonRestaurantsInPoorestCountiesInState("GA", 4));
        System.out.println(topRestaurantsEverywhere(4));
        System.out.println(averageIncomeEverywhere());
        System.out.println(totalReturnsEverywhere());
        System.out.println(richestStatesEverywhere(4));
        System.out.println(poorestStatesEverywhere(4));
        System.out.println(mostCommonRestaurantsInRichestStates(2, 5));
        System.out.println(mostCommonRestaurantsInPoorestStates(2, 5));

    }

    /*
     * Get the top N Restaurants in a ZIP code
     */
    private static String topRestaurantsInZIP(int zipCode, int N) throws SQLException {

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
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append(" locations \n");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the top N Restaurants in a County
     */
    private static String topRestaurantsInCounty(String county, String state, int N) throws SQLException {

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
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append(" locations \n");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the average income for a ZIP code
     */
    private static String averageIncomeInZIP(int zip) throws SQLException {

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
    private static String averageIncomeInCounty(String county, String state) throws SQLException {

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
    private static String totalReturnsInZIP(int zip) throws SQLException {

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
    private static String totalReturnsInCounty(String county, String state) throws SQLException {

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
    private static String topRestaurantsInState(String state, int N) throws SQLException {

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
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append(" locations \n");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the average income for a state
     */
    private static String averageIncomeInState(String state) throws SQLException {

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
    private static String totalReturnsInState(String state) throws SQLException {

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
    private static String richestCountiesInState(String state, int N) throws SQLException {

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
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append("\n");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the N poorest counties in a state
     */
    private static String poorestCountiesInState(String state, int N) throws SQLException {

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
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append("\n");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the N most common restaurants in the richest counties in a state
     */
    private static String mostCommonRestaurantsInRichestCountiesInState(String state, int N) throws SQLException {

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
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append("\n");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the N most common restaurants in the poorest counties in a state
     */
    private static String mostCommonRestaurantsInPoorestCountiesInState(String state, int N) throws SQLException {

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
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append("\n");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the N most common restaurants in the US
     */
    private static String topRestaurantsEverywhere(int N) throws SQLException {

        String sql = "SELECT name, count(*) as number\n" +
                "FROM restaurants\n" +
                "GROUP BY name \n" +
                "ORDER BY count(*) DESC \n" +
                "LIMIT " + N;

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append("\n");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the average income in the US
     */
    private static String averageIncomeEverywhere() throws SQLException {

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
    private static String totalReturnsEverywhere() throws SQLException {

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
    private static String richestStatesEverywhere(int N) throws SQLException {

        String sql = "SELECT state, avgIncome\n" +
                "FROM taxdatasum\n" +
                "WHERE zipcode = 0\n" +
                "ORDER BY avgIncome DESC\n" +
                "LIMIT " + N;

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append("\n");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the N poorest states in the US
     */
    private static String poorestStatesEverywhere(int N) throws SQLException {

        String sql = "SELECT state, avgIncome\n" +
                "FROM taxdatasum\n" +
                "WHERE zipcode = 0\n" +
                "ORDER BY avgIncome\n" +
                "LIMIT " + N;

        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        StringBuilder stringBuilder = new StringBuilder();

        while (resultSet.next()) {
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append("\n");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the N most common restaurants in the M richest states in the US
     */
    private static String mostCommonRestaurantsInRichestStates(int N, int M) throws SQLException {

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
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append("\n");
        }

        return stringBuilder.toString();

    }

    /*
     * Get the N most common restaurants in the M poorest states in the US
     */
    private static String mostCommonRestaurantsInPoorestStates(int N, int M) throws SQLException {

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
            stringBuilder.append(resultSet.getString(1)).append(": ").append(resultSet.getInt(2)).append("\n");
        }

        return stringBuilder.toString();

    }

}