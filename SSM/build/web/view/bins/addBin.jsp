<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Bin</title>
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
                <h4 class="mb-0"><i class="bi bi-box-seam"></i> Add Bin</h4>
            </div>
            <div class="card-body">
                <c:if test="${not empty errors}">
                    <div class="alert alert-danger">${errors.general}</div>
                </c:if>
                <c:if test="${not empty message}">
                    <div class="alert alert-success">${message}</div>
                </c:if>

                <form action="addbin" method="post">
                    <div class="mb-3">
                        <label for="binid" class="form-label">Bin ID:</label>
                        <input type="number" class="form-control" name="binid" required value="${param.binid}">
                        <c:if test="${not empty errors.binid}">
                            <div class="error">${errors.binid}</div>
                        </c:if>
                    </div>

                    <div class="mb-3">
                        <label for="sectionid" class="form-label">Section Name:</label>
                        <select class="form-select" name="sectionid" required>
                            <c:forEach var="section" items="${sections}">
                                <option value="${section.sectionID}">${section.sectionName}</option>
                            </c:forEach>
                        </select>
                        <c:if test="${not empty errors.sectionid}">
                            <div class="error">${errors.sectionid}</div>
                        </c:if>
                    </div>

                    <div class="mb-3">
                        <label for="binname" class="form-label">Bin Name:</label>
                        <input type="text" class="form-control" name="binname" required value="${param.binname}">
                        <c:if test="${not empty errors.binname}">
                            <div class="error">${errors.binname}</div>
                        </c:if>
                    </div>

                    <div class="mb-3">
                        <label for="capacity" class="form-label">Capacity:</label>
                        <input type="number" class="form-control" name="capacity" required value="${param.capacity}">
                        <c:if test="${not empty errors.capacity}">
                            <div class="error">${errors.capacity}</div>
                        </c:if>
                    </div>

                    <div class="mb-3">
                        <label for="description" class="form-label">Description:</label>
                        <textarea class="form-control" name="description">${param.description}</textarea>
                    </div>

                    <div class="d-flex justify-content-between">
                        <a href="listbins" class="btn btn-secondary"><i class="bi bi-arrow-left"></i> Back</a>
                        <button type="submit" class="btn btn-success"><i class="bi bi-check-circle"></i> Add</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>