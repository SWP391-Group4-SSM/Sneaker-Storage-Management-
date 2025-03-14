<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Thêm đơn hàng</title>
    </head>
    <body>
        <h2>Thêm sản phẩm</h2>
        <form action="productList" method="post">
            <input type="hidden" name="action" value="add">
            <label for="productId">Mã sản phẩm:</label>
            <input type="number" id="productId" name="productId" required>

            <label for="name">Tên sản phẩm:</label>
            <input type="text" id="name" name="name" required>

            <label for="description">Mô tả:</label>
            <input type="text" id="description" name="description" required>

            <label for="sku">Mã SKU:</label>
            <input type="text" id="sku" name="sku" required>
            
            <label for="price">Giá:</label>
            <input type="number" id="price" name="price" step="0.01" required>

            <button type="submit">Thêm đơn hàng</button>
            <a href="productList">Quay lại danh sách</a>

            <%-- Hiển thị thông báo lỗi nếu có --%>
            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% if (errorMessage != null) { %>
                <p class="error-message"><%= errorMessage %></p>
            <% } %>
        </form>
    </body>
</html>
