<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    
    String consumerId = request.getParameter("consumer_id");
    String distributorId = request.getParameter("distributor_id");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Gas Cylinder</title>
    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
    
    <style>
    strong{
    text-decoration: underline;
    background-color: orange;
    }
        body {
            background: url('images/5.jpg') no-repeat center center fixed;
            background-size: cover;
        }
        .container {
            max-width: 600px;
            background: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 10px;
            margin-top: 50px;
            text-align: center;
        }
        .instructions {
             font-family:sans-serif;
            text-align: left;
            margin-bottom: 20px;
        }
        .checkbox-container {
            margin-top: 15px;
            text-align: left;
        }
        .book-btn {
            margin-top: 10px;
            width: 100%;
            font-size: 18px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2><i class="fa fa-fire"></i> Gas Cylinder Booking</h2>
        <hr>
        
        <div class="instructions">
            <h4><strong>Important Instructions:</strong></h4>
            <ul>
            	 <li>We only accept the <strong>cash payment</strong>.</li>
                <li>Current price for a single gas cylinder is <strong>₹975</strong>.</li>
                <li><strong>Order cannot be canceled</strong> once you place it.</li>
                <li>Prices may change as per government rules.</li>
                <li>You cannot order more than <strong>one cylinder</strong> at a time.</li>
                <li>Once delivered, you can place an order for a refill.</li>
                <li>Order will be delivered to the <strong>registered address</strong>.</li>
                <li>Status updates will be sent via <strong>SMS and email</strong>.</li>
                <li>Delivery will be within a <strong>week</strong>. Otherwise, you may file a complaint.</li>
                <li><strong>First-come, first-served</strong> basis applies to all orders.</li>
            </ul>
        </div>
        
        <form action="book_order.jsp?consumer_id=<%= consumerId %>&distributor_id=<%= distributorId %>" method="post">
       
            
            <div class="checkbox-container">
                <input type="checkbox" id="agreeTerms">
                <label for="agreeTerms">I have read and accept the instructions.</label>
            </div>
            
            <button type="submit" id="bookButton" class="btn btn-primary book-btn" disabled>Book Gas Cylinder</button>
        </form>
    </div>

    <script>
       
        document.getElementById("agreeTerms").addEventListener("change", function() {
            document.getElementById("bookButton").disabled = !this.checked;
        });
    </script>
</body>
</html>
