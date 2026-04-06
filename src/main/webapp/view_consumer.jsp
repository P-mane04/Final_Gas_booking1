<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<sql:setDataSource var="ds" driver="com.mysql.cj.jdbc.Driver"
    url="jdbc:mysql://localhost:3306/gas_book"
    user="root" password="password"/>

<%
    // Get distributor ID from session or request
    String distributorId = request.getParameter("distributor_id");
%>

<sql:query dataSource="${ds}" var="consumerList">
    SELECT * FROM consumer WHERE distributor_id = ?
    <sql:param value="<%= distributorId %>" />
</sql:query>

<!DOCTYPE html>
<html>
<head>
    <title>View Consumers</title>
    <link rel="stylesheet" href="home1.min.css">
    <link rel="stylesheet" href="home.min.css">
    <link rel="stylesheet" href="home1.css">
    <link rel="icon" href="images/fev.png" type="image/png" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <style>
        body {
            background: url('images/5.jpg') no-repeat center center fixed;
            background-size: cover;
        }
        .navbar-brand img {
            height: 30px;
            display: inline;
        }
        .container {
            margin-top: 20px;
            background: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }
        table, th, td {
            border: 1px solid black;
            text-align: center;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<input type="hidden" name="distributorId" value="<%= distributorId %>">

    <!-- Navbar -->
    <nav class="navbar navbar-inverse">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="distributor_dashboard.jsp">
                    <img src="images/fev.png" alt="Logo"> Distributor Dashboard
                </a>
            </div>
            <ul class="nav navbar-nav">
                <li><a href="view_consumer.jsp?distributor_id=<%= distributorId %>">View Consumers</a></li>
                <li><a href="view_orders.jsp?distributor_id=<%= distributorId %>">View Orders</a></li>
                <li><a href="manage_orders.jsp?distributor_id=<%= distributorId %>">Manage Orders</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="home.html"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <h2>Consumers Under Your Distribution</h2>
        <table>
            <tr>
                <th>Consumer ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Address</th>
                <th>Created At</th>
            </tr>
            <c:forEach var="consumer" items="${consumerList.rows}">
                <tr>
                    <td>${consumer.consumer_id}</td>
                    <td>${consumer.name}</td>
                    <td>${consumer.email}</td>
                    <td>${consumer.phone}</td>
                    <td>${consumer.address}</td>
                    <td>${consumer.created_at}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>
