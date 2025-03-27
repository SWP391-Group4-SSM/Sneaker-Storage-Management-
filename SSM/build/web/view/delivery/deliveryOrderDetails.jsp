<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Delivery Order Details</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/deliveryOrder.css">
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