<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<html>
<head>
    <title>View Consumers</title>

    <!-- Favicon -->
    <link rel="icon" href="images/fev.png" type="image/png" />

    <!-- CSS Stylesheets -->
    <link rel="stylesheet" href="home1.min.css">
    <link rel="stylesheet" href="home.min.css">
    <link rel="stylesheet" href="home1.css">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">

    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <style>
        body {
            background: url('images/5.jpg') no-repeat center center fixed;
            background-size: cover;
        }
        .navbar {
            background-color: rgba(0, 0, 0, 0.8);
            padding: 10px;
            text-align: center;
        }
        .navbar a {
            color: white;
            font-size: 18px;
            text-decoration: none;
            padding: 10px 20px;
            margin: 5px;
            display: inline-block;
        }
        .navbar a:hover {
            background-color: #555;
            border-radius: 5px;
        }
        table {
            width: 80%;
            border-collapse: collapse;
            margin: 20px auto;
            font-size: 18px;
            text-align: left;
            background: white;
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            padding: 10px;
            border: 1px solid black;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
 <img src="images/fev.png" alt="Logo" style="height:30px;">
  <a href="admin.html"><i class="fa fa-plus"></i> Admin DashBoard</a>
    <a href="view_distributors.jsp"><i class="fa fa-truck"></i> View Distributors</a>
   <a href="manage_distributor.jsp"><i class="fa fa-plus"></i> Manages Distributor</a>
  <a href="home.html"><i class="fa fa-sign-out"></i> Logout</a>
</div>

<h2 align="center" style="color: white;">Consumer Details</h2>

<!-- Database Connection -->
<sql:setDataSource var="dbSource" driver="com.mysql.cj.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/gas_book"
                   user="root" password="password"/>

<!-- Query to retrieve consumer data -->
<sql:query dataSource="${dbSource}" var="result">
    SELECT consumer_id, name, email, phone, address FROM consumer;
</sql:query>

<table align="center">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Phone</th>
        <th>Address</th>
    </tr>

    <!-- Display fetched consumer data -->
    <c:forEach var="row" items="${result.rows}">
        <tr>
            <td>${row.consumer_id}</td>
            <td>${row.name}</td>
            <td>${row.email}</td>
            <td>${row.phone}</td>
            <td>${row.address}</td>
        </tr>
    </c:forEach>

    <!-- If no records are found -->
    <c:if test="${empty result.rows}">
        <tr>
            <td colspan="5" align="center">No Consumers Found</td>
        </tr>
    </c:if>

</table>

</body>
</html>
