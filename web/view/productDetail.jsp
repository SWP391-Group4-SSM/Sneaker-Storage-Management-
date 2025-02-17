<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Product Details</title>
    <link rel="stylesheet" type="text/css" href="CSS/productDetail.css">
</head>
<body>
    <div class="details-container">
        <h1>Product Details</h1>
        <p><strong>ID:</strong> ${product.productID}</p>
        <p><strong>Name:</strong> ${product.name}</p>
        <p><strong>SKU:</strong> ${product.sku}</p>
        <p><strong>Description:</strong> ${product.description}</p>
        <p><strong>Price:</strong> ${product.price}</p>
        <p><a class="back-link" href="productList">Back to Products</a></p>
    </div>
</body>
</html>
