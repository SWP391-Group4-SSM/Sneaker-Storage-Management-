<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Thêm đơn hàng</title>
        <style>
            /* Reset mặc định */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }

            /* Định dạng trang */
            body {
                background-color: #f8f9fa;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                height: 100vh;
                padding: 20px;
            }

            h2 {
                color: #333;
                margin-bottom: 20px;
            }

            /* Form */
            form {
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 400px;
            }

            label {
                font-weight: bold;
                display: block;
                margin-top: 10px;
            }

            input {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            button {
                width: 100%;
                padding: 10px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 5px;
                margin-top: 15px;
                cursor: pointer;
                font-size: 16px;
            }

            button:hover {
                background-color: #0056b3;
            }

            /* Nút quay lại */
            a {
                display: block;
                text-align: center;
                margin-top: 10px;
                text-decoration: none;
                font-weight: bold;
                color: #007bff;
            }

            a:hover {
                color: #0056b3;
            }

            /* Hiển thị thông báo lỗi */
            .error-message {
                color: red;
                text-align: center;
                margin-top: 10px;
                font-weight: bold;
            }

            /* Responsive */
            @media (max-width: 480px) {
                form {
                    width: 90%;
                }
            }
        </style>
    </head>
    <body>
        <h2>Thêm Purchase Order</h2>
        <form action="purchaseOrder" method="post">
            <input type="hidden" name="action" value="add">
            <label for="purchaseOrderId">Mã Đơn Hàng:</label>
            <input type="number" id="purchaseOrderId" name="purchaseOrderId" required>

            <label for="supplierId">Mã nhà cung cấp:</label>
            <input type="number" id="supplierId" name="supplierId" required>

            <label for="warehouseId">Mã kho:</label>
            <input type="number" id="warehouseId" name="warehouseId" required>

            <label for="totalAmount">Tổng số tiền:</label>
            <input type="number" id="totalAmount" name="totalAmount" step="0.01" required>

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
