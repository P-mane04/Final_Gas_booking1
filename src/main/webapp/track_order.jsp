<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<html>
<head>
    <title>Track Booking</title>
    <style>
    
        body { background: url('images/5.jpg'); 
        font-family: Arial; padding: 20px; }
        table { border-collapse: collapse; width: 60%; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: center; }
    </style>
</head>
<body>

<h2>Track Your Booking</h2>


<c:if test="${not empty param.booking_id}">
    <sql:setDataSource var="ds" driver="com.mysql.cj.jdbc.Driver"
        url="jdbc:mysql://localhost:3306/gas_book"
        user="root" password="password"/>

    <sql:query dataSource="${ds}" var="result">
        SELECT * FROM booking WHERE booking_id = ?;
        <sql:param value="${param.booking_id}" />
    </sql:query>

    <c:choose> 
        <c:when test="${result.rowCount > 0}">
            <h3>Booking Details:</h3> 
          <center>  <table border="3">
                <tr>
                    <th>Booking ID</th>
                    <th>Consumer ID</th>
                    <th>Distributor ID</th>
                    <th>Status</th>
                </tr>
                <c:forEach var="row" items="${result.rows}">
                    <tr>
                        <td>${row.booking_id}</td>
                        <td>${row.consumer_id}</td>
                        <td>${row.distributor_id}</td>
                        <td>${row.status}</td>
                    </tr>
                </c:forEach>
            </table><center>
        </c:when>
        <c:otherwise>
            <script>alert("No booking found with ID: ${param.booking_id}");</script>
        </c:otherwise>
    </c:choose>
</c:if>

</body>
</html>
