<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Stock List</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2 class="mb-3 text-center">Stock List</h2>
        
        <!-- Search Form -->
        <form method="GET" action="stock" class="row g-3 mb-4">
            <input type="hidden" name="page" value="${currentPage}" />
            <div class="col-md-6">
                <input type="text" name="search" value="${searchKeyword}" class="form-control" placeholder="Tìm kiếm sản phẩm...">
            </div>
            <div class="col-md-4">
                <select name="warehouse" class="form-select">
                    <option value="">Select warehouse</option>
                    <c:forEach var="w" items="${warehouses}">
                        <option value="${w.warehouseID}" ${w.warehouseID == warehouseFilter ? 'selected' : ''}>${w.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary w-100">Search</button>
            </div>
        </form>

        <!-- Stock Table -->
        <table class="table table-striped table-bordered text-center">
            <thead class="table-dark">
                <tr>
                    <th>Stock ID</th>
                    <th>Product</th>
                    <th>Size</th>
                    <th>Color</th>
                    <th>Warehouse</th>
                    <th>Bin</th>
                    <th>Quantity</th>
                    <th>Last Updated</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="stock" items="${stocks}">
                        <tr>
                            <td>${stock.stockID}</td>
                            <td>
                                <c:set var="productName" value="Không xác định" />
                                <c:forEach var="pd" items="${productDetails}">
                                    <c:if test="${pd.productDetailId ==stock.productDetailID}">
                                        <c:forEach var="pr" items="${products}">
                                            <c:if test="${pr.productId == pd.productId}">
                                                <c:set var="productName" value="${pr.name}" />
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                                ${productName}
                            </td>
                            <td>
                                <c:set var="Size" value="Không xác định" />
                                <c:forEach var="pd" items="${productDetails}">
                                    <c:if test="${pd.productDetailId ==stock.productDetailID}">
                                        <c:set var="Size" value="${pd.size}" />
                                    </c:if>
                                </c:forEach>
                                ${Size}
                            </td>
                            <td>
                                <c:set var="color" value="Không xác định" />
                                <c:forEach var="pd" items="${productDetails}">
                                    <c:if test="${pd.productDetailId ==stock.productDetailID}">
                                        <c:set var="color" value="${pd.color}" />
                                    </c:if>
                                </c:forEach>
                                ${color}
                            </td>
                            <td>
                                <c:set var="warehouseName" value="Không xác định" />
                                <c:forEach var="w" items="${warehouses}">
                                    <c:if test="${w.warehouseID == stock.warehouseID}">
                                        <c:set var="warehouseName" value="${w.name}" />
                                    </c:if>
                                </c:forEach>
                                ${warehouseName}
                            </td>
                            <td>
                                <c:set var="BinName" value="Không xác định" />
                                <c:forEach var="b" items="${bins}">
                                    <c:if test="${b.binID == stock.binID}">
                                        <c:set var="BinName" value="${b.binName}" />
                                    </c:if>
                                </c:forEach>
                                ${BinName}
                            </td>
                            <td>${stock.quantity}</td>
                            <td>${stock.lastUpdated}</td>
                        </tr>
                    </c:forEach>
            </tbody>
        </table>

        <!-- Pagination -->
        <nav>
            <ul class="pagination justify-content-center">
                <c:if test="${totalPages > 1}">
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="stock?page=${i}&search=${searchKeyword}&warehouse=${warehouseFilter}">${i}</a>
                        </li>
                    </c:forEach>
                </c:if>
            </ul>
        </nav>
    </div>
</body>
</html>