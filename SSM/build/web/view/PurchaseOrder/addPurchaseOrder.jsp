<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Thêm đơn hàng</title>
    </head>
    <body>
        <h2>Thêm Purchase Order</h2>
        <form action="addPurchaseOrder" method="post">
            <label for="purchaseOrderId">Mã Đơn Hàng:</label>
            <input type="number" id="purchaseOrderId" name="purchaseOrderId" required><br>
            <label for="supplierId">Mã nhà cung cấp:</label>
            <input type="number" id="supplierId" name="supplierId" required><br>

            <label for="warehouseId">Mã kho:</label>
            <input type="number" id="warehouseId" name="warehouseId" required><br>

            <label for="createdByUserId">Người tạo:</label>
            <input type="number" id="createdByUserId" name="createdByUserId" required><br>

            <label for="totalAmount">Tổng số tiền:</label>
            <input type="number" id="totalAmount" name="totalAmount" step="0.01" required><br>

            <label for="orderDate">Ngày đặt hàng:</label>
            <input type="datetime-local" id="orderDate" name="orderDate" required><br>

            <button type="submit">Thêm đơn hàng</button>
            <a href="purchaseOrder">Quay lại danh sách</a>
            <%-- Hiển thị thông báo lỗi nếu có --%>
            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% if (errorMessage != null) { %>
            <p style="color: red;"><%= errorMessage %></p>
            <% } %>
        </form>
        <br>
        <a href="purchaseOrder">Quay lại danh sách</a>
    </body>
</html>
