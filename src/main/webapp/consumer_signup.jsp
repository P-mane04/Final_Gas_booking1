<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" 
    url="jdbc:mysql://localhost:3306/gas_book" 
    user="root" password="password"/>

<%
    String consumerId = request.getParameter("consumer_id");
    String mobile = request.getParameter("mobile");
    String password = request.getParameter("password");
%>

<!-- Check if consumer exists -->
<sql:query var="consumerCheck" dataSource="${db}">
    SELECT * FROM consumer WHERE consumer_id = ? AND phone = ?
    <sql:param value="<%= consumerId %>"/>
    <sql:param value="<%= mobile %>"/>
</sql:query>

<c:choose>
    <c:when test="${not empty consumerCheck.rows}">
        <c:set var="existingPassword" value="${consumerCheck.rows[0].password}" />

        <c:choose>
            <c:when test="${empty existingPassword}">
                <!-- If no password is set, update it -->
                <sql:update var="updatePassword" dataSource="${db}">
                    UPDATE consumer SET password = ? WHERE consumer_id = ? AND phone = ?
                    <sql:param value="<%= password %>"/>
                    <sql:param value="<%= consumerId %>"/>
                    <sql:param value="<%= mobile %>"/>
                </sql:update>

                <script>
                    alert("Password set successfully! You can now log in.");
                </script>
            </c:when>
            <c:otherwise>
                <script>
                    alert("You can login now.");
                </script>
            </c:otherwise>
        </c:choose>

        <script>
            window.location.href = "home.html";
        </script>
    </c:when>
    <c:otherwise>
        <script>
            alert("Your details are not registered by a distributor.");
            window.location.href = "home.html";
        </script>
    </c:otherwise>
</c:choose>
