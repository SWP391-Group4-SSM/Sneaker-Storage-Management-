<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Cập nhật Đơn hàng</title>
    </head>
    <body>
        <h2>Cập nhật Đơn hàng</h2>

        <form action="updatePurchaseOrder" method="post">
            <input type="hidden" name="id" value="${purchaseOrder.purchaseOrderId}">

            <label for="supplierId">Mã nhà cung cấp:</label>
            <input type="number" id="supplierId" name="supplierId" value="${purchaseOrder.supplierId}" required><br>

            <label for="warehouseId">Mã kho:</label>
            <input type="number" id="warehouseId" name="warehouseId" value="${purchaseOrder.warehouseId}" required><br>

            <label for="createdByUserId">Người tạo:</label>
            <input type="number" id="createdByUserId" name="createdByUserId" value="${purchaseOrder.createdByUserId}" required><br>

            <label for="totalAmount">Tổng số tiền:</label>
            <input type="number" id="totalAmount" name="totalAmount" step="0.01" value="${purchaseOrder.totalAmount}" required><br>

            <label for="purchaseOrderStatus">Trạng thái:</label>
            <select id="purchaseOrderStatus" name="purchaseOrderStatus">
                <option value="Draft" ${purchaseOrder.purchaseOrderStatus == 'Draft' ? 'selected' : ''}>Draft</option>
                <option value="Approved" ${purchaseOrder.purchaseOrderStatus == 'Approved' ? 'selected' : ''}>Approved</option>
                <option value="Ordered" ${purchaseOrder.purchaseOrderStatus == 'Ordered' ? 'selected' : ''}>Ordered</option>
                <option value="Goods Received" ${purchaseOrder.purchaseOrderStatus == 'Goods Received' ? 'selected' : ''}>Goods Received</option>
            </select><br>

            <button type="submit">Cập nhật đơn hàng</button>
            <a href="purchaseOrder">Quay lại danh sách</a>
        </form>
    </body>
</html>
