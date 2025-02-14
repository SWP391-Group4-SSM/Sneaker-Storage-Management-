<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Products List</title>
    <link rel="stylesheet" type="text/css" href="css/products.css">
</head>
<body>
    <h1>Products List</h1>

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
                    <a href="editProduct.jsp?id=${product.productID}">Edit</a> | 
                    <a href="ProductServlet?action=delete&id=${product.productID}" onclick="return confirm('Are you sure?');">Delete</a>
                </td>
                <td>
                    <a href="productDetails?id=${product.productID}">View Details</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
