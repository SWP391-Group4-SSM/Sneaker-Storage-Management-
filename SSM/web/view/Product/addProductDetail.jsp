<%-- 
    Document   : addProductDetail
    Created on : Mar 19, 2025, 5:08:32 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container">
        <h2>Thêm Chi Tiết Đơn Hàng Mua</h2>
        
        <!-- Hiển thị lỗi nếu có -->
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null) { %>
            <p class="error"><%= errorMessage %></p>
        <% } %>

        <form action="productDetails" method="post">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="proId" value="<%= request.getAttribute("productId") %>">

            <%= request.getAttribute("productId") %>
            <div class="form-group">
                <label for="ProductDetailID">Mã chi tiết sản phẩm:</label>
                <input type="text" id="ProductDetailID" name="ProductDetailID" required>
            </div>
            <div class="form-group">
                <label for="Size">Kích cỡ:</label>
                <input type="number" id="Size" name="Size" required>
            </div>
            <div class="form-group">
                <label for="Color">Màu:</label>
                <input type="text" id="Color" name="Color" required>
            </div>
            <div class="form-group">
                <label for="ImageURL">Image URL:</label>
                <input type="text" id="ImageURL" name="ImageURL" required>
            </div>
            <div class="form-group">
                <label for="Material">Material:</label>
                <input type="text" id="Material" name="Material" required>
            </div>
         
            <button type="submit" class="btn">Thêm</button>
        </form>
        <a href="productDetails?proId=<%= request.getAttribute("productId") %>" class="back-link">Quay lại danh sách</a>
    </div>
    </body>
</html>
