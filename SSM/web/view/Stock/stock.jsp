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
            <h2 class="mb-3">Stock List</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Stock ID</th>
                        <th>Product</th>
                        <th>Size</th>
                        <th>Color</th>
                        <th>Warehouse</th>
                        <th>Bin </th>
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
            <div style="text-align: center; margin-top: 20px;">
                <c:if test="${totalPages > 1}">
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <a href="stock?page=${i}" 
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
        </div>
    </body>
</html>
