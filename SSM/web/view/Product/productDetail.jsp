<%-- 
    Document   : productDetail
    Created on : Mar 14, 2025, 8:58:23 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Product Detail</h2>
        <a href="productDetails?action=add&proId=<%= request.getAttribute("productId") %>">Thêm mới</a>
        <c:choose>
            <c:when test="${empty prdList}">
                <p>Không có sản phẩm nào.</p>
            </c:when>
            <c:otherwise>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>ProductId</th>
                        <th>Size</th>
                        <th>Color</th>
                        <th>Image</th>
                        <th>Material</th>
                        <th>Actions</th>
                    </tr>
                    <c:forEach var="prd" items="${prdList}">
                        <tr>
                            <td>${prd.productDetailId}</td>
                            <td>${prd.productId}</td>
                            <td>${prd.size}</td>
                            <td>${prd.color}</td>
                            <td>
                                <img src="${prd.imageUrl}" alt="Product Image" width="100" height="100">
                            </td>
                            <td>${prd.material}</td>
                          
                            <td>
                                <a href="javascript:void(0);" onclick="confirmDelete(<%= request.getAttribute("productId") %>,${prd.productDetailId})">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
                <script>
            function confirmDelete(proId,id) {
                if (confirm("Bạn có chắc muốn xóa đơn hàng này không?")) {
                    window.location.href = "productDetails?action=delete&proId=" + proId + "&id=" + id;
                }
            }
        </script>
            </c:otherwise>
        </c:choose>
        <a href="productList" class="btn-back">Quay lại danh sách</a>
    </body>
</html>
