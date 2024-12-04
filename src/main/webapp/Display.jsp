<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Vezba 8 Lekcija 6</title>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css">
</head>
<body>
    <div class="container">
        <!-- Search Form -->
        <form action="Display.jsp" method="post">
            <label for="id">Please enter Id</label>
            <input type="text" name="id" placeholder="Enter Id">
            <br>
            <input type="checkbox" name="seeAll" value="true">
            <label for="seeAll">See all entries</label>
            <br>
            <input type="submit" value="Submit">
        </form>

        <hr>

        <!-- Section to display results -->
        <% 
        String courseId = request.getParameter("id");
        String seeAll = request.getParameter("seeAll");

        if (seeAll != null && seeAll.equals("true")) {
            // See all entries
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/websiteproject", "marko", "abcd");
                PreparedStatement ps = con.prepareStatement("SELECT * FROM tasks");
                ResultSet rs = ps.executeQuery();

                if (!rs.isBeforeFirst()) {
        %>
                    <p>No records found in the database.</p>
        <%
                } else {
        %>
                    <table class="table table-bordered table-responsive table-striped">
                        <thead>
                            <tr>
                                <th>Developer ID</th>
                                <th>Name</th>
                                <th>Task</th>
                                <th>Completed Status</th>
                            </tr>
                        </thead>
                        <tbody>
        <%
                    while (rs.next()) {
        %>
                            <tr>
                                <td><%= rs.getInt(1) %></td>
                                <td><%= rs.getString(2) %></td>
                                <td><%= rs.getString(3) %></td>
                                <td><%= rs.getBoolean(4) ? "Yes" : "No" %></td>
                            </tr>
        <%
                    }
        %>
                        </tbody>
                    </table>
        <%
                }
            } catch (Exception ex) {
        %>
                <p>Error: <%= ex.getMessage() %></p>
        <%
            }
        } else if (courseId != null && !courseId.trim().isEmpty()) {
            // Search by ID
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/websiteproject", "marko", "abcd");
                PreparedStatement ps = con.prepareStatement("SELECT * FROM tasks WHERE DevId = ?");
                ps.setString(1, courseId);
                ResultSet rs = ps.executeQuery();

                if (!rs.isBeforeFirst()) {
        %>
                    <p>No records found for the given ID: <%= courseId %></p>
        <%
                } else {
        %>
                    <table class="table table-bordered table-responsive table-striped">
                        <thead>
                            <tr>
                                <th>Developer ID</th>
                                <th>Name</th>
                                <th>Task</th>
                                <th>Completed Status</th>
                            </tr>
                        </thead>
                        <tbody>
        <%
                    while (rs.next()) {
        %>
                            <tr>
                                <td><%= rs.getInt(1) %></td>
                                <td><%= rs.getString(2) %></td>
                                <td><%= rs.getString(3) %></td>
                                <td><%= rs.getBoolean(4) ? "Yes" : "No" %></td>
                            </tr>
        <%
                    }
        %>
                        </tbody>
                    </table>
        <%
                }
            } catch (Exception ex) {
        %>
                <p>Error: <%= ex.getMessage() %></p>
        <%
            }
        } else {
        %>
            <p>Please enter an ID or select "See all" to view all entries.</p>
        <% 
        }
        %>
    </div>

    <!-- Include Bootstrap JavaScript -->
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/jquery.js"></script>
</body>
</html>

