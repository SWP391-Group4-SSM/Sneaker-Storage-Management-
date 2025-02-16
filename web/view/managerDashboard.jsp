<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Manager Dashboard</title>
    </head>
    <body>
        <h1>Welcome Manager</h1>
        <h2>Your Assigned Warehouses</h2>
        <c:choose>
            <c:when test="${empty warehouses}">
                <p>No warehouses assigned.</p>
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
                            <td><a href="view/zone.jsp?warehouseID=${warehouse.warehouseID}">Detail</a></td>
                            </tr>
                    </c:forEach>
                </table>
            </c:otherwise>
        </c:choose>
    </body>
</html>