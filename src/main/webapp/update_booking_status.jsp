<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<sql:setDataSource var="ds" driver="com.mysql.cj.jdbc.Driver"
    url="jdbc:mysql://localhost:3306/gas_book"
    user="root" password="password"/>

<%
    // Retrieve parameters from request
    String bookingId = request.getParameter("booking_id");
    String status = request.getParameter("status");
    String distributorId = request.getParameter("distributor_id"); // Get distributor ID for redirection

    // Check if values are not null to avoid errors
    if (bookingId != null && status != null) {
%>

    <sql:update dataSource="${ds}">
        UPDATE booking SET status = ? WHERE booking_id = ?;
        <sql:param value="<%= status %>" />
        <sql:param value="<%= bookingId %>" />
    </sql:update>

<%
        // Redirect to the Distributor Dashboard after updating
        response.sendRedirect("distributor_dashboard.jsp?distributor_id=" + distributorId);
    } else {
        out.print("Error: Missing booking_id or status.");
    }
%>
