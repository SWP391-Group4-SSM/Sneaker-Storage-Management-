<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Create Delivery Order</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/deliveryOrder.css">
        <script>
            function validateQuantity(input, maxQuantity) {
                const value = parseInt(input.value);
                if (isNaN(value) || value <= 0) {
                    input.setCustomValidity('Quantity must be a positive number');
                    return false;
                } else if (value > maxQuantity) {
                    input.setCustomValidity('Quantity cannot exceed ordered amount');
                    return false;
                } else {
                    input.setCustomValidity('');
                    return true;
                }
            }

            function updateWarehouse() {
                document.getElementById('poSelectionForm').submit();
            }

            function toggleItemSelection(checkbox, productId, maxQty) {
                const quantityInput = document.getElementById('qty_' + productId);
                const binSelect = document.getElementById('bin_' + productId);

                if (checkbox.checked) {
                    quantityInput.disabled = false;
                    binSelect.disabled = false;
                } else {
                    quantityInput.disabled = true;
                    binSelect.disabled = true;
                }
            }

            function validateForm() {
                let valid = false;
                const checkboxes = document.querySelectorAll('input[name="selectedItems"]:checked');

                if (checkboxes.length === 0) {
                    alert('Please select at least one item to add');
                    return false;
                }

                // Check each selected item has valid quantity and bin
                for (let i = 0; i < checkboxes.length; i++) {
                    const productId = checkboxes[i].value;
                    const qtyInput = document.getElementById('qty_' + productId);
                    const binSelect = document.getElementById('bin_' + productId);

                    if (!qtyInput.value || qtyInput.value <= 0) {
                        alert('Please enter a valid quantity for all selected items');
                        return false;
                    }

                    if (!binSelect.value) {
                        alert('Please select a bin for all selected items');
                        return false;
                    }

                    valid = true;
                }

                return valid;
            }
        </script>
    </head>
    <body>
        <h1>Create Delivery Order</h1>

        <c:if test="${not empty errorMessage}">
            <div class="error-message">${errorMessage}</div>
        </c:if>

        <c:if test="${not empty successMessage}">
            <div class="success-message">${successMessage}</div>
        </c:if>

        <div class="info-section">
            <h2>Purchase Order Selection</h2>
            <form id="poSelectionForm" action="${pageContext.request.contextPath}/createDeliveryOrder" method="post">
                <input type="hidden" name="action" value="selectPO">
                <div class="order-details">
                    <label for="purchaseOrderId">Purchase Order:</label>
                    <select name="purchaseOrderId" id="purchaseOrderId" onchange="updateWarehouse()" required>
                        <option value="">-- Select Purchase Order --</option>
                        <c:forEach var="po" items="${purchaseOrders}">
                            <option value="${po.purchaseOrderId}" ${selectedPO != null && selectedPO.purchaseOrderId == po.purchaseOrderId ? 'selected' : ''}>
                                PO #${po.purchaseOrderId}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </form>
        </div>

        <c:if test="${selectedPO != null}">
            <div class="info-section">
                <h2>Purchase Order Details</h2>
                <div class="order-details">
                    <p><strong>PO #:</strong> ${selectedPO.purchaseOrderId}</p>
                    <p><strong>Warehouse:</strong> ${warehouseName}</p>
                    <p><strong>Supplier:</strong> ${supplierName}</p>
                    <p><strong>Order Date:</strong> ${selectedPO.orderDate}</p>
                    <p><strong>Status:</strong> ${selectedPO.purchaseOrderStatus}</p>
                </div>
            </div>

            <div class="info-section">
                <h2>Add Multiple Items</h2>
                <form action="${pageContext.request.contextPath}/createDeliveryOrder" method="post" onsubmit="return validateForm()">
                    <input type="hidden" name="action" value="addMultipleItems">
                    <input type="hidden" name="purchaseOrderId" value="${selectedPO.purchaseOrderId}">

                    <div class="item-selection">
                        <table class="item-table">
                            <thead>
                                <tr>
                                    <th>Select</th>
                                    <th>Product ID</th>
                                    <th>Ordered Quantity</th>
                                    <th>Quantity to Receive</th>
                                    <th>Temporary Bin</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="poDetail" items="${poDetails}">
                                    <c:if test="${!addedItems.containsKey(poDetail.productDetailId)}">
                                        <tr>
                                            <td>
                                                <input type="checkbox" name="selectedItems" value="${poDetail.productDetailId}" 
                                                       onchange="toggleItemSelection(this, ${poDetail.productDetailId}, ${poDetail.quantityOrdered})">
                                            </td>
                                            <td>${poDetail.productDetailId}</td>
                                            <td>${poDetail.quantityOrdered}</td>
                                            <td>
                                                <input type="number" name="quantity_${poDetail.productDetailId}" id="qty_${poDetail.productDetailId}" 
                                                       min="1" max="${poDetail.quantityOrdered}" required disabled
                                                       onchange="validateQuantity(this, ${poDetail.quantityOrdered})">
                                            </td>
                                            <td>
                                                <select name="bin_${poDetail.productDetailId}" id="bin_${poDetail.productDetailId}" required disabled>
                                                    <option value="">-- Select Bin --</option>
                                                    <c:forEach var="bin" items="${tempBins}">
                                                        <option value="${bin.binId}">Bin #${bin.binId} - ${bin.binName}</option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>

                        <div class="action-buttons">
                            <button type="submit">Add Selected Items</button>
                        </div>
                    </div>
                </form>
            </div>

            <c:if test="${not empty addedItems}">
                <div class="info-section added-items">
                    <h2>Added Items</h2>
                    <table class="item-table">
                        <thead>
                            <tr>
                                <th>Product ID</th>
                                <th>Quantity</th>
                                <th>Bin</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${addedItems}">
                                <tr>
                                    <td>${item.key}</td>
                                    <td>${item.value.quantity}</td>
                                    <td>Bin #${item.value.binId}</td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/createDeliveryOrder" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="removeItem">
                                            <input type="hidden" name="purchaseOrderId" value="${selectedPO.purchaseOrderId}">
                                            <input type="hidden" name="productDetailId" value="${item.key}">
                                            <button type="submit" class="button-small">Remove</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <form action="${pageContext.request.contextPath}/createDeliveryOrder" method="post">
                        <input type="hidden" name="action" value="createDO">
                        <input type="hidden" name="purchaseOrderId" value="${selectedPO.purchaseOrderId}">

                        <div class="action-buttons">
                            <button type="submit">Create Delivery Order</button>
                        </div>
                    </form>
                </div>
            </c:if>
        </c:if>

        <div class="navigation-buttons">
            <a href="${pageContext.request.contextPath}/deliveryOrders" class="button">Back to Delivery Orders</a>
        </div>
    </body>
</html>