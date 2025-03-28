<%@ page import="java.util.List, model.PurchaseOrder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Purchase Order List</title>
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

                    <div class="card-body d-flex justify-content-between align-items-center">

                        <a href="purchaseOrder?action=add" class="btn btn-primary">
                            <i class="bi bi-plus-circle me-2"></i>Add
                        </a>
                    </div>

                </div>
            </div>
            <div>
                <h1>PurchaseOrder List</h1>
                
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
            <form action="${pageContext.request.contextPath}/purchaseOrder" method="get" class="mb-3 d-flex gap-2">
                <input type="text" name="searchSupplierName" class="form-control" 
                       placeholder="Enter Supplier Name" value="${searchSupplierName}">
                <input type="text" name="searchWarehouseName" class="form-control" 
                       placeholder="Enter Warehouse Name" value="${searchWarehouseName}">
                <button type="submit" class="btn btn-primary">
                    <i class="bi bi-search"></i> Search
                </button>
                <a href="${pageContext.request.contextPath}/purchaseorder" class="btn btn-secondary">
                    <i class="bi bi-arrow-clockwise"></i> Reset
                </a>
            </form>

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
                                        <td>${po.supplierName}</td>
                                        <td>${po.warehouseName}</td>
                                        <td>${po.createdByName}</td>
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

                        <nav>
                            <ul class="pagination justify-content-center">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/purchaseOrder?page=${currentPage - 1}${not empty searchSupplierName ? '&searchSupplierName='.concat(searchSupplierName) : ''}${not empty searchWarehouseName ? '&searchWarehouseName='.concat(searchWarehouseName) : ''}">Previous</a>
                                    </li>
                                </c:if>

                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/purchaseOrder?page=${i}${not empty searchSupplierName ? '&searchSupplierName='.concat(searchSupplierName) : ''}${not empty searchWarehouseName ? '&searchWarehouseName='.concat(searchWarehouseName) : ''}">${i}</a>
                                    </li>
                                </c:forEach>

                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/purchaseOrder?page=${currentPage + 1}${not empty searchSupplierName ? '&searchSupplierName='.concat(searchSupplierName) : ''}${not empty searchWarehouseName ? '&searchWarehouseName='.concat(searchWarehouseName) : ''}">Next</a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>

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
                                                              window.confirmDelete = function (id) {
                                                                  window.location.href = "purchaseOrder?action=delete&id=" + id;
                                                              }



            </script>
        </body>
    </html>