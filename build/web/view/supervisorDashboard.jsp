<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Supervisor Dashboard</title>
</head>
<body>
    <h1>Welcome Supervisor</h1>
    <h2>Warehouses List</h2>
    <c:choose>
        <c:when test="${empty warehouses}">
            <p>No warehouses found.</p>
        </c:when>
        <c:otherwise>
            <table border="1">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Location</th>
                </tr>
                <c:forEach var="warehouse" items="${warehouses}">
                    <tr>
                        <td>${warehouse.warehouseID}</td>
                        <td>${warehouse.name}</td>
                        <td>${warehouse.location}</td>
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
</body>
</html>