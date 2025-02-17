<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Products List</title>
        <link rel="stylesheet" type="text/css" href="CSS/products.css">
    </head>
    <body>
        <h1>Products List</h1>
        <a href="addProduct.jsp">Add New Product</a>

        <form action="productList" method="get">
            <input type="hidden" name="action" value="search">
            <input type="text" name="keyword" placeholder="Search by name">
            <button type="submit">Search</button>
        </form>

        <form action=productList method="get">
            <input type="hidden" name="action" value="filter">
            <input type="number" name="minPrice" placeholder="Min Price" required>
            <input type="number" name="maxPrice" placeholder="Max Price" required>
            <button type="submit">Filter</button>
        </form>

        <form action="productList" method="get">
            <input type="hidden" name="action" value="sort">
            <select name="order">
                <option value="asc">Price: Low to High</option>
                <option value="desc">Price: High to Low</option>
            </select>
            <button type="submit">Sort</button>
        </form>

        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>SKU</th>
                <th>Price</th>
                <th>Image</th>
                <th>Action</th>
                <th>Detail</th>
            </tr>
            <c:forEach var="product" items="${products}">
                <tr>
                    <td>${product.productID}</td>
                    <td>${product.name}</td>
                    <td>${product.sku}</td>
                    <td>${product.price}</td>
                    <td>
                        <img src="${product.imageURL}" alt="${product.name}" width="100">
                    </td>
                    <td>
                        <a href="productList?action=edit&id=${product.productID}">Edit</a> |
                        <a href="productList?action=delete&id=${product.productID}" onclick="return confirm('Are you sure?');">Delete</a>
                    </td>
                    <td>
                        <a href="productDetails?id=${product.productID}">View Details</a>
                    </td>
                </tr>
            </c:forEach>
        </table>

        <!-- Phân trang -->
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="productList?page=1">First</a>
                <a href="productList?page=${currentPage - 1}">Previous</a>
            </c:if>

            <c:forEach begin="1" end="${totalPages}" var="i">
                <a href="productList?page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="productList?page=${currentPage + 1}">Next</a>
                <a href="productList?page=${totalPages}">Last</a>
            </c:if>
        </div>
        <div class="form-container">
            <h3>Add / Edit Product</h3>
            <form action="productList" method="post">
                <input type="hidden" name="id" value="">
                Name: <input type="text" name="name" required> <br>
                Price: <input type="number" name="price" step="0.01" required> <br>
                Description: <input type="text" name="description"> <br>
                Sku: <input type="text" name="sku"> <br>
                imageURL: <input type="text" name="imageURL"> <br>
                <button type="submit" name="action" value="add">Add Product</button>
            </form>
        </div>

    </body>
</html>
