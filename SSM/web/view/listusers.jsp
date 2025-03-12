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

        <a href="adduser" class="btn btn-success mb-3"><i class="bi bi-plus-circle"></i> Thêm Người Dùng</a>
        
        <form action="listusers" method="get" class="mb-3 d-flex">
            <input type="text" name="searchUsername" class="form-control me-2" 
                   placeholder="Nhập tên người dùng" value="${searchUsername}">
            <select name="searchRole" class="form-select me-2">
                <option value="">-- Chọn vai trò --</option>
                <option value="Admin" ${searchRole == 'Admin' ? 'selected' : ''}>Admin</option>
                <option value="Supervisor" ${searchRole == 'Supervisor' ? 'selected' : ''}>Supervisor</option>
                <option value="Manager" ${searchRole == 'Manager' ? 'selected' : ''}>Manager</option>
                <option value="Staff" ${searchRole == 'Staff' ? 'selected' : ''}>Staff</option>
            </select>
            <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i> Tìm kiếm</button>
        </form>

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
                            <a href="edituser?userID=${user.userID}" class="btn btn-warning btn-sm"><i class="bi bi-pencil"></i> Sửa</a>
                            <button onclick="confirmDelete(${user.userID})" class="btn btn-danger btn-sm"><i class="bi bi-trash"></i> Xóa</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
