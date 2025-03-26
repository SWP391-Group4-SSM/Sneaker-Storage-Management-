<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Update Purchase Order Detail</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            .custom-card {
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
                border-radius: 0.5rem;
            }
            .form-label {
                font-weight: 500;
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
                <div class="col-lg-6">
                    <div class="card custom-card">
                        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                            <h2 class="card-title h4 mb-0">
                                <i class="bi bi-pencil-square me-2"></i>Update Purchase Order Detail
                            </h2>
                            <span class="badge bg-light text-dark">
                                PO ID: <%= request.getAttribute("purchaseOrderId") %>
                            </span>
                        </div>
                        

                            <!-- Error Message Display -->
                            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
                            <% if (errorMessage != null) { %>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                <%= errorMessage %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <% } %>

                            <form action="purchaseOrderDetail" method="post" class="needs-validation" novalidate>
                                <input type="hidden" name="action" value="edit">
                                <input type="hidden" name="poId" value="<%= request.getAttribute("purchaseOrderId") %>">

                                <div class="mb-3">
                                    <label for="purchaseOrderDetailId" class="form-label">
                                        <i class="bi bi-hash me-2"></i>Purchase Order Detail ID:
                                    </label>
                                    <input type="number" 
                                           class="form-control" 
                                           id="purchaseOrderDetailId" 
                                           name="purchaseOrderDetailId" 
                                           value="${purchaseOrderDetail.purchaseOrderDetailId}"
                                           readonly>
                                    <div class="form-text text-muted">
                                        This field cannot be modified
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="quantityOrdered" class="form-label">
                                        <i class="bi bi-box me-2"></i>Quantity:
                                    </label>
                                    <input type="number" 
                                           class="form-control" 
                                           id="quantityOrdered" 
                                           name="quantityOrdered" 
                                           value="${purchaseOrderDetail.quantityOrdered}"
                                           min="1"
                                           required>
                                    <div class="invalid-feedback">
                                        Please enter a valid quantity (minimum 1)
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label for="unitPrice" class="form-label">
                                        <i class="bi bi-tag me-2"></i>Unit Price:
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">₫</span>
                                        <input type="number" 
                                               class="form-control" 
                                               id="unitPrice" 
                                               name="unitPrice" 
                                               step="0.01" 
                                               value="${purchaseOrderDetail.unitPrice}"
                                               min="0"
                                               required>
                                        <div class="invalid-feedback">
                                            Please enter a valid unit price
                                        </div>
                                    </div>
                                </div>

                                <div class="d-flex gap-2">
                                    <button type="submit" class="btn btn-primary flex-grow-1">
                                        <i class="bi bi-check-circle me-2"></i>Update
                                    </button>
                                    <a href="purchaseOrderDetail?poId=<%= request.getAttribute("purchaseOrderId") %>" 
                                       class="btn btn-secondary flex-grow-1">
                                        <i class="bi bi-x-circle me-2"></i>Cancel
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