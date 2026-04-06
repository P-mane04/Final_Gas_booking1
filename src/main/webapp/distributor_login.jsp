<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<sql:setDataSource var="ds" driver="com.mysql.cj.jdbc.Driver"
    url="jdbc:mysql://localhost:3306/gas_book"
    user="root" password="password"/>

<%
    String distributorId = request.getParameter("distributor_id");
    String password = request.getParameter("password");
%>

<sql:query dataSource="${ds}" var="result">
    SELECT * FROM distributor WHERE distributor_id = ? AND password = ?
    <sql:param value="<%= distributorId %>" />
    <sql:param value="<%= password %>" />
</sql:query>

<c:choose>
    <c:when test="${not empty result.rows}">
        <c:set var="distributor" value="${result.rows[0]}" />
        
        <c:choose>
            <c:when test="${distributor.status eq 'Active'}">
                <c:redirect url="distributor_dashboard.jsp?distributor_id=${distributor.distributor_id}"/>
            </c:when>
            <c:otherwise>
                <script>
                    alert("The admin has not yet approved your documents. Try again later.");
                    window.location.href = "home.html";
                </script>
            </c:otherwise>
        </c:choose>

    </c:when>
    <c:otherwise>
        <script>
            alert("Invalid Distributor ID or Password");
            window.location.href = "home.html";
        </script>
    </c:otherwise>
</c:choose>
