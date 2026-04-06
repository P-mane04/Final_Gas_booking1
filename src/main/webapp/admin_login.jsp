<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%> 
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<sql:setDataSource 
    var="ds" 
    driver="com.mysql.cj.jdbc.Driver"
    url="jdbc:mysql://localhost:3306/gas_book"
    user="root" 
    password="password" />

<% 
    String adminId = request.getParameter("admin_id");
    String adminPassword = request.getParameter("password");
%>

<sql:query dataSource="${ds}" var="adminResult">
    SELECT * FROM admin WHERE admin_id = ? AND password = ?;
    <sql:param value="<%= adminId %>" />
    <sql:param value="<%= adminPassword %>" />
</sql:query>

<c:choose>
    <c:when test="${not empty adminResult.rows}">
        <c:redirect url="admin.html"/>
    </c:when>
    <c:otherwise>
        <script>
            alert("Please enter correct password");
            window.location.href = "home.html";
        </script>
    </c:otherwise>
</c:choose>


</body>
</html>