<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Supplier</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .error { color: red; }
    </style>
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card shadow-lg">
            <div class="card-header bg-primary text-white">
                <h4 class="mb-0"><i class="bi bi-person-plus"></i> Add Supplier</h4>
            </div>
            <div class="card-body">
                <c:if test="${not empty errors}">
                    <div class="alert alert-danger">${errors.general}</div>
                </c:if>
                <c:if test="${not empty message}">
                    <div class="alert alert-success">${message}</div>
                </c:if>

                <form action="addsupplier" method="post">
                    <div class="mb-3">
                        <label for="supplierID" class="form-label">Supplier ID:</label>
                        <input type="number" class="form-control" name="supplierID" required value="${param.supplierID}">
                        <c:if test="${not empty errors.supplierID}">
                            <div class="error">${errors.supplierID}</div>
                        </c:if>
                    </div>

                    <div class="mb-3">
                        <label for="supplierName" class="form-label">Supplier Name:</label>
                        <input type="text" class="form-control" name="supplierName" required value="${param.supplierName}">
                        <c:if test="${not empty errors.supplierName}">
                            <div class="error">${errors.supplierName}</div>
                        </c:if>
                    </div>

                    <div class="mb-3">
                        <label for="contactEmail" class="form-label">Contact Email:</label>
                        <input type="email" class="form-control" name="contactEmail" value="${param.contactEmail}">
                        <c:if test="${not empty errors.contactEmail}">
                            <div class="error">${errors.contactEmail}</div>
                        </c:if>
                    </div>

                    <div class="mb-3">
                        <label for="contactPhone" class="form-label">Contact Phone:</label>
                        <input type="text" class="form-control" name="contactPhone" value="${param.contactPhone}">
                        <c:if test="${not empty errors.contactPhone}">
                            <div class="error">${errors.contactPhone}</div>
                        </c:if>
                    </div>

                    <div class="mb-3">
                        <label for="address" class="form-label">Address:</label>
                        <textarea class="form-control" name="address">${param.address}</textarea>
                        <c:if test="${not empty errors.address}">
                            <div class="error">${errors.address}</div>
                        </c:if>
                    </div>

                    <div class="d-flex justify-content-between">
                        <a href="listsuppliers" class="btn btn-secondary"><i class="bi bi-arrow-left"></i> Back</a>
                        <button type="submit" class="btn btn-success"><i class="bi bi-check-circle"></i> Add</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>