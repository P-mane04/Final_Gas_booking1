<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%

// Retrieve distributor_id from request
String distributorId = request.getParameter("distributor_id");
    // Retrieve distributor ID from session or request
    
    
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Consumer Booking</title>

    <!-- CSS for background and navbar -->
    <style>
        body {
            background-image: url('images/5.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            font-family: Arial, sans-serif;
            color: #fff;
        }

        .navbar {
            background-color: rgba(0, 0, 0, 0.8);
            overflow: hidden;
            padding: 10px;
        }

        .navbar ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }

        .navbar li {
            float: left;
            margin-right: 20px;
        }

        .navbar li a {
            color: white;
            text-decoration: none;
            padding: 8px 15px;
            display: block;
        }

        .navbar li a:hover {
            background-color: #555;
            border-radius: 5px;
        }

        .form-container {
            margin-top: 50px;
            background-color: rgba(0, 0, 0, 0.7);
            padding: 25px;
            border-radius: 10px;
            width: 450px;
            margin-left: auto;
            margin-right: auto;
        }

        table {
            width: 90%;
            margin: 30px auto;
            background-color: white;
            color: black;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid #000;
        }

        th, td {
            padding: 10px;
            text-align: center;
        }

        h2, h3 {
            text-align: center;
        }
    </style>
</head>

<body>
    <!-- Navigation Bar -->
    <div class="navbar">
        <ul class="nav navbar-nav">
        <li><a class="navbar-brand" href="distributor_dashboard.jsp?distributor_id=<%= distributorId %>"><img src="images/fev.png" alt="Logo" > Distributor Dashboard</a></li>
            <li><a href="view_orders.jsp?distributor_id=<%= distributorId %>">View Orders</a></li>
            <li><a href="view_consumer.jsp?distributor_id=<%= distributorId %>">View Consumers</a></li>
            <li><a href="view_bookings.jsp?distributor_id=<%= distributorId %>">View orders per Consumers</a></li>
            <li><a href="manage_orders.jsp?distributor_id=<%= distributorId %>">Manage Orders</a></li>
        </ul>
    </div>

    <h2>View Booking Report</h2>

    <div class="form-container">
        <form method="post">
            <label>Consumer ID:</label><br/>
            <input type="text" name="consumer_id" required />
            <br/><br/>
            <label>From Date:</label><br/>
            <input type="date" name="from_date" required />
            <br/><br/>
            <label>To Date:</label><br/>
            <input type="date" name="to_date" required />
            <br/><br/>
            <input type="submit" value="View Bookings" />
        </form>
    </div>

    <!-- SQL Connection -->
    <sql:setDataSource var="ds" driver="com.mysql.cj.jdbc.Driver"
        url="jdbc:mysql://localhost:3306/gas_book"
        user="root" password="password" />

    <c:if test="${not empty param.consumer_id}">
        <sql:query dataSource="${ds}" var="bookingResult">
            SELECT * FROM booking
            WHERE consumer_id = ?
              AND booking_date BETWEEN ? AND ?
              AND distributor_id = ?
            ORDER BY booking_date DESC
            <sql:param value="${param.consumer_id}" />
            <sql:param value="${param.from_date} 00:00:00" />
            <sql:param value="${param.to_date} 23:59:59" />
            <sql:param value="<%= distributorId %>" />
        </sql:query>

        <h3>Booking Report for Consumer ID: ${param.consumer_id}</h3>

        <c:if test="${bookingResult.rowCount > 0}">
            <table>
                <tr>
                    <th>Booking ID</th>
                    <th>Consumer ID</th>
                    <th>Distributor ID</th>
                    <th>Booking Date</th>
                    <th>Status</th>
                    <th>Delivery Date</th>
                </tr>
                <c:forEach var="row" items="${bookingResult.rows}">
                    <tr>
                        <td>${row.booking_id}</td>
                        <td>${row.consumer_id}</td>
                        <td>${row.distributor_id}</td>
                        <td>${row.booking_date}</td>
                        <td>${row.status}</td>
                        <td><c:out value="${row.delivery_date}" default="N/A"/></td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>

        <c:if test="${bookingResult.rowCount == 0}">
            <p style="text-align:center;">No bookings found in the given date range.</p>
        </c:if>
    </c:if>

    <script>
        function toggleForm() {
            alert("Add Consumer form will appear here.");
            // Implement your modal or redirect logic as needed
        }
    </script>
</body>
</html>
