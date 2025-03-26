<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Create Delivery Order</title>
</head>
<body>
    <h1>Create Delivery Order</h1>

    <form action="${pageContext.request.contextPath}/createDeliveryOrder" method="post">
        <label for="purchaseOrderId">Purchase Order:</label>
        <select name="purchaseOrderId" id="purchaseOrderId">
            <c:forEach var="po" items="${purchaseOrders}">
                <option value="${po.purchaseOrderId}">${po.purchaseOrderId}</option>
            </c:forEach>
        </select><br><br>

        <label for="createdByUserId">Created By User ID:</label>
        <input type="number" name="createdByUserId" id="createdByUserId" required><br><br>

        <label for="binId">Bin ID:</label>
        <input type="number" name="binId" id="binId" required><br><br>

        <input type="submit" value="Create Delivery Order">
    </form>
</body>
</html>