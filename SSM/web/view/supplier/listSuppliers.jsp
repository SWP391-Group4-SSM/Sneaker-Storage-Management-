<%@page import="java.util.List"%>
<%@page import="model.Supplier"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Supplier Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <script>
        function confirmDelete(supplierID) {
            if (confirm("Are you sure you want to delete this supplier?")) {
                window.location.href = "deletesupplier?supplierID=" + supplierID;
            }
        }
    </script>
</head>
<body class="bg-light">
    <div class="container mt-4">
        <h2 class="text-center mb-4">Supplier List</h2>

        <% if (request.getAttribute("message") != null) { %>
            <div class="alert alert-success"><%= request.getAttribute("message") %></div>
        <% } %>
        
        <form action="${pageContext.request.contextPath}/listsuppliers" method="get" class="mb-3">
            <div class="row">
                <div class="col-md-4 mb-2">
                    <input type="text" name="searchSupplierName" class="form-control" 
                           placeholder="Enter supplier name" value="${searchSupplierName}">
                </div>
                <div class="col-md-4 mb-2">
                    <input type="text" name="searchContactEmail" class="form-control" 
                           placeholder="Enter contact email" value="${searchContactEmail}">
                </div>
                <div class="col-md-4 mb-2">
                    <input type="text" name="searchContactPhone" class="form-control" 
                           placeholder="Enter contact phone" value="${searchContactPhone}">
                </div>
            </div>
            <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i> Search</button>
        </form>

        <a href="${pageContext.request.contextPath}/addsupplier" class="btn btn-success mb-3"><i class="bi bi-plus-circle"></i> Add Supplier</a>

        <table class="table table-hover table-bordered bg-white">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Supplier Name</th>
                    <th>Contact Email</th>
                    <th>Contact Phone</th>
                    <th>Address</th>
                    <th>Created At</th>
                    <th>Updated At</th>
                    <th class="text-center">Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${not empty data}">
                    <c:forEach var="supplier" items="${data}">
                        <tr>
                            <td>${supplier.supplierID}</td>
                            <td>${supplier.supplierName}</td>
                            <td>${supplier.contactEmail}</td>
                            <td>${supplier.contactPhone}</td>
                            <td>${supplier.address}</td>
                            <td>${supplier.createdAt}</td>
                            <td>${supplier.updatedAt}</td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/editsupplier?supplierID=${supplier.supplierID}" class="btn btn-warning btn-sm"><i class="bi bi-pencil"></i> Edit</a>
                                <button onclick="confirmDelete(${supplier.supplierID})" class="btn btn-danger btn-sm"><i class="bi bi-trash"></i> Delete</button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
                <c:if test="${empty data}">
                    <tr>
                        <td colspan="8" class="text-center">No suppliers available</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <nav>
            <ul class="pagination justify-content-center">
                <c:if test="${currentPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="${pageContext.request.contextPath}/listsuppliers?page=${currentPage - 1}&searchSupplierName=${searchSupplierName}&searchContactEmail=${searchContactEmail}&searchContactPhone=${searchContactPhone}">Previous</a>
                    </li>
                </c:if>
                <li class="page-item active">
                    <span class="page-link">${currentPage}</span>
                </li>
                <c:if test="${data.size() == 10}">
                    <li class="page-item">
                        <a class="page-link" href="${pageContext.request.contextPath}/listsuppliers?page=${currentPage + 1}&searchSupplierName=${searchSupplierName}&searchContactEmail=${searchContactEmail}&searchContactPhone=${searchContactPhone}">Next</a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
</body>
</html>