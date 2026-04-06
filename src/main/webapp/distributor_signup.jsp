<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<html>
<head>
    <title>Distributor Signup</title>
    <script>
        function showAlert(distributorId) {
            alert("Signup successful! Your Distributor ID is: " + distributorId);
            window.location.href = 'home.html';  // Redirect to home.html after signup
        }
    </script>
</head>
<body>

<sql:setDataSource var="dbSource" driver="com.mysql.cj.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/gas_book"
                   user="root" password="password"/>

<sql:update dataSource="${dbSource}" var="rowsAffected">
    INSERT INTO distributor (distributor_name, contact, email, password, address, city)
    VALUES (?, ?, ?, ?, ?, ?);
    <sql:param value="${param.distributor_name}" />
    <sql:param value="${param.contact}" />
    <sql:param value="${param.email}" />
    <sql:param value="${param.password}" />
    <sql:param value="${param.address}" />
    <sql:param value="${param.city}" />
</sql:update>

<sql:query dataSource="${dbSource}" var="distributor">
    SELECT distributor_id FROM distributor WHERE email = ?;
    <sql:param value="${param.email}" />
</sql:query>

<c:if test="${not empty distributor.rows}">
    <c:set var="distributorId" value="${distributor.rows[0].distributor_id}" />
    <script>showAlert(${distributorId});</script>
</c:if>

</body>
</html>
