<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thêm Chi Tiết Sản Phẩm</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            .custom-card {
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
                border-radius: 0.5rem;
            }
            .metadata {
                font-size: 0.875rem;
                color: #6c757d;
            }
        </style>
    </head>
    <body class="bg-light">
        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card custom-card">
                        <div class="card-header bg-primary text-white">
                            <h2 class="card-title h4 mb-0">
                                <i class="bi bi-plus-square me-2"></i>Thêm Chi Tiết Sản Phẩm
                            </h2>
                        </div>
                        <div class="card-body">
                            <!-- Error Message Display -->
                            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
                            <% if (errorMessage != null) { %>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                <%= errorMessage %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <% } %>

                            <!-- Product ID Display -->
                            <div class="alert alert-info mb-4">
                                <i class="bi bi-info-circle me-2"></i>
                                Mã sản phẩm: <strong><%= request.getAttribute("productId") %></strong>
                            </div>

                            <form action="productDetails" method="post" class="needs-validation" novalidate>
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="proId" value="<%= request.getAttribute("productId") %>">

                                <div class="mb-3">
                                    <label for="ProductDetailID" class="form-label">Mã chi tiết sản phẩm:</label>
                                    <input type="text" 
                                           class="form-control" 
                                           id="ProductDetailID" 
                                           name="ProductDetailID" 
                                           required>
                                    <div class="invalid-feedback">
                                        Vui lòng nhập mã chi tiết sản phẩm
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="Size" class="form-label">Kích cỡ:</label>
                                    <input type="number" 
                                           class="form-control" 
                                           id="Size" 
                                           name="Size" 
                                           min="0"
                                           required>
                                    <div class="invalid-feedback">
                                        Vui lòng nhập kích cỡ hợp lệ
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="Color" class="form-label">Màu sắc:</label>
                                    <input type="text" 
                                           class="form-control" 
                                           id="Color" 
                                           name="Color" 
                                           required>
                                    <div class="invalid-feedback">
                                        Vui lòng nhập màu sắc
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="ImageURL" class="form-label">URL Hình ảnh:</label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-link"></i>
                                        </span>
                                        <input type="url" 
                                               class="form-control" 
                                               id="ImageURL" 
                                               name="ImageURL" 
                                               placeholder="https://"
                                               required>
                                        <div class="invalid-feedback">
                                            Vui lòng nhập URL hình ảnh hợp lệ
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label for="Material" class="form-label">Chất liệu:</label>
                                    <input type="text" 
                                           class="form-control" 
                                           id="Material" 
                                           name="Material" 
                                           required>
                                    <div class="invalid-feedback">
                                        Vui lòng nhập chất liệu
                                    </div>
                                </div>

                                <div class="d-flex gap-2">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-plus-circle me-2"></i>Thêm chi tiết
                                    </button>
                                    <a href="productDetails?proId=<%= request.getAttribute("productId") %>" 
                                       class="btn btn-secondary">
                                        <i class="bi bi-arrow-left me-2"></i>Quay lại
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Form Validation Script -->
        <script>
            (function () {
                'use strict'
                var forms = document.querySelectorAll('.needs-validation')
                Array.prototype.slice.call(forms)
                    .forEach(function (form) {
                        form.addEventListener('submit', function (event) {
                            if (!form.checkValidity()) {
                                event.preventDefault()
                                event.stopPropagation()
                            }
                            form.classList.add('was-validated')
                        }, false)
                    })
            })()
        </script>
    </body>
</html>