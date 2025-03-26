<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Chi Tiết Đơn Hàng Mua</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
        }
        h2 {
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }
        label {
            font-weight: bold;
            display: block;
        }
        input {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .error {
            color: red;
            font-size: 14px;
            margin-bottom: 10px;
            text-align: center;
        }
        .btn {
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }
        .btn:hover {
            background-color: #218838;
        }
        .back-link {
            display: block;
            margin-top: 15px;
            text-align: center;
            color: #007bff;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Thêm Chi Tiết Đơn Hàng Mua</h2>
        
        <!-- Hiển thị lỗi nếu có -->
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null) { %>
            <p class="error"><%= errorMessage %></p>
        <% } %>

        <form action="purchaseOrderDetail" method="post">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="poId" value="<%= request.getAttribute("purchaseOrderId") %>">

            <%= request.getAttribute("purchaseOrderId") %>
            <div class="form-group">
                <label for="purchaseOrderDetailID">Mã Pod:</label>
                <input type="text" id="purchaseOrderDetailID" name="purchaseOrderDetailID" required>
            </div>
            <div class="form-group">
                <label for="productDetailId">Mã sản phẩm:</label>
                <input type="number" id="productDetailId" name="productDetailId" required>
            </div>
            
            <div class="form-group">
                <label for="quantityOrdered">Số lượng:</label>
                <input type="number" id="quantityOrdered" name="quantityOrdered" required>
            </div>
            
            <div class="form-group">
                <label for="unitPrice">Giá mỗi đơn vị:</label>
                <input type="text" id="unitPrice" name="unitPrice" step="0.01" required>
            </div>

            <button type="submit" class="btn">Thêm</button>
        </form>
        <a href="purchaseOrderDetail?poId=<%= request.getAttribute("purchaseOrderId") %>" class="back-link">Quay lại danh sách</a>
    </div>
</body>
</html>
