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
            <th>Updated At</th>
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
                <td>${product.updatedAt}</td>
                <td><a href="productDetails?proId=${product.productId}">View Details</a></td>
                <td>
                    <a href="javascript:void(0);" onclick="confirmDelete(${product.productId})">Xóa</a>
                </td>
            </tr>
        </c:forEach>
    </table>
    <script>
            function confirmDelete(id) {
                if (confirm("Bạn có chắc muốn xóa đơn hàng này không?")) {
                    window.location.href = "productList?action=delete&proId=" +id ;
                }
            }
        </script>
</body>
</html>
