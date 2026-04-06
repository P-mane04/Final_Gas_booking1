<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="java.net.*, java.io.*, java.sql.*" %>

<html>
<head>
    <title>Manage Distributors</title>
    <style>
        body {
            background-image: url('images/5.jpg');
            background-size: cover;
            font-family: Arial, sans-serif;
        }
        table {
            width: 80%;
            border-collapse: collapse;
            margin: 20px auto;
            font-size: 18px;
            text-align: left;
        }
        th, td {
            padding: 10px;
            border: 1px solid black;
        }
        th {
            background-color: #f2f2f2;
        }
        .status-btn {
            padding: 5px 10px;
            border: none;
            cursor: pointer;
        }
        .active { background-color: green; color: white; }
        .deactivated { background-color: red; color: white; }
    </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<h2 align="center">Manage Distributors</h2>

<!-- Database Connection -->
<sql:setDataSource var="dbSource" driver="com.mysql.cj.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/gas_book"
                   user="root" password="password"/>


<sql:query dataSource="${dbSource}" var="result">
    SELECT distributor_id, distributor_name, email,  contact, status FROM distributor;
</sql:query>

<table align="center">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th> contact</th>
        <th>Status</th>
        <th>Action</th>
    </tr>

    <c:forEach var="row" items="${result.rows}">
        <tr>
            <td>${row.distributor_id}</td>
            <td>${row.distributor_name}</td>
            <td>${row.email}</td>
            <td>${row. contact}</td>
            <td>${row.status}</td>
            <td>
                <form action="updateDistributor.jsp" method="post">
                    <input type="hidden" name="distributor_id" value="${row.distributor_id}">
                    <input type="hidden" name=" contact" value="${row.email}">
                    <input type="hidden" name="email" value="${row.status}">
                    <select name="status">
                        <option value="Active" ${row.status == 'Active' ? 'selected' : ''}>Active</option>
                        <option value="Deactivated" ${row.status == 'Deactivated' ? 'selected' : ''}>Deactivated</option>
                    </select>
                    <button type="submit" class="status-btn">Update</button>
                </form>
            </td>
        </tr>
    </c:forEach>

    <c:if test="${empty result.rows}">
        <tr>
            <td colspan="6" align="center">No Distributors Found</td>
        </tr>
    </c:if>

</table>

</body>
</html>
