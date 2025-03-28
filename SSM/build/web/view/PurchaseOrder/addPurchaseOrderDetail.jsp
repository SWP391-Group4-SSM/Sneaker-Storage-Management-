<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.PurchaseOrderDetail" %>
<%@ page import="model.Supplier" %>
<%@ page import="model.Warehouse" %>
<%@ page import="model.ProductDetail" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thêm Chi Tiết Đơn Hàng Mua</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
        <!-- DataTables CSS -->
        <link href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" rel="stylesheet">
        
        <style>
            .custom-card {
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
                border-radius: 0.5rem;
            }
            .modal-dialog {
                max-width: 80%;
            }
            .selected-product {
                background-color: rgba(25, 135, 84, 0.1);
                border-radius: 0.25rem;
                padding: 0.5rem;
                margin-top: 0.25rem;
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
                                <i class="bi bi-plus-circle me-2"></i>Thêm Chi Tiết Đơn Hàng
                            </h2>
                            <span class="badge bg-light text-dark">
                                Mã ĐH: ${requestScope.purchaseOrderId}
                            </span>
                        </div>
                        
                            <!-- Error Message -->
                            <c:if test="${not empty sessionScope.errorMessage}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                    ${sessionScope.errorMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                                <c:remove var="errorMessage" scope="session"/>
                            </c:if>

                            <form action="purchaseOrderDetail" method="post" class="needs-validation" novalidate>
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="poId" value="${requestScope.purchaseOrderId}">
                                
                                <div class="mb-3">
                                    <label for="purchaseOrderDetailID" class="form-label">
                                        <i class="bi bi-hash me-2"></i>Mã Pod:
                                    </label>
                                    <input type="text" 
                                           class="form-control" 
                                           id="purchaseOrderDetailID" 
                                           name="purchaseOrderDetailID" 
                                           required>
                                    <div class="invalid-feedback">
                                        Vui lòng nhập mã Pod
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">
                                        <i class="bi bi-box me-2"></i>Sản phẩm:
                                    </label>
                                    <input type="hidden" id="productDetailId" name="productDetailId">
                                    <div class="d-grid">
                                        <button type="button" 
                                                class="btn btn-outline-primary" 
                                                data-bs-toggle="modal" 
                                                data-bs-target="#productModal">
                                            <i class="bi bi-search me-2"></i>Chọn sản phẩm
                                        </button>
                                    </div>
                                    <div id="selectedProduct" class="selected-product d-none">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <small class="text-muted">Sản phẩm đã chọn:</small>
                                                <div id="productInfo"></div>
                                            </div>
                                            <button type="button" 
                                                    class="btn btn-sm btn-outline-danger" 
                                                    onclick="clearProduct()">
                                                <i class="bi bi-x-lg"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="quantityOrdered" class="form-label">
                                        <i class="bi bi-123 me-2"></i>Số lượng:
                                    </label>
                                    <input type="number" 
                                           class="form-control" 
                                           id="quantityOrdered" 
                                           name="quantityOrdered" 
                                           min="1"
                                           required>
                                    <div class="invalid-feedback">
                                        Vui lòng nhập số lượng hợp lệ
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label for="unitPrice" class="form-label">
                                        <i class="bi bi-tag me-2"></i>Giá mỗi đơn vị:
                                    </label>
                                    <div class="input-group">
                                        <input type="number" 
                                               class="form-control" 
                                               id="unitPrice" 
                                               name="unitPrice" 
                                               required>
                                        <div class="invalid-feedback">
                                            Vui lòng nhập giá hợp lệ
                                        </div>
                                    </div>
                                </div>

                                <div class="d-flex gap-2">
                                    <button type="submit" class="btn btn-primary flex-grow-1">
                                        <i class="bi bi-plus-circle me-2"></i>Thêm
                                    </button>
                                    <a href="purchaseOrderDetail?poId=${requestScope.purchaseOrderId}" 
                                       class="btn btn-secondary flex-grow-1">
                                        <i class="bi bi-x-circle me-2"></i>Hủy
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Product Selection Modal -->
        <div class="modal fade" id="productModal" tabindex="-1">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            <i class="bi bi-box-seam me-2"></i>Chọn sản phẩm
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <table id="productTable" class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Mã chi tiết</th>
                                    <th>Mã sản phẩm</th>
                                    <th>Size</th>
                                    <th>Color</th>
                                    <th>Material</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${productList}" var="product">
                                    <tr>
                                        <td>${product.productDetailId}</td>
                                        <td>
                                            <c:set var="productName" value="Không xác định" />
                                            <c:forEach var="p" items="${proList}">
                                                <c:if test="${p.productId == product.productId}">
                                                    <c:set var="productName" value="${p.name}" />
                                                </c:if>
                                            </c:forEach>
                                            ${productName}
                                        </td>
                                        <td><span class="badge bg-info">${product.size}</span></td>
                                        <td><span class="badge bg-secondary">${product.color}</span></td>
                                        <td>${product.material}</td>
                                        <td>
                                            <button type="button" 
                                                    class="btn btn-sm btn-success" 
                                                    onclick="selectProduct('${product.productDetailId}', 
                                                                         '${product.productId}', 
                                                                         '${product.size}', 
                                                                         '${product.color}')">
                                                <i class="bi bi-check-lg"></i> Chọn
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
        
        <script>
            $(document).ready(function() {
                // Initialize DataTable
                $('#productTable').DataTable({
                    "language": {
                        "search": "Tìm kiếm:",
                        "paginate": {
                            "next": "→",
                            "previous": "←"
                        },
                        "zeroRecords": "Không tìm thấy kết quả",
                        "info": "",
                        "infoEmpty": "",
                        "infoFiltered": ""
                    }
                });
            });

            // Form validation
            (function() {
                'use strict';
                var forms = document.querySelectorAll('.needs-validation');
                Array.prototype.slice.call(forms).forEach(function(form) {
                    form.addEventListener('submit', function(event) {
                        if (!form.checkValidity()) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            })();

            // Product selection
            function selectProduct(id, productId, size, color) {
                document.getElementById('productDetailId').value = id;
                document.getElementById('productInfo').innerHTML = `
                    <div>
                        <strong>Mã chi tiết:</strong> ${id}<br>
                        <strong>Mã sản phẩm:</strong> ${productId}<br>
                        <strong>Size:</strong> <span class="badge bg-info">${size}</span>
                        <strong>Màu:</strong> <span class="badge bg-secondary">${color}</span>
                    </div>
                `;
                document.getElementById('selectedProduct').classList.remove('d-none');
                $('#productModal').modal('hide');
            }

            function clearProduct() {
                document.getElementById('productDetailId').value = '';
                document.getElementById('productInfo').innerHTML = '';
                document.getElementById('selectedProduct').classList.add('d-none');
            }
        </script>
    </body>
</html>