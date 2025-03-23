<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Product List</title>
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
                font-size: 18px;
                text-align: left;
            }
            th, td {
                padding: 12px;
                border: 1px solid #ddd;
            }
            th {
                background-color: #f4f4f4;
            }
            a {
                text-decoration: none;
                color: #007bff;
            }
            a:hover {
                color: #0056b3;
            }
        </style>
    </head>
    <body>
        <h2>Product List</h2>
        <a href="productList?action=add">Thêm mới</a>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Description</th>
                <th>Price</th>
                <th>SKU</th>
                <th>Created At</th>
                <th>Details</th>

            </tr>
            <c:forEach var="product" items="${productList}">
                <tr>
                    <td>${product.productId}</td>
                    <td>${product.name}</td>
                    <td>${product.description}</td>
                    <td>${product.price}</td>
                    <td>${product.sku}</td>
                    <td>${product.createdAt}</td>
                    <td><a href="productDetails?proId=${product.productId}">View Details</a></td>
                    <td>
                        <a href="javascript:void(0);" onclick="confirmDelete(${product.productId})">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <!-- Phân trang -->
        <div style="text-align: center; margin-top: 20px;">
            <c:if test="${totalPages > 1}">
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <a href="productList?page=${i}" 
                       style="padding: 8px 12px; margin: 0 5px;
                       text-decoration: none; border: 1px solid #007bff;
                       color: ${i == currentPage ? 'white' : '#007bff'};
                       background-color: ${i == currentPage ? '#007bff' : 'white'};
                       border-radius: 4px;">
                        ${i}
                    </a>
                </c:forEach>
            </c:if>
        </div>

        <script>
            function confirmDelete(id) {
                if (confirm("Bạn có chắc muốn xóa đơn hàng này không?")) {
                    window.location.href = "productList?action=delete&proId=" + id;
                }
            }
        </script>
    </body>
</html>
