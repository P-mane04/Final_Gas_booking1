<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<html>
<head>
    <title>Order History</title>
    <style>
        body {  background: url('images/5.jpg');
        font-family: Arial; padding: 20px; }
        table { border-collapse: collapse; width: 80%; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: center; }
        h2 { margin-bottom: 20px; }
    </style>
</head>
<body>

<h2>Your Order History</h2>

<c:if test="${not empty param.consumer_id}">
    <sql:setDataSource var="ds" driver="com.mysql.cj.jdbc.Driver"
        url="jdbc:mysql://localhost:3306/gas_book"
        user="root" password="password" />

    <!-- Fetch all bookings for this consumer -->
    <sql:query dataSource="${ds}" var="history">
        SELECT booking_id, consumer_id, distributor_id, status, booking_date
        FROM booking
        WHERE consumer_id = ?
        ORDER BY booking_id DESC;
        <sql:param value="${param.consumer_id}" />
    </sql:query>

    <c:choose>
        <c:when test="${history.rowCount > 0}">
          <center>  <table border="3">
                <tr>
                    <th>Booking ID</th>
                    <th>Distributor ID</th>
                    <th>Status</th>
                    <th>Date</th>
                </tr>
                <c:forEach var="row" items="${history.rows}">
                    <tr>
                        <td>${row.booking_id}</td>
                        <td>${row.distributor_id}</td>
                        <td>${row.status}</td>
                        <td>${row.booking_date}</td>
                    </tr>
                </c:forEach>
            </table><center> 
        </c:when>
        <c:otherwise>
            <p>No orders found for this consumer.</p>
        </c:otherwise>
    </c:choose>

</c:if>

</body>
</html>
