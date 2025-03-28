<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Chi tiết đơn hàng</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">

        <style>
            .custom-card {
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
                border-radius: 0.5rem;
            }
            .action-btn {
                width: 32px;
                height: 32px;
                padding: 0;
                display: inline-flex;
                align-items: center;
                justify-content: center;
            }
            .table-hover tbody tr:hover {
                background-color: rgba(0,123,255,0.05) !important;
            }
            .status-badge {
                font-size: 0.875rem;
            }
        </style>
    </head>
    <body class="bg-light">
        <div class="container-fluid py-4">
            <!-- Header Card -->
            <div class="card custom-card mb-4">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col-md-6">
                            <h2 class="card-title h4 mb-0">
                                <i class="bi bi-cart-check me-2"></i>Chi tiết đơn hàng
                                <span class="badge bg-primary ms-2">Mã: ${purchaseOrderId}</span>
                            </h2>
                            <p class="text-muted small mb-0 mt-2">
                                <i class="bi bi-clock me-1"></i>2025-03-27 00:47:54
                                <i class="bi bi-person ms-3 me-1"></i>ducws17
                            </p>
                        </div>
                        <div class="col-md-6 text-md-end mt-3 mt-md-0">
                            <c:if test="${po.purchaseOrderStatus ne 'Ordered' && 
                                          po.purchaseOrderStatus ne 'Goods Received' && 
                                          po.purchaseOrderStatus ne 'Partially Received'}">
                                  <a href="purchaseOrderDetail?action=add&poId=${purchaseOrderId}" 
                                     class="btn btn-success me-2">
                                      <i class="bi bi-plus-circle me-2"></i>Thêm mới
                                  </a>
                            </c:if>

                            <c:if test="${!fn:contains(hiddenStatuses, po.purchaseOrderStatus)}">
                                <form action="purchaseOrder" method="post" class="d-inline">
                                    <input type="hidden" name="action" value="updateStatus">
                                    <input type="hidden" name="orderId" value="${po.purchaseOrderId}" />
                                    <input type="hidden" name="currentStatus" value="${po.purchaseOrderStatus}" />
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-arrow-right-circle me-2"></i>${nextStatus}
                                    </button>
                                </form>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Content Card -->
            <div class="card custom-card">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Mã Chi Tiết</th>
                                    <th>Tên sản phẩm</th>
                                    <th >Kích cỡ</th>
                                    <th >Màu</th>
                                    <th>Số Lượng</th>
                                    <th >Đơn Giá</th>
                                    <th >Thành Tiền</th>
                                    <th >Hành Động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty podList}">
                                        <tr>
                                            <td colspan="8" class="text-center py-4">
                                                <div class="text-muted">
                                                    <i class="bi bi-inbox fs-2 d-block mb-2"></i>
                                                    Không có chi tiết đơn hàng nào
                                                </div>
                                            </td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="pod" items="${podList}">
                                            <tr>
                                                <td>${pod.purchaseOrderDetailId}</td>
                                                <td>
                                                    <c:set var="productName" value="Không xác định" />
                                                    <c:forEach var="pd" items="${prdList}">
                                                        <c:if test="${pd.productDetailId ==pod.productDetailId}">
                                                            <c:forEach var="pr" items="${proList}">
                                                                <c:if test="${pr.productId == pd.productId}">
                                                                    <c:set var="productName" value="${pr.name}" />
                                                                </c:if>
                                                            </c:forEach>
                                                        </c:if>
                                                    </c:forEach>
                                                    ${productName}
                                                </td>
                                                <td>
                                                    <c:set var="Size" value="Không xác định" />
                                                    <c:forEach var="pd" items="${prdList}">
                                                        <c:if test="${pd.productDetailId ==pod.productDetailId}">
                                                            <c:set var="Size" value="${pd.size}" />
                                                        </c:if>
                                                    </c:forEach>
                                                    ${Size}
                                                </td>
                                                <td>
                                                    <c:set var="color" value="Không xác định" />
                                                    <c:forEach var="pd" items="${prdList}">
                                                        <c:if test="${pd.productDetailId ==pod.productDetailId}">
                                                            <c:set var="color" value="${pd.color}" />
                                                        </c:if>
                                                    </c:forEach>
                                                    ${color}
                                                </td>
                                                <td>${pod.quantityOrdered}</td>
                                                <td>${pod.unitPrice}</td>
                                                <td>${pod.totalPrice}</td>
                                                <td>
                                                    <c:if test="${po.purchaseOrderStatus ne 'Ordered'&& 
                                                                  po.purchaseOrderStatus ne 'Goods Received'&& 
                                                                  po.purchaseOrderStatus ne 'Partially Received'}">
                                                          <a href="purchaseOrderDetail?action=edit&poId=${purchaseOrderId}&id=${pod.purchaseOrderDetailId}" class="btn-edit">Sửa</a>
                                                          <a href="javascript:void(0);" onclick="confirmDelete(${purchaseOrderId}, ${pod.purchaseOrderDetailId})" class="btn-delete">Xóa</a>
                                                    </c:if>

                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                            <tfoot class="table-light fw-bold">
                                <tr>
                                    <td colspan="4" class="text-end">Tổng cộng:</td>
                                    <td ">
                                        <c:choose>
                                            <c:when test="${empty podList}">0</c:when>
                                            <c:otherwise>
                                                ${podList.stream().map(item -> item.quantityOrdered).sum()}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td></td>
                                    
                                    <td></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Back Button -->
            <div class="mt-4">
                <a href="purchaseOrder" class="btn btn-secondary">
                    <i class="bi bi-arrow-left me-2"></i>Quay lại danh sách
                </a>
            </div>
        </div>

        <!-- Delete Confirmation Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            <i class="bi bi-exclamation-triangle-fill text-danger me-2"></i>
                            Xác nhận xóa
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        Bạn có chắc muốn xóa chi tiết đơn hàng này không?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="bi bi-x-circle me-2"></i>Hủy
                        </button>
                        <button type="button" class="btn btn-danger" id="confirmDeleteBtn">
                            <i class="bi bi-trash me-2"></i>Xóa
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
                                let deletePoId = null;
                                let deleteId = null;

                                function confirmDelete(poId, id) {
                                    deletePoId = poId;
                                    deleteId = id;
                                    $('#deleteModal').modal('show');
                                }

                                document.getElementById('confirmDeleteBtn').addEventListener('click', function () {
                                    if (deletePoId !== null && deleteId !== null) {
                                        window.location.href = "purchaseOrderDetail?action=delete&poId=" + deletePoId + "&id=" + deleteId;
                                    }
                                });
        </script>
    </body>
</html>