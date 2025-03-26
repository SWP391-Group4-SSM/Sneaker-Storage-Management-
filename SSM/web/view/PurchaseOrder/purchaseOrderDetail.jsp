<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Chi tiết đơn hàng</title>
        <style>
            /* Reset mặc định */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }

            body {
                background-color: #f8f9fa;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 20px;
            }

            h2 {
                color: #333;
                margin-bottom: 20px;
            }

            /* Bảng */
            table {
                width: 80%;
                max-width: 800px;
                border-collapse: collapse;
                background: white;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            }

            th, td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }

            th {
                background-color: #007bff;
                color: white;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            /* Nút */
            a {
                display: inline-block;
                padding: 8px 12px;
                margin-top: 10px;
                text-decoration: none;
                font-weight: bold;
                border-radius: 5px;
            }

            .btn-add {
                background-color: #28a745;
                color: white;
            }

            .btn-add:hover {
                background-color: #218838;
            }

            .btn-back {
                background-color: #007bff;
                color: white;
            }

            .btn-back:hover {
                background-color: #0056b3;
            }

            .btn-edit {
                background-color: #ffc107;
                color: black;
            }

            .btn-edit:hover {
                background-color: #e0a800;
            }

            .btn-delete {
                background-color: #dc3545;
                color: white;
            }

            .btn-delete:hover {
                background-color: #c82333;
            }

            /* Responsive */
            @media (max-width: 600px) {
                table {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>
        <h2>Chi tiết đơn hàng - Mã: ${purchaseOrderId}</h2>
        <c:set var="hiddenStatuses" value="Ordered,Goods Received,Partially Received" />
        <c:set var="nextStatus" value="" />
        <c:choose>
            <c:when test="${po.purchaseOrderStatus eq 'Draft'}">
                <c:set var="nextStatus" value="Approved" />
            </c:when>
            <c:when test="${po.purchaseOrderStatus eq 'Approved'}">
                <c:set var="nextStatus" value="Ordered" />
            </c:when>
        </c:choose>

        <a href="purchaseOrderDetail?action=add&poId=${purchaseOrderId}" class="btn-add">Thêm mới</a>
        <form action="purchaseOrder" method="post">
            <input type="hidden" name="action" value="updateStatus">
            <input type="hidden" name="orderId" value="${po.purchaseOrderId}" />
            <input type="hidden" name="currentStatus" value="${po.purchaseOrderStatus}" />
            <c:if test="${!fn:contains(hiddenStatuses, po.purchaseOrderStatus)}">
                <button type="submit">${nextStatus}</button>
            </c:if>
        </form>
        <table>
            <tr>
                <th>Mã Chi Tiết</th>
                <th>Tên sản phẩm</th>
                <th>Kích cỡ</th>
                <th>Màu</th>
                <th>Số Lượng</th>
                <th>Đơn Giá</th>
                <th>Thành Tiền</th>
                <th>Hành Động</th>
            </tr>
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
        </table>
        <script>
            function confirmDelete(poId, id) {
                if (confirm("Bạn có chắc muốn xóa đơn hàng này không?")) {
                    window.location.href = "purchaseOrderDetail?action=delete&poId=" + poId + "&id=" + id;
                }
            }
        </script>
        <a href="purchaseOrder" class="btn-back">Quay lại danh sách</a>
    </body>
</html>
