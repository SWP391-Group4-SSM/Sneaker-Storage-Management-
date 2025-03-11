<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Cập nhật Đơn hàng</title>
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

            input, select {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            button {
                width: 100%;
                padding: 10px;
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 5px;
                margin-top: 15px;
                cursor: pointer;
                font-size: 16px;
            }

            button:hover {
                background-color: #218838;
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

            /* Responsive */
            @media (max-width: 480px) {
                form {
                    width: 90%;
                }
            }
        </style>
    </head>
    <body>
        <h2>Cập nhật Đơn hàng</h2>
        <form action="purchaseOrder" method="post">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="id" value="${purchaseOrder.purchaseOrderId}">

            <label for="supplierId">Mã nhà cung cấp:</label>
            <input type="number" id="supplierId" name="supplierId" value="${purchaseOrder.supplierId}" required>

            <label for="warehouseId">Mã kho:</label>
            <input type="number" id="warehouseId" name="warehouseId" value="${purchaseOrder.warehouseId}" required>

            <label for="createdByUserId">Người tạo:</label>
            <input type="number" id="createdByUserId" name="createdByUserId" value="${purchaseOrder.createdByUserId}" required>

            <label for="totalAmount">Tổng số tiền:</label>
            <input type="number" id="totalAmount" name="totalAmount" step="0.01" value="${purchaseOrder.totalAmount}" required>

            <label for="purchaseOrderStatus">Trạng thái:</label>
            <select id="purchaseOrderStatus" name="purchaseOrderStatus">
                <option value="Draft" ${purchaseOrder.purchaseOrderStatus == 'Draft' ? 'selected' : ''}>Draft</option>
                <option value="Approved" ${purchaseOrder.purchaseOrderStatus == 'Approved' ? 'selected' : ''}>Approved</option>
                <option value="Ordered" ${purchaseOrder.purchaseOrderStatus == 'Ordered' ? 'selected' : ''}>Ordered</option>
                <option value="Goods Received" ${purchaseOrder.purchaseOrderStatus == 'Goods Received' ? 'selected' : ''}>Goods Received</option>
            </select>

            <button type="submit">Cập nhật đơn hàng</button>
            <a href="purchaseOrder">Quay lại danh sách</a>
        </form>
    </body>
</html>
