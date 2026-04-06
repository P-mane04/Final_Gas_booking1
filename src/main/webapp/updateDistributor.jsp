<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<!-- Database Connection Pool -->
<sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" 
    url="jdbc:mysql://localhost:3306/gas_book" 
    user="root" password="password" />

<!-- Update Distributor Status -->
<sql:update dataSource="${db}" var="rows">
    UPDATE distributor SET status = ? WHERE distributor_id = ?
    <sql:param value="${param.status}" />
    <sql:param value="${param.distributor_id}" />
</sql:update>

<c:choose>
    <c:when test="${rows > 0}">
        <c:set var="message" value="Status updated successfully!" scope="session" />
    </c:when>
    <c:otherwise>
        <c:set var="message" value="Failed to update status." scope="session" />
    </c:otherwise>
</c:choose>

<c:redirect url="manage_distributor.jsp" />
