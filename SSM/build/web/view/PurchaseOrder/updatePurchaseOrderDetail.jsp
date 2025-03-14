<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Update PurchaseOrderDetail</title>
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
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                height: 100vh;
                padding: 20px;
            }

            h2 {
                color: #333;
                margin-bottom: 20px;
            }

            /* Form */
            form {
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 400px;
            }

            label {
                font-weight: bold;
                display: block;
                margin-top: 10px;
            }

            input, select {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            button {
                width: 100%;
                padding: 10px;
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 5px;
                margin-top: 15px;
                cursor: pointer;
                font-size: 16px;
            }

            button:hover {
                background-color: #218838;
            }

            /* Nút quay lại */
            a {
                display: block;
                text-align: center;
                margin-top: 10px;
                text-decoration: none;
                font-weight: bold;
                color: #007bff;
            }

            a:hover {
                color: #0056b3;
            }

            /* Responsive */
            @media (max-width: 480px) {
                form {
                    width: 90%;
                }
            }
        </style>
    </head>
    <body>
        <h2>Update PurchaseOrderDetail</h2>
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null) { %>
            <p class="error"><%= errorMessage %></p>
        <% } %>
        
        <form action="purchaseOrderDetail" method="post">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="poId" value="<%= request.getAttribute("purchaseOrderId") %>">
            <%= request.getAttribute("purchaseOrderId") %>
            <label for="quantityOrdered">purchaseOrderDetailId</label>
            <input type="number" id="purchaseOrderDetailId" name="purchaseOrderDetailId" value="${purchaseOrderDetail.purchaseOrderDetailId}" required>
            <label for="quantityOrdered">Quantity:</label>
            <input type="number" id="quantityOrdered" name="quantityOrdered" value="${purchaseOrderDetail.quantityOrdered}" required>

            <label for="unitPrice">Unit Price:</label>
            <input type="number" id="unitPrice" name="unitPrice" step="0.01" value="${purchaseOrderDetail.unitPrice}" required>


            <button type="submit">Update</button>
            <a href="purchaseOrder">Cancel</a>
        </form>
    </body>
</html>
