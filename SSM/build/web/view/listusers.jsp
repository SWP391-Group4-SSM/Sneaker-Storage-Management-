<%@page import="java.util.List"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý người dùng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <script>
        function confirmDelete(userID) {
            if (confirm("Bạn có chắc chắn muốn xóa người dùng này?")) {
                window.location.href = "deleteuser?userID=" + userID;
            }
        }
    </script>
</head>
<body class="bg-light">
    <div class="container mt-4">
        <h2 class="text-center mb-4">Danh Sách Người Dùng</h2>
        
        <div class="d-flex justify-content-between mb-3">
            <a href="${pageContext.request.contextPath}/adduser" class="btn btn-success">
                <i class="bi bi-person-plus"></i> Thêm Người Dùng
            </a>
        </div>

        <table class="table table-hover table-bordered bg-white">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Role</th>
                    <th>Created At</th>
                    <th class="text-center">Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${data}">
                    <tr>
                        <td>${user.userID}</td>
                        <td>${user.username}</td>
                        <td>${user.role}</td>
                        <td>${user.createdAt}</td>
                        <td class="text-center">
                            <a href="edituser?userID=${user.userID}" class="btn btn-warning btn-sm">
                                <i class="bi bi-pencil"></i> Sửa
                            </a>
                            <button onclick="confirmDelete(${user.userID})" class="btn btn-danger btn-sm">
                                <i class="bi bi-trash"></i> Xóa
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
