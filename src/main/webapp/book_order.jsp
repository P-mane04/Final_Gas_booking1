<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="ds" driver="com.mysql.cj.jdbc.Driver"
    url="jdbc:mysql://localhost:3306/gas_book"
    user="root" password="password"/>

<%
    // Get consumer_id and distributor_id from request parameters
    String consumerId = request.getParameter("consumer_id");
    String distributorId = request.getParameter("distributor_id");

    if (consumerId == null || distributorId == null) {
%>
    <script>
        alert("Invalid Request! Please try again.");
        window.location.href = "home.html";
    </script>
<%
    } else {
%>

<!-- Check for existing pending booking -->
<sql:query dataSource="${ds}" var="pendingBooking">
    SELECT COUNT(*) AS count FROM booking WHERE consumer_id = ? AND status = 'Pending';
    <sql:param value="<%= consumerId %>" />
</sql:query>

<c:choose>
    <c:when test="${pendingBooking.rows[0].count > 0}">
        <script>
            alert("You already have a pending booking! Please wait until it is processed.");
            window.location.href = "consumer_dashboard.jsp?consumer_id=<%=consumerId %>&distributor_id=<%=distributorId %>";
        </script>
    </c:when>
    <c:otherwise>
        <!-- Insert new booking -->
        <sql:update dataSource="${ds}">
            INSERT INTO booking (consumer_id, distributor_id, status)
            VALUES (?, ?, 'Pending');
            <sql:param value="<%= consumerId %>" />
            <sql:param value="<%= distributorId %>" />
        </sql:update>

        <!-- Get latest booking ID -->
        <sql:query dataSource="${ds}" var="lastBooking">
            SELECT booking_id FROM booking 
            WHERE consumer_id = ? 
            ORDER BY booking_id DESC 
            LIMIT 1;
            <sql:param value="<%= consumerId %>" />
        </sql:query>

        <c:forEach var="row" items="${lastBooking.rows}">
            <script>
                if (confirm("Order booked successfully! Your Booking ID is: ${row.booking_id}.\nStatus: Pending.\n\nClick OK to go to Dashboard.")) {
                    window.location.href = "consumer_dashboard.jsp?consumer_id=<%=consumerId %>&distributor_id=<%=distributorId %>";
                } else {
                    window.location.href = "consumer_dashboard.jsp?consumer_id=<%=consumerId %>&distributor_id=<%=distributorId %>";
                }
            </script>
        </c:forEach>
    </c:otherwise>
</c:choose>

<% } %>
