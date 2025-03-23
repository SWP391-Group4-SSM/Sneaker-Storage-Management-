<%@ page import="java.util.List, model.PurchaseOrder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Danh sách PO</title>
        <style>
            /* Reset mặc định */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }

            /* Định dạng trang */
            body {
                background-color: #f8f9fa;
                padding: 20px;
            }

            /* Tiêu đề */
            h2 {
                text-align: center;
                color: #333;
                margin-bottom: 20px;
            }

            /* Nút thêm mới */
            a[href="purchaseOrder?action=add"] {
                display: inline-block;
                background-color: #28a745;
                color: white;
                padding: 10px 15px;
                text-decoration: none;
                border-radius: 5px;
                margin-bottom: 15px;
            }

            a[href="purchaseOrder?action=add"]:hover {
                background-color: #218838;
            }

            /* Bảng */
            table {
                width: 100%;
                border-collapse: collapse;
                background-color: white;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                overflow: hidden;
            }

            /* Tiêu đề bảng */
            th {
                background-color: #007bff;
                color: white;
                padding: 12px;
                text-align: left;
            }

            /* Dữ liệu bảng */
            td {
                padding: 10px;
                border-bottom: 1px solid #ddd;
            }

            /* Dòng chẵn khác màu */
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            /* Hiệu ứng hover */
            tr:hover {
                background-color: #dfe6e9;
            }

            /* Liên kết */
            a {
                text-decoration: none;
                color: #007bff;
                font-weight: bold;
            }

            a:hover {
                color: #0056b3;
            }

            /* Nút Xóa */
            a[onclick*="confirmDelete"] {
                color: #dc3545;
            }

            a[onclick*="confirmDelete"]:hover {
                color: #b02a37;
            }

            /* Responsive */
            @media (max-width: 768px) {
                table {
                    display: block;
                    overflow-x: auto;
                    white-space: nowrap;
                }

                th, td {
                    font-size: 14px;
                }

                a[href="addPurchaseOrder"] {
                    display: block;
                    text-align: center;
                }
            }
        </style>
    </head>
    <body>

        <h2>Danh sách Purchase Orders</h2>
        <a href="purchaseOrder?action=add">Thêm mới</a>
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null) { %>
        <p class="error"><%= errorMessage %></p>
        <% } %>
        <table>
            <tr>
                <th>ID</th>
                <th>Supplier </th>
                <th>Warehouse</th>
                <th>Created By</th>
                <th>Order Date</th>
                <th>Status</th>
                <th>Total Amount</th>
                <th>Created At</th>
                <th>Updated At</th>
                <th>Action</th>
                <th>Detail</th>
            </tr>
            <c:if test="${empty purchaseOrders}">
                <tr><td colspan="10">Không có đơn hàng nào!</td></tr>
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
                    <td>${po.purchaseOrderStatus}</td>
                    <td>${po.totalAmount}</td>
                    <td>${po.createdAt}</td>
                    <td>${po.updatedAt}</td>
                    <td>
                        <c:if test="${po.purchaseOrderStatus ne 'Ordered'}">
                            <a href="purchaseOrder?action=edit&id=${po.purchaseOrderId}">Sửa</a> | |
                            <a href="javascript:void(0);" onclick="confirmDelete(${po.purchaseOrderId})">Xóa</a>
                        </c:if>

                    </td>

                    <td>
                        <a href="purchaseOrderDetail?poId=${po.purchaseOrderId}">View Details</a>
                    </td>
                </tr>
            </c:forEach>

        </table>
        <!-- Phân trang -->
        <div style="text-align: center; margin-top: 20px;">
            <c:if test="${totalPages > 1}">
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <a href="purchaseOrder?page=${i}" 
                       style="padding: 8px 12px; margin: 0 5px;
                       text-decoration: none; border: 1px solid #007bff;
                       color: ${i == currentPage ? 'white' : '#007bff'};
                       background-color: ${i == currentPage ? '#007bff' : 'white'};
                       border-radius: 4px;">
                        ${i}
                    </a>
                </c:forEach>
            </c:if>
        </div>

        <script>
            function confirmDelete(id) {
                if (confirm("Bạn có chắc muốn xóa đơn hàng này không?")) {
                    window.location.href = "purchaseOrder?action=delete&id=" + id;
                }
            }
        </script>
    </body>
</html>
