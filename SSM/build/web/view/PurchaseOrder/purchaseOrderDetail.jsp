<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.PurchaseOrderDetail" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <h2>Chi tiết đơn hàng - Mã: <%= request.getAttribute("purchaseOrderId") %></h2>
    
    <a href="purchaseOrderDetail?action=add&poId=<%= request.getAttribute("purchaseOrderId") %>" class="btn-add">Thêm mới</a>

    <table>
        <tr>
            <th>Mã Chi Tiết</th>
            <th>Mã Sản Phẩm</th>
            <th>Số Lượng</th>
            <th>Đơn Giá</th>
            <th>Thành Tiền</th>
            <th>Hành Động</th>
        </tr>
        <% 
            List<PurchaseOrderDetail> podList = (List<PurchaseOrderDetail>) request.getAttribute("podList");
            for (PurchaseOrderDetail pod : podList) {
        %>
        <tr>
            <td><%= pod.getPurchaseOrderDetailId() %></td>
            <td><%= pod.getProductDetailId() %></td>
            <td><%= pod.getQuantityOrdered() %></td>
            <td><%= pod.getUnitPrice() %></td>
            <td><%= pod.getTotalPrice() %></td>
            <td>
                <a href="purchaseOrderDetail?action=edit&poId=<%= request.getAttribute("purchaseOrderId") %>&id=<%= pod.getPurchaseOrderDetailId() %>" class="btn-edit">Sửa</a>
                <a href="javascript:void(0);" onclick="confirmDelete(<%= request.getAttribute("purchaseOrderId") %>,<%= pod.getPurchaseOrderDetailId() %>)">Xóa</a>
            </td>
        </tr>
        <% } %>
    </table>
    <script>
            function confirmDelete(poId,id) {
                if (confirm("Bạn có chắc muốn xóa đơn hàng này không?")) {
                    window.location.href = "purchaseOrderDetail?action=delete&poId=" + poId + "&id=" + id;
                }
            }
        </script>
    <a href="purchaseOrder" class="btn-back">Quay lại danh sách</a>
</body>
</html>
