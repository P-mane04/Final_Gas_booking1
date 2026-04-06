<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<sql:setDataSource var="ds" driver="com.mysql.cj.jdbc.Driver"
    url="jdbc:mysql://localhost:3306/gas_book"
    user="root" password="password"/>

<%
    String distributorId = request.getParameter("distributor_id");
%>

<sql:query dataSource="${ds}" var="distributorData">
    SELECT * FROM distributor WHERE distributor_id = ?
    <sql:param value="<%= distributorId %>" />
</sql:query>

<!DOCTYPE html>
<html>
<head>
    <title>Distributor Dashboard</title>
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
        .distributor-info {
            color: black;
            margin-right: 15px;
            font-weight: bold;
        }
        .form-container {
            display: none;
            background: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
        }
    </style>
    <script>
        function toggleForm() {
            var form = document.getElementById('consumerForm');
            form.style.display = form.style.display === 'none' ? 'block' : 'none';
        }
    </script>
</head>
<body>
    <nav class="navbar navbar-inverse">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="#">
                    <img src="images/fev.png" alt="Logo"> Distributor Dashboard
                </a>
                <c:forEach var="distributor" items="${distributorData.rows}">
                    <span class="distributor-info">${distributor.name} | ${distributor.contact}</span>
                </c:forEach>
            </div>
            <ul class="nav navbar-nav">
                <li><a href="#" onclick="toggleForm()">Add Consumer</a></li>
               <li><a href="view_orders.jsp?distributor_id=<%= distributorId %>">View Orders</a></li>

                <li><a href="view_consumer.jsp?distributor_id=<%= distributorId %>">View Consumers</a></li>
				 <li><a href="view_bookings.jsp?distributor_id=<%= distributorId %>">View orders per Consumers</a></li> 
                 <li><a href="manage_orders.jsp?distributor_id=<%= distributorId %>">Manage Orders</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="home.html"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <h2>Welcome to Your Dashboard</h2>
        <p>Manage your consumers and orders easily.</p>

        <div id="consumerForm" class="form-container">
            <h3>Add Consumer</h3>
            <form action="add_consumer.jsp?distributor_id=<%= distributorId %>" method="POST">
                <input type="hidden" name="distributor_id" value="<%= distributorId %>">
                <div class="form-group">
                    <label>Name:</label>
                    <input type="text" name="name" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>Email:</label>
                    <input type="email" name="email" class="form-control" required>
                </div>
               
                <div class="form-group">
                    <label>Phone:</label>
                    <input type="text" name="phone" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>Address:</label>
                    <textarea name="address" class="form-control" required></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Add Consumer</button>
            </form>
        </div>

        <div id="imageCarousel" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
                <div class="item active">
                    <img src="images/1.jpg" alt="Image 1">
                </div>
                <div class="item">
                    <img src="images/2.jpg" alt="Image 2">
                </div>
                <div class="item">
                    <img src="images/3.jpg" alt="Image 3">
                </div>
                <div class="item">
                    <img src="images/4.jpg" alt="Image 4">
                </div>
            </div>
            <a class="left carousel-control" href="#imageCarousel" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left"></span>
            </a>
            <a class="right carousel-control" href="#imageCarousel" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right"></span>
            </a>
        </div>
    </div>
</body>
</html>
