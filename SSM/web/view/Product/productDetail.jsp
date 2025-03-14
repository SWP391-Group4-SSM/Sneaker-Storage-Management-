<%-- 
    Document   : productDetail
    Created on : Mar 14, 2025, 8:58:23 PM
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
        <h2>Product List</h2>
    <a href="productList?action=add">Thêm mới</a>
    <table>
        <tr>
            <th>ID</th>
            <th>ProductId</th>
            <th>size</th>
            <th>Color</th>
            <th>Image</th>
            <th>Material</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="prd" items="${prdList}">
            <tr>
     
                <td>${prd.productDetailId}</td>
                <td>${prd.productId}</td>
                <td>${prd.size}</td>
                <td>${prd.color}</td>
                <td>${prd.status}</td>
                <td>${prd.material}</td>
                <td><a href="productDetails?proId=${product.productId}">View Details</a></td>
            </tr>
        </c:forEach>
    </table>
    </body>
</html>
