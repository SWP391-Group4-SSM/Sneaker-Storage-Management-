<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Details</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom CSS for image hover effect -->
        <style>
            .product-image {
                transition: transform 0.3s ease;
                cursor: pointer;
            }
            .product-image:hover {
                transform: scale(1.1);
            }
        </style>
    </head>
    <body>
        <div class="container mt-4">
            <div class="row mb-4">
                <div class="col">
                    <h2>Product Detail</h2>
                </div>
                <div class="col text-end">
                    <a href="productDetails?action=add&proId=<%= request.getAttribute("productId") %>" 
                       class="btn btn-primary mb-3">
                        <i class="bi bi-plus-circle"></i> Thêm mới
                    </a>
                </div>
            </div>

            <c:choose>
                <c:when test="${empty prdList}">
                    <div class="alert alert-info" role="alert">
                        Không có sản phẩm nào.
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>ProductId</th>
                                    <th>Size</th>
                                    <th>Color</th>
                                    <th>Image</th>
                                    <th>Material</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="prd" items="${prdList}">
                                    <tr>
                                        <td>${prd.productDetailId}</td>
                                        <td>${prd.productId}</td>
                                        <td>${prd.size}</td>
                                        <td>
                                            <span class="badge bg-primary">${prd.color}</span>
                                        </td>
                                        <td>
                                            <img src="${prd.imageUrl}" 
                                                 alt="Product Image" 
                                                 class="img-thumbnail product-image" 
                                                 width="100" 
                                                 height="100"
                                                 data-bs-toggle="modal" 
                                                 data-bs-target="#imageModal${prd.productDetailId}">
                                        </td>
                                        <td>${prd.material}</td>
                                        <td>
                                            <button onclick="confirmDelete(<%= request.getAttribute("productId") %>, ${prd.productDetailId})" 
                                                    class="btn btn-danger btn-sm">
                                                <i class="bi bi-trash"></i> Xóa
                                            </button>
                                        </td>
                                    </tr>

                                    <!-- Image Modal for each product -->
                                    <div class="modal fade" id="imageModal${prd.productDetailId}" tabindex="-1">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Product Image</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                </div>
                                                <div class="modal-body text-center">
                                                    <img src="${prd.imageUrl}" 
                                                         alt="Product Image" 
                                                         class="img-fluid">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>

            <div class="mt-4">
                <a href="productList" class="btn btn-secondary">
                    <i class="bi bi-arrow-left"></i> Quay lại danh sách
                </a>
            </div>
        </div>

        <!-- Bootstrap JS and Popper.js -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
        
        <script>
            function confirmDelete(proId, id) {
                if (confirm("Bạn có chắc muốn xóa đơn hàng này không?")) {
                    window.location.href = "productDetails?action=delete&proId=" + proId + "&id=" + id;
                }
            }
        </script>
    </body>
</html>