<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Delivery Orders</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
            }
            h1 {
                color: #333;
            }
            .info-section {
                margin-bottom: 30px;
            }
            .info-section h2 {
                color: #555;
                border-bottom: 1px solid #ddd;
                padding-bottom: 5px;
            }
            table {
                border-collapse: collapse;
                width: 100%;
                margin-top: 10px;
            }
            th, td {
                text-align: left;
                padding: 8px;
                border: 1px solid #ddd;
            }
            th {
                background-color: #f2f2f2;
            }
            tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            .button {
                display: inline-block;
                padding: 8px 16px;
                background-color: #4CAF50;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                margin-top: 20px;
            }
            .button:hover {
                background-color: #45a049;
            }
            select, input[type="submit"] {
                padding: 8px;
                margin: 5px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            input[type="submit"] {
                background-color: #4CAF50;
                color: white;
                cursor: pointer;
            }
            input[type="submit"]:hover {
                background-color: #45a049;
            }
            .filter-form {
                padding: 15px;
                background-color: #f9f9f9;
                border: 1px solid #ddd;
                border-radius: 4px;
                margin-bottom: 20px;
            }
            .pagination {
                margin: 20px 0;
            }
            .pagination a {
                display: inline-block;
                padding: 5px 10px;
                margin-right: 5px;
                border: 1px solid #ddd;
                text-decoration: none;
                color: #333;
                border-radius: 3px;
            }
            .pagination a:hover {
                background-color: #f5f5f5;
            }
            .pagination a.active {
                background-color: #4CAF50;
                color: white;
                border: 1px solid #4CAF50;
            }
            .action-links a {
                text-decoration: none;
                padding: 5px 10px;
                margin-right: 5px;
                background-color: #4CAF50;
                color: white;
                border-radius: 3px;
            }
            .action-links a.delete {
                background-color: #f44336;
            }
            .action-links a:hover {
                opacity: 0.8;
            }
            .success-message {
                background-color: #dff0d8;
                color: #3c763d;
                padding: 10px;
                margin: 10px 0;
                border-radius: 4px;
                border: 1px solid #d6e9c6;
            }
            .error-message {
                background-color: #f2dede;
                color: #a94442;
                padding: 10px;
                margin: 10px 0;
                border-radius: 4px;
                border: 1px solid #ebccd1;
            }
        </style>
        <script>
            function confirmDelete(deliveryOrderId) {
                if (confirm("Are you sure you want to delete Delivery Order #" + deliveryOrderId)) {
                    window.location.href = "${pageContext.request.contextPath}/deliveryOrders?action=delete&deliveryOrderId=" + deliveryOrderId;
                }
            }
        </script>
    </head>
    <body>
        <h1>Delivery Orders</h1>  

        <!-- Display status message if there is one -->
        <c:if test="${not empty sessionScope.deleteMessage}">
            <div class="${sessionScope.deleteStatus == 'success' ? 'success-message' : 'error-message'}">
                ${sessionScope.deleteMessage}
            </div>

            <!-- Clear the message after displaying it -->
            <c:remove var="deleteMessage" scope="session" />
            <c:remove var="deleteStatus" scope="session" />
        </c:if>

        <div class="info-section">
            <h2>Filter Options</h2>
            <div class="filter-form">
                <form action="${pageContext.request.contextPath}/deliveryOrders" method="get">
                    <label for="warehouseSelect">Warehouse:</label>
                    <select id="warehouseSelect" name="warehouseId">
                        <option value="-1">All Warehouses</option>
                        <c:forEach var="warehouse" items="${warehouses}">
                            <option value="${warehouse.warehouseID}" ${warehouse.warehouseID == warehouseId ? 'selected' : ''}>
                                ${warehouse.warehouseCode} - ${warehouse.name}
                            </option>
                        </c:forEach>
                    </select>

                    <label for="deliveryOrderSelect">Delivery Order ID:</label>
                    <select id="deliveryOrderSelect" name="deliveryOrderId">
                        <option value="-1">All Delivery Orders</option>
                        <c:forEach var="order" items="${allDeliveryOrders}">
                            <option value="${order.deliveryOrderId}" ${order.deliveryOrderId == deliveryOrderId ? 'selected' : ''}>
                                ${order.deliveryOrderId}
                            </option>
                        </c:forEach>
                    </select>

                    <input type="submit" value="Filter">
                </form>
            </div>
        </div>

        <div class="info-section">
            <h2>Delivery Order List</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Supplier ID</th>
                        <th>Supplier</th>
                        <th>Warehouse</th>
                        <th>Created by User</th>
                        <th>Document Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="deliveryOrder" items="${deliveryOrders}">
                        <tr>
                            <td>${deliveryOrder.deliveryOrderId}</td>
                            <td>${deliveryOrder.supplierId}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${deliveryOrder.supplierId != null}">
                                        ${supplierNames.get(deliveryOrder.supplierId)}
                                    </c:when>
                                    <c:otherwise>
                                        N/A
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${deliveryOrder.warehouseId != null}">
                                        <c:forEach var="warehouse" items="${warehouses}">
                                            <c:if test="${warehouse.warehouseID == deliveryOrder.warehouseId}">
                                                ${warehouse.warehouseID} - ${warehouse.name}
                                            </c:if>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        N/A
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${deliveryOrder.createdByUserId != null}">
                                        ${deliveryOrder.createdByUserId} -
                                        ${userNames.get(deliveryOrder.createdByUserId)}
                                    </c:when>
                                    <c:otherwise>
                                        N/A
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${deliveryOrder.documentDate}</td>
                            <td>${deliveryOrder.documentStatus}</td>
                            <td class="action-links">
                                <a href="${pageContext.request.contextPath}/deliveryOrders?action=details&deliveryOrderId=${deliveryOrder.deliveryOrderId}">Details</a>
                                <a href="javascript:void(0);" class="delete" onclick="confirmDelete(${deliveryOrder.deliveryOrderId});">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <div class="pagination">
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <a href="${pageContext.request.contextPath}/deliveryOrders?page=${i}&warehouseId=${warehouseId}&deliveryOrderId=${deliveryOrderId}" 
                       class="${i == currentPage ? 'active' : ''}">
                        ${i}
                    </a>
                </c:forEach>
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/createDeliveryOrder" class="button">Create Delivery Order</a>

    </body>
</html>