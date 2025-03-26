<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Cập nhật Đơn hàng</title>
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
            .status-badge {
                font-size: 0.875rem;
                padding: 0.5rem 0.75rem;
            }
            .metadata {
                font-size: 0.875rem;
            }
        </style>
    </head>
    <body class="bg-light">
        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card custom-card">
                        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                            <h2 class="card-title h4 mb-0">
                                <i class="bi bi-pencil-square me-2"></i>Cập nhật Đơn hàng
                            </h2>
                            <span class="status-badge badge bg-light text-dark">
                                ID: ${purchaseOrder.purchaseOrderId}
                            </span>
                        </div>
                        
                        <div class="card-body">
                            <!-- Metadata Information -->
                            <div class="alert alert-info mb-4">
                                <div class="row">
                                    <div class="col-md-6">
                                        <i class="bi bi-person-circle me-2"></i>
                                        Người cập nhật: ducws17
                                    </div>
                                    <div class="col-md-6 text-md-end">
                                        <i class="bi bi-clock me-2"></i>
                                        Thời gian: 2025-03-26 14:55:36
                                    </div>
                                </div>
                            </div>

                            <form action="purchaseOrder" method="post" class="needs-validation" novalidate>
                                <input type="hidden" name="action" value="edit">
                                <input type="hidden" name="id" value="${purchaseOrder.purchaseOrderId}">

                                <div class="mb-3">
                                    <label for="supplierId" class="form-label">
                                        <i class="bi bi-building me-2"></i>Mã nhà cung cấp:
                                    </label>
                                    <input type="number" 
                                           class="form-control" 
                                           id="supplierId" 
                                           name="supplierId" 
                                           value="${purchaseOrder.supplierId}" 
                                           required>
                                    <div class="invalid-feedback">
                                        Vui lòng nhập mã nhà cung cấp
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="warehouseId" class="form-label">
                                        <i class="bi bi-house-door me-2"></i>Mã kho:
                                    </label>
                                    <input type="number" 
                                           class="form-control" 
                                           id="warehouseId" 
                                           name="warehouseId" 
                                           value="${purchaseOrder.warehouseId}" 
                                           required>
                                    <div class="invalid-feedback">
                                        Vui lòng nhập mã kho
                                    </div>
                                </div>

                                <div class="d-flex gap-2">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-check-circle me-2"></i>Cập nhật đơn hàng
                                    </button>
                                    <a href="purchaseOrder" class="btn btn-secondary">
                                        <i class="bi bi-arrow-left me-2"></i>Quay lại danh sách
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