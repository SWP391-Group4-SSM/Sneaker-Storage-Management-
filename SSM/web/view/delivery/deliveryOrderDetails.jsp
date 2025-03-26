<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Delivery Order Details</title>
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
        </style>
    </head>
    <body>
        <h1>Delivery Order #${deliveryOrder.deliveryOrderId} Details</h1>
        
        <div class="info-section">
            <h2>Order Information</h2>
            <table>
                <tr>
                    <th>Order ID</th>
                    <td>${deliveryOrder.deliveryOrderId}</td>
                </tr>
                <tr>
                    <th>Supplier ID</th>
                    <td>${deliveryOrder.supplierId}</td>
                </tr>
                <tr>
                    <th>Supplier Name</th>
                    <td>
                        <c:choose>
                            <c:when test="${deliveryOrder.supplierId != null && supplierNames.containsKey(deliveryOrder.supplierId)}">
                                ${supplierNames.get(deliveryOrder.supplierId)}
                            </c:when>
                            <c:otherwise>
                                N/A
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th>Warehouse</th>
                    <td>
                        <c:forEach var="warehouse" items="${warehouses}">
                            <c:if test="${warehouse.warehouseID == deliveryOrder.warehouseId}">
                                ${warehouse.warehouseID} - ${warehouse.name}
                            </c:if>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <th>Created by User</th>
                    <td>
                        <c:choose>
                            <c:when test="${deliveryOrder.createdByUserId != null && userNames.containsKey(deliveryOrder.createdByUserId)}">
                                ${deliveryOrder.createdByUserId} - ${userNames.get(deliveryOrder.createdByUserId)}
                            </c:when>
                            <c:otherwise>
                                ${deliveryOrder.createdByUserId}
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th>Document Date</th>
                    <td>${deliveryOrder.documentDate}</td>
                </tr>
                <tr>
                    <th>Status</th>
                    <td>${deliveryOrder.documentStatus}</td>
                </tr>
                <tr>
                    <th>Last Updated</th>
                    <td>${deliveryOrder.updatedAt}</td>
                </tr>
            </table>
        </div>
        
        <div class="info-section">
            <h2>Order Line Items</h2>
            <c:choose>
                <c:when test="${empty orderDetails}">
                    <p>No line items found for this delivery order.</p>
                </c:when>
                <c:otherwise>
                    <table>
                        <tr>
                            <th>Line ID</th>
                            <th>Product Detail ID</th>
                            <th>Quantity Ordered</th>
                            <th>Created At</th>
                            <th>Updated At</th>
                        </tr>
                        <c:forEach var="detail" items="${orderDetails}">
                            <tr>
                                <td>${detail.deliveryOrderDetailId}</td>
                                <td>${detail.productDetailId}</td>
                                <td>${detail.quantityOrdered}</td>
                                <td>${detail.createdAt}</td>
                                <td>${detail.updatedAt}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
        
        <a href="${pageContext.request.contextPath}/deliveryOrders" class="button">Back to Delivery Orders</a>
    </body>
</html>