<%@ page import="java.util.List, model.PurchaseOrder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Danh sách PO</title>
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
            .status-badge {
                font-size: 0.875rem;
            }
            .table-hover tbody tr:hover {
                background-color: rgba(0,123,255,0.05);
            }
            .action-buttons a {
                text-decoration: none;
            }
            .pagination .page-item.active .page-link {
                background-color: #0d6efd;
                border-color: #0d6efd;
            }
        </style>
    </head>
    <body class="bg-light">
        <div class="container-fluid py-4">
            <!-- Header Section -->
            <div class="row mb-4">
                <div class="col">
                    <div class="card custom-card">
                        <div class="card-body d-flex justify-content-between align-items-center">
                            <div>
                                <h2 class="card-title mb-0">Purchase Orders</h2>
                                <small class="text-muted">
                                    <i class="bi bi-clock me-1"></i>${current_date}
                                    <i class="bi bi-person ms-2 me-1"></i>${current_user}
                                </small>
                            </div>
                            <a href="purchaseOrder?action=add" class="btn btn-primary">
                                <i class="bi bi-plus-circle me-2"></i>Thêm mới
                            </a>
                        </div>
                    </div>
                </div>
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

            <!-- Main Content -->
            <div class="card custom-card">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover" id="poTable">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Supplier</th>
                                    <th>Warehouse</th>
                                    <th>Created By</th>
                                    <th>Order Date</th>
                                    <th>Status</th>
                                    <th>Total Amount</th>
                                    <th>Created At</th>
                                    <th>Updated At</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${empty purchaseOrders}">
                                    <tr>
                                        <td colspan="10" class="text-center">Không có đơn hàng nào!</td>
                                    </tr>
                                </c:if>
                                <c:forEach var="po" items="${purchaseOrders}">
                                    <tr>
                                        <td>${po.purchaseOrderId}</td>
                                        <td>
                                            <c:set var="supplierName" value="Không xác định" />
                                            <c:forEach var="s" items="${suppliers}">
                                                <c:if test="${s.supplierID == po.supplierId}">
                                                    <c:set var="supplierName" value="${s.supplierName}" />
                                                </c:if>
                                            </c:forEach>
                                            ${supplierName}
                                        </td>
                                        <td>
                                            <c:set var="warehouseName" value="Không xác định" />
                                            <c:forEach var="w" items="${warList}">
                                                <c:if test="${w.warehouseID == po.warehouseId}">
                                                    <c:set var="warehouseName" value="${w.name}" />
                                                </c:if>
                                            </c:forEach>
                                            ${warehouseName}
                                        </td>
                                        <td>
                                            <c:set var="userName" value="Không xác định" />
                                            <c:forEach var="u" items="${userList}">
                                                <c:if test="${u.userID == po.createdByUserId}">
                                                    <c:set var="userName" value="${u.username}" />
                                                </c:if>
                                            </c:forEach>
                                            ${userName}
                                        </td>
                                        <td>${po.orderDate}</td>
                                        <td>
                                            <span class="badge rounded-pill 
                                                  ${po.purchaseOrderStatus eq 'Draft' ? 'bg-warning' :
                                                    po.purchaseOrderStatus eq 'Approved' ? 'bg-success' :
                                                    po.purchaseOrderStatus eq 'Ordered' ? 'bg-primary' :
                                                    'bg-info'}">
                                                ${po.purchaseOrderStatus}
                                            </span>
                                        </td>
                                        <td>
                                            <span class="text-end d-block">
                                                ₫${String.format("%,.2f", po.totalAmount)}
                                            </span>
                                        </td>
                                        <td>${po.createdAt}</td>
                                        <td>${po.updatedAt}</td>
                                        <td class="action-buttons">
                                            <div class="btn-group">
                                                <a href="purchaseOrderDetail?poId=${po.purchaseOrderId}" 
                                                   class="btn btn-sm btn-info">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                                
                                                <c:if test="${po.purchaseOrderStatus ne 'Ordered'&& 
              po.purchaseOrderStatus ne 'Goods Received'&& 
              po.purchaseOrderStatus ne 'Partially Received'}">
                                                    <a href="purchaseOrder?action=edit&id=${po.purchaseOrderId}" 
                                                       class="btn btn-sm btn-warning">
                                                        <i class="bi bi-pencil"></i>
                                                    </a>
                                                    <button onclick="confirmDelete(${po.purchaseOrderId})" 
                                                            class="btn btn-sm btn-danger">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <nav aria-label="Page navigation" class="mt-4">
                            <ul class="pagination justify-content-center">
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="purchaseOrder?page=${i}">${i}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </nav>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Delete Confirmation Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Xác nhận xóa</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        Bạn có chắc muốn xóa đơn hàng này không?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Xóa</button>
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
          
                // Delete confirmation handling
                let deleteId = null;
                window.confirmDelete = function(id) {
                    deleteId = id;
                    $('#deleteModal').modal('show');
                }

                $('#confirmDeleteBtn').click(function() {
                    if (deleteId !== null) {
                        window.location.href = "purchaseOrder?action=delete&id=" + deleteId;
                    }
                });
            });
        </script>
    </body>
</html>