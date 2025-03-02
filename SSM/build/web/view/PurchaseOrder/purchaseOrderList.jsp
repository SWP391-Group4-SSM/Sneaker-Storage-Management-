
<%@ page import="java.util.List, model.PurchaseOrder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách PO</title>
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid black; padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <c:out value="JSTL is working!" />
    <p style="color:red;">${error}</p>

    <h2>Danh sách Purchase Orders</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Supplier ID</th>
            <th>Warehouse ID</th>
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
                <td>${po.supplierId}</td>
                <td>${po.warehouseId}</td>
                <td>${po.createdByUserId}</td>
                <td>${po.orderDate}</td>
                <td>${po.purchaseOrderStatus}</td>
                <td>${po.totalAmount}</td>
                <td>${po.createdAt}</td>
                <td>${po.updateAt}</td>
                <td>
                    <a href="purchaseOrderList?action=edit&id=${po.purchaseOrderId}">Edit</a> |
                    <a href="purchaseOrderList?action=delete&id=${po.purchaseOrderId}" onclick="return confirm('Are you sure?');">Delete</a>
                </td>
                <td>
                    <a href="purchaseOrderDetails?id=${po.purchaseOrderId}">View Details</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
