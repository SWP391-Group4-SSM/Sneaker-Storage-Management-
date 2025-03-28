<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Shoes List</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="../shared/header.jsp">
            <jsp:param name="title" value="Shoes Management"/>
        </jsp:include>
        <div class="container mt-4">
            <div class="row mb-4">
                <div class="col">
                    <h2>Shoes List</h2>
                </div>
                <div class="col text-end">
                    <a href="productList?action=add" class="btn btn-primary">Add shoes</a>
                </div>
            </div>
            <form action="${pageContext.request.contextPath}/productList" method="get" class="mb-3">
                <div class="input-group">
                    <input type="text" name="searchName" class="form-control" 
                           placeholder="Search by product name..." value="${searchName}">
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-search"></i> Search
                    </button>
                    <a href="${pageContext.request.contextPath}/productList" class="btn btn-secondary">
                        <i class="bi bi-arrow-clockwise"></i> Reset
                    </a>
                </div>
            </form>

            <div class="table-responsive">
                <table class="table table-striped table-bordered">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Price</th>
                            <th>SKU</th>
                            <th>Created At</th>
                            <th>totalQuantity</th>

                            <th>Details</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="product" items="${products}">
                            <tr>
                                <td>${product.productId}</td>
                                <td>${product.name}</td>
                                <td>${product.description}</td>
                                <td>${product.price}</td>
                                <td>${product.sku}</td>
                                <td>${product.createdAt}</td>
                                <td>${product.totalQuantity}</td>
                                <td>
                                    <a href="productDetails?proId=${product.productId}" class="btn btn-info btn-sm">View Details</a>
                                </td>
                                <td>
                                    <button onclick="confirmDelete(${product.productId})" class="btn btn-danger btn-sm">Delete</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <nav>
                <ul class="pagination justify-content-center">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/productList?page=${currentPage - 1}${not empty searchName ? '&searchName='.concat(searchName) : ''}">
                                Previous
                            </a>
                        </li>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/productList?page=${i}${not empty searchName ? '&searchName='.concat(searchName) : ''}">
                                ${i}
                            </a>
                        </li>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/productList?page=${currentPage + 1}${not empty searchName ? '&searchName='.concat(searchName) : ''}">
                                Next
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>

        <!-- Bootstrap JS and Popper.js -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                        function confirmDelete(id) {
                                            if (confirm("Bạn có chắc muốn xóa đơn hàng này không?")) {
                                                window.location.href = "productList?action=delete&proId=" + id;
                                            }
                                        }
        </script>
    </body>
</html>