<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" 
    url="jdbc:mysql://localhost:3306/gas_book" 
    user="root" password="password"/>

<!-- Check if consumer exists with correct password -->
<sql:query var="consumerLogin" dataSource="${db}">
    SELECT consumer_id, distributor_id FROM consumer WHERE consumer_id = ? AND password = ?
    <sql:param value="${param.consumer_id}"/>
    <sql:param value="${param.password}"/>
</sql:query>

<c:choose>
    <c:when test="${not empty consumerLogin.rows}">
        <!-- Get consumer and distributor details -->
        <c:set var="consumer" value="${consumerLogin.rows[0]}" />

        <!-- Redirect with URL rewriting -->
        <c:set var="redirectURL" value="consumer_dashboard.jsp?consumer_id=${consumer.consumer_id}&distributor_id=${consumer.distributor_id}"/>
        
        <script>
            alert("Login Successful! Redirecting...");
            window.location.href = "${redirectURL}";
        </script>
    </c:when>
    <c:otherwise>
        <!-- Login failed, show alert and redirect to home -->
        <script>
            alert("Invalid Consumer ID or Password. Please try again.");
            window.location.href = "home.html";
        </script>
    </c:otherwise>
</c:choose>
