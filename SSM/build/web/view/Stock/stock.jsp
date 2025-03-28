<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Stock Management</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="container mt-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2 class="mb-0">Stock List</h2>
                <a href="${pageContext.request.contextPath}/listusers?action=logout" class="btn btn-danger">
                    <i class="bi bi-box-arrow-right"></i> Logout
                </a>
            </div>

            <form action="${pageContext.request.contextPath}/stock" method="get" class="mb-3 d-flex gap-2">
                <input type="text" name="searchProductName" class="form-control" 
                       placeholder="Enter Product Name" value="${searchProductName}">
                <input type="text" name="searchWarehouseName" class="form-control" 
                       placeholder="Enter Warehouse Name" value="${searchWarehouseName}">
                <input type="text" name="searchBinName" class="form-control" 
                       placeholder="Enter Bin Name" value="${searchBinName}">
                <button type="submit" class="btn btn-primary">
                    <i class="bi bi-search"></i> Search
                </button>
                <a href="${pageContext.request.contextPath}/stock" class="btn btn-secondary">
                    <i class="bi bi-arrow-clockwise"></i> Reset
                </a>
            </form>

            <table class="table table-hover table-bordered bg-white">
                <thead class="table-dark">
                    <tr>
                        <th>Stock ID</th>
                        <th>Product Name</th>
                        <th>Size</th>
                        <th>Color</th>
                        <th>Warehouse</th>
                        <th>Bin</th>
                        <th>Quantity</th>
                        <th>Last Updated</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${not empty data}">
                        <c:forEach var="stock" items="${data}">
                            <tr>
                                <td>${stock.stockID}</td>
                                <td>${stock.productName}</td>
                                <td>${stock.productSize}</td>
                                <td>${stock.productColor}</td>
                                <td>${stock.warehouseName}</td>
                                <td>${stock.binName}</td>
                                <td>${stock.quantity}</td>
                                <td>${stock.lastUpdated}</td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/editstock?stockID=${stock.stockID}" 
                                       class="btn btn-warning btn-sm">
                                        <i class="bi bi-pencil"></i> Edit
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty data}">
                        <tr>
                            <td colspan="9" class="text-center">No stocks available</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>

            <nav>
                <ul class="pagination justify-content-center">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/stock?page=${currentPage - 1}${not empty searchProductName ? '&searchProductName='.concat(searchProductName) : ''}${not empty searchWarehouseName ? '&searchWarehouseName='.concat(searchWarehouseName) : ''}${not empty searchBinName ? '&searchBinName='.concat(searchBinName) : ''}">Previous</a>
                        </li>
                    </c:if>
                    <li class="page-item active">
                        <span class="page-link">${currentPage}</span>
                    </li>
                    <c:if test="${data.size() == 10}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/stock?page=${currentPage + 1}${not empty searchProductName ? '&searchProductName='.concat(searchProductName) : ''}${not empty searchWarehouseName ? '&searchWarehouseName='.concat(searchWarehouseName) : ''}${not empty searchBinName ? '&searchBinName='.concat(searchBinName) : ''}">Next</a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>
    </body>
</html>