<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Staff Dashboard</title>
</head>
<body>
    <h1>Welcome Staff</h1>
    <h2>Your Stock Items</h2>
    <c:choose>
        <c:when test="${empty stock}">
            <p>No stock items found.</p>
        </c:when>
        <c:otherwise>
            <table border="1">
                <tr>
                    <th>Product ID</th>
                    <th>Warehouse ID</th>
                    <th>Zone ID</th>
                    <th>Bin ID</th>
                    <th>Quantity</th>
                </tr>
                <c:forEach var="item" items="${stock}">
                    <tr>
                        <td>${item.productID}</td>
                        <td>${item.warehouseID}</td>
                        <td>${item.zoneID}</td>
                        <td>${item.binID}</td>
                        <td>${item.quantity}</td>
                    </tr>
                </c:forEach>
            </table>
            <a href="">Warehouse detail</a>
        </c:otherwise>
    </c:choose>
</body>
</html>