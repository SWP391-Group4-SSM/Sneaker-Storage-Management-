<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Delivery Orders</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/deliveryOrder.css">
        <script>
            function confirmDelete(deliveryOrderId) {
                if (confirm("Are you sure you want to delete Delivery Order #" + deliveryOrderId + "?")) {
                     window.location.href = "${pageContext.request.contextPath}/deliveryOrders?action=delete&deliveryOrderId=" + deliveryOrderId;
                }
            }

            function updateDeliveryOrderDropdown() {
                const warehouseSelect = document.getElementById('warehouseSelect');
                const deliveryOrderSelect = document.getElementById('deliveryOrderSelect');
                const selectedWarehouseId = parseInt(warehouseSelect.value);

                console.log("Selected warehouse ID: " + selectedWarehouseId);

                // Clear existing options
                deliveryOrderSelect.innerHTML = '';

                // Add "All Delivery Orders" option
                const defaultOption = document.createElement('option');
                defaultOption.value = "-1";
                defaultOption.textContent = 'All Delivery Orders';
                deliveryOrderSelect.appendChild(defaultOption);

                // Direct approach - enumerate orders and check warehouse directly
            <c:forEach var="order" items="${allDeliveryOrders}">
                if (${order.warehouseId} == selectedWarehouseId || selectedWarehouseId == -1) {
                    const option = document.createElement('option');
                    option.value = "${order.deliveryOrderId}";
                    option.textContent = "${order.deliveryOrderId}";

                    // Check if this was the previously selected option
                    if (${order.deliveryOrderId} == ${deliveryOrderId != null ? deliveryOrderId : -1}) {
                        option.selected = true;
                    }

                    deliveryOrderSelect.appendChild(option);
                }
            </c:forEach>
            }

            // Initialize dropdown when page loads
            window.onload = function () {
                updateDeliveryOrderDropdown();
            };
        </script>
    </head>
    <body>
        <h1>Delivery Orders</h1>  

        <c:if test="${not empty sessionScope.deleteMessage}">
            <div class="${sessionScope.deleteStatus == 'success' ? 'success-message' : 'error-message'}">
                ${sessionScope.deleteMessage}
            </div>

            <c:remove var="deleteMessage" scope="session" />
            <c:remove var="deleteStatus" scope="session" />
        </c:if>

        <div class="info-section">
            <h2>Filter Options</h2>
            <div class="filter-form">
                <form action="${pageContext.request.contextPath}/deliveryOrders" method="get">
                    <label for="warehouseSelect">Warehouse:</label>
                    <select id="warehouseSelect" name="warehouseId" onchange="updateDeliveryOrderDropdown()">
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
                                <a href="javascript:void(0);" class="delete" onclick="return confirmDelete(${deliveryOrder.deliveryOrderId});">Delete</a>
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