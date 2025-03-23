<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.PurchaseOrderDetail" %>
<%@ page import="model.Supplier" %>
<%@ page import="model.Warehouse" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Thêm đơn hàng</title>
        

    </head>
    <body>
        <h2>Thêm Purchase Order</h2>
        <form action="purchaseOrder" method="post">
            <input type="hidden" name="action" value="add">
            <label for="purchaseOrderId">Mã Đơn Hàng:</label>
            <input type="number" id="purchaseOrderId" name="purchaseOrderId" required>

            <label for="supplierId">Nhà cung cấp:</label>
            <select id="supplierId" name="supplierId" required>
                <option value="">-- Chọn nhà cung cấp --</option>
                <% 
                    List<Supplier> suppliers = (List<Supplier>) request.getAttribute("suppliers");
                    if (suppliers != null) {
                        for (Supplier supplier : suppliers) { 
                %>
                <option value="<%= supplier.getSupplierID() %>"><%= supplier.getSupplierName() %></option>
                <% 
                        }
                    } 
                %>
            </select>


            <label for="warehouseId">Nhà kho:</label>
            <select id="warehouseId" name="warehouseId" required>
                <option value="">-- Chọn nhà kho --</option>
                <% 
                    List<Warehouse> warehouses = (List<Warehouse>) request.getAttribute("warehouses");
                    if (warehouses != null) {
                        for (Warehouse warehouse : warehouses) { 
                %>
                <option value="<%= warehouse.getWarehouseID() %>"><%= warehouse.getName() %></option>
                <% 
                        }
                    } 
                %>
            </select>

            <label for="orderDate">Ngày đặt hàng:</label>
            <input type="datetime-local" id="orderDate" name="orderDate" required>

            <button type="submit">Thêm đơn hàng</button>
            <a href="purchaseOrder">Quay lại danh sách</a>

            <%-- Hiển thị thông báo lỗi nếu có --%>
            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% if (errorMessage != null) { %>
            <p class="error-message"><%= errorMessage %></p>
            <% } %>
        </form>
    </body>
</html>
