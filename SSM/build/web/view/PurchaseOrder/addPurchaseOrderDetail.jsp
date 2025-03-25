<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.PurchaseOrderDetail" %>
<%@ page import="model.Supplier" %>
<%@ page import="model.Warehouse" %>
<%@ page import="model.ProductDetail" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thêm Chi Tiết Đơn Hàng Mua</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container">
            <h2>Thêm Chi Tiết Đơn Hàng Mua</h2>

            <!-- Hiển thị lỗi nếu có -->
            <%
    String errorMessage = (String) session.getAttribute("errorMessage");
    if (errorMessage != null) {
            %>
            <p class="error-message"><%= errorMessage %></p>
            <%
                    session.removeAttribute("errorMessage"); // Xóa sau khi hiển thị
                }
            %>

            <form action="purchaseOrderDetail" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="poId" value="<%= request.getAttribute("purchaseOrderId") %>">

                <%= request.getAttribute("purchaseOrderId") %>
                <div class="form-group">
                    <label for="purchaseOrderDetailID">Mã Pod:</label>
                    <input type="text" id="purchaseOrderDetailID" name="purchaseOrderDetailID" required>
                </div>
                <div class="form-group">
                    <label for="productDetailId">Sản phẩm:</label>
                    <div class="input-group">
                        <input type="hidden" id="productDetailId" name="productDetailId">
                        <button type="button" onclick="openProductModal()">Chọn sản phẩm</button>
                    </div>
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

        <div id="productModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeProductModal()">&times;</span>
                <h2>Chọn sản phẩm</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Mã chi tiết sản phẩm</th>
                            <th>Mã sản phẩm</th>
                            <th>Size</th>
                            <th>Color</th>
                            <th>Material</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% List<ProductDetail> productList = (List<ProductDetail>) request.getAttribute("productList"); %>
                        <% for (ProductDetail product : productList) { %>
                        <tr>
                            <td><%= product.getProductDetailId() %></td>
                            <td><%= product.getProductId() %></td>
                            <td><%= product.getSize() %></td>
                            <td><%= product.getColor() %></td>
                            <td><%= product.getMaterial() %></td>
                            <td><button onclick="selectProduct('<%= product.getProductDetailId() %>')">Chọn</button></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                function openProductModal() {
                                    document.getElementById("productModal").style.display = "block";
                                }

                                function closeProductModal() {
                                    document.getElementById("productModal").style.display = "none";
                                }

                                function selectProduct(id, name) {
                                    document.getElementById("productDetailId").value = id;
                                    closeProductModal();
                                }
        </script>

    </body>
</html>
