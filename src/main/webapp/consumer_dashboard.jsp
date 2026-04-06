<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // Get consumer_id and distributor_id from the URL
    String consumerId = request.getParameter("consumer_id");
    String distributorId = request.getParameter("distributor_id");

    // If these parameters are missing, redirect to login
    if (consumerId == null || distributorId == null) {
%>
  
<%
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gas Booking Portal - Consumer Dashboard</title>
    <link rel="stylesheet" href="home1.min.css">
    <link rel="stylesheet" href="home.min.css">
    <link rel="stylesheet" href="home1.css">
    <link rel="icon" href="images/fev.png" type="image/png" />
    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>

    <style>
        body {
            background: url('images/5.jpg') no-repeat center center fixed;
            background-size: cover;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-inverse">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="#">Gas Booking Portal</a>
            </div>
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">Dashboard</a></li>
                <li><a href="book_gas.jsp?consumer_id=<%= consumerId %>&distributor_id=<%= distributorId %>">Book Order</a></li>
                <li><a href="track_order.jsp?consumer_id=<%= consumerId %>&distributor_id=<%= distributorId %>">Track Order</a></li>
                <li><a href="order_history.jsp?consumer_id=<%= consumerId %>&distributor_id=<%= distributorId %>">Order History</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="profile.jsp?consumer_id=<%= consumerId %>&distributor_id=<%= distributorId %>"><i class="fa fa-user"></i> Profile</a></li>
                <li><a href="home.html"><i class="fa fa-sign-out"></i> Logout</a></li>
            </ul>
        </div>
    </nav>
    
    <div class="container">
        <div id="bookOrder" class="well">
            <h3>Book a New Gas Cylinder</h3>
            <p>Click below to book your new gas cylinder.</p>
            <a href="book_gas.jsp?consumer_id=<%= consumerId %>&distributor_id=<%= distributorId %>">
                <button class="btn btn-primary">Book Now</button>
            </a>
        </div>
        
       <div id="trackOrder" class="well">
    <h3>Track Your Order</h3>
    <p>Enter your booking ID to track your order.</p>

    <form action="track_order.jsp" method="get">
        <input type="text" class="form-control" name="booking_id" placeholder="Enter Booking ID" required>
        <br>
        <button type="submit" class="btn btn-info">Track</button>
    </form>
</div>

        
        <div id="orderHistory" class="well">
            <h3>Order History</h3>
            <p>View all your past orders.</p>
            <a href="order_history.jsp?consumer_id=<%= consumerId %>&distributor_id=<%= distributorId %>">
                <button class="btn btn-success">View History</button>
            </a>
        </div>
    </div>
</body>
</html>
