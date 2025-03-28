<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.PurchaseOrderDetail" %>
<%@ page import="model.Supplier" %>
<%@ page import="model.Warehouse" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Thêm Đơn Hàng Mua</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Select2 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/select2-bootstrap-5-theme@1.3.0/dist/select2-bootstrap-5-theme.min.css" rel="stylesheet">
        
        <style>
            .custom-card {
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
                border-radius: 0.5rem;
            }
            .form-label {
                font-weight: 500;
            }
            .select2-container {
                width: 100% !important;
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
                                <i class="bi bi-cart-plus me-2"></i>Thêm Đơn Hàng Mua
                            </h2>
                        </div>
                        <div class="card-body">
                            <!-- Metadata Information -->
                            <div class="alert alert-info mb-4">
                                <div class="row">
                                    <div class="col-md-6">
                                        <i class="bi bi-person-circle me-2"></i>
                                        Người tạo: <%= "ducws17" %>
                                    </div>
                                    <div class="col-md-6 text-md-end">
                                        <i class="bi bi-clock me-2"></i>
                                        Ngày tạo: <%= "2025-03-26 14:51:48" %>
                                    </div>
                                </div>
                            </div>

                            <!-- Error Message Display -->
                            <%
                                String errorMessage = (String) session.getAttribute("errorMessage");
                                if (errorMessage != null) {
                            %>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                <%= errorMessage %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <%
                                session.removeAttribute("errorMessage");
                                }
                            %>

                            <form action="purchaseOrder" method="post" class="needs-validation" novalidate>
                                <input type="hidden" name="action" value="add">

                                <div class="mb-3">
                                    <label for="purchaseOrderId" class="form-label">
                                        <i class="bi bi-hash me-1"></i>Mã Đơn Hàng:
                                    </label>
                                    <input type="number" 
                                           class="form-control" 
                                           id="purchaseOrderId" 
                                           name="purchaseOrderId" 
                                           required>
                                    <div class="invalid-feedback">
                                        Vui lòng nhập mã đơn hàng
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="supplierId" class="form-label">
                                        <i class="bi bi-building me-1"></i>Nhà cung cấp:
                                    </label>
                                    <select class="form-select select2" 
                                            id="supplierId" 
                                            name="supplierId" 
                                            required>
                                        <option value="">-- Chọn nhà cung cấp --</option>
                                        <% 
                                            List<Supplier> suppliers = (List<Supplier>) request.getAttribute("suppliers");
                                            if (suppliers != null) {
                                                for (Supplier supplier : suppliers) { 
                                        %>
                                        <option value="<%= supplier.getSupplierID() %>">
                                            <%= supplier.getSupplierName() %>
                                        </option>
                                        <% 
                                                }
                                            } 
                                        %>
                                    </select>
                                    <div class="invalid-feedback">
                                        Vui lòng chọn nhà cung cấp
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="warehouseId" class="form-label">
                                        <i class="bi bi-house-door me-1"></i>Nhà kho:
                                    </label>
                                    <select class="form-select select2" 
                                            id="warehouseId" 
                                            name="warehouseId" 
                                            required>
                                        <option value="">-- Chọn nhà kho --</option>
                                        <% 
                                            List<Warehouse> warehouses = (List<Warehouse>) request.getAttribute("warehouses");
                                            if (warehouses != null) {
                                                for (Warehouse warehouse : warehouses) { 
                                        %>
                                        <option value="<%= warehouse.getWarehouseID() %>">
                                            <%= warehouse.getName() %>
                                        </option>
                                        <% 
                                                }
                                            } 
                                        %>
                                    </select>
                                    <div class="invalid-feedback">
                                        Vui lòng chọn nhà kho
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label for="orderDate" class="form-label">
                                        <i class="bi bi-calendar-event me-1"></i>Ngày đặt hàng:
                                    </label>
                                    <input type="datetime-local" 
                                           class="form-control" 
                                           id="orderDate" 
                                           name="orderDate" 
                                           required>
                                    <div class="invalid-feedback">
                                        Vui lòng chọn ngày đặt hàng
                                    </div>
                                </div>

                                <div class="d-flex gap-2">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-plus-circle me-2"></i>Thêm đơn hàng
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

        <!-- JavaScript Dependencies -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

        <script>
            // Initialize Select2
            $(document).ready(function() {
                $('.select2').select2({
                    theme: 'bootstrap-5',
                    width: 'resolve'
                });
            });

            // Form Validation
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