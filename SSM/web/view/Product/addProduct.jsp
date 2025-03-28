<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Add shoes</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            .form-label {
                font-weight: 500;
            }
            .custom-card {
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
                border-radius: 0.5rem;
            }
        </style>
    </head>
    <body class="bg-light">
        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card custom-card">
                        <div class="card-header bg-primary text-white">
                            <h2 class="card-title mb-0">
                                <i class="bi bi-plus-circle me-2"></i>Add shoes
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

                            <!-- Add Product Form -->
                            <form action="productList" method="post" class="needs-validation" novalidate>
                                <input type="hidden" name="action" value="add">
                                
                                <div class="mb-3">
                                    <label for="productId" class="form-label">Shoes ID:</label>
                                    <input type="number" 
                                           class="form-control" 
                                           id="productId" 
                                           name="productId" 
                                           required>
                                    <div class="invalid-feedback">
                                        Vui lòng nhập mã sản phẩm
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="name" class="form-label">Name:</label>
                                    <input type="text" 
                                           class="form-control" 
                                           id="name" 
                                           name="name" 
                                           required>
                                    <div class="invalid-feedback">
                                        Vui lòng nhập tên sản phẩm
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="description" class="form-label">Description:</label>
                                    <textarea class="form-control" 
                                              id="description" 
                                              name="description" 
                                              rows="3" 
                                              required></textarea>
                                    <div class="invalid-feedback">
                                        Vui lòng nhập mô tả sản phẩm
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="sku" class="form-label">SKU:</label>
                                    <input type="text" 
                                           class="form-control" 
                                           id="sku" 
                                           name="sku" 
                                           required>
                                    <div class="invalid-feedback">
                                        Vui lòng nhập mã SKU
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label for="price" class="form-label">Price:</label>
                                    <div class="input-group">
                                        <input type="number" 
                                               class="form-control" 
                                               id="price" 
                                               name="price" 
                                               step="0.01" 
                                               required>
                                        <div class="invalid-feedback">
                                            Vui lòng nhập giá sản phẩm
                                        </div>
                                    </div>
                                </div>

                                <div class="d-flex gap-2">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-plus-circle me-2"></i>Add shoes
                                    </button>
                                    <a href="productList" class="btn btn-secondary">
                                        <i class="bi bi-arrow-left me-2"></i>Back
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
            // Enable Bootstrap form validation
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