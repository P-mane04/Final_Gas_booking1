<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<sql:setDataSource var="ds" driver="com.mysql.cj.jdbc.Driver"
    url="jdbc:mysql://localhost:3306/gas_book"
    user="root" password="password"/>
    <%
    String distributorId = request.getParameter("distributor_id");
%>

<!-- Insert consumer into the database -->
<sql:update dataSource="${ds}" var="insertResult">
    INSERT INTO consumer (distributor_id, name, email, password, phone, address)
    VALUES (?, ?, ?, ?, ?, ?);
    <sql:param value="${param.distributor_id}" />
    <sql:param value="${param.name}" />
    <sql:param value="${param.email}" />
    <sql:param value="${param.password}" />
    <sql:param value="${param.phone}" />
    <sql:param value="${param.address}" />
</sql:update>

<!-- Get the latest consumer ID added -->
<sql:query dataSource="${ds}" var="consumerIdQuery">
    SELECT consumer_id FROM consumer WHERE email = ?;
    <sql:param value="${param.email}" />
</sql:query>

<!-- Redirect with JavaScript Alert -->
<c:choose>
    <c:when test="${not empty consumerIdQuery.rows}">
        <c:set var="consumerId" value="${consumerIdQuery.rows[0].consumer_id}" />
        <script>
            alert("Consumer added successfully! Consumer ID: ${consumerId}");
            window.location.href = "distributor_dashboard.jsp";
        </script>
    </c:when>
    <c:otherwise>
        <script>
            alert("Error adding consumer. Please try again.");
            window.history.back();
        </script>
    </c:otherwise>
</c:choose>
