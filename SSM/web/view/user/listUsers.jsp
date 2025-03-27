<%@page import="java.util.List"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <script>
        function confirmDelete(userID) {
            if (confirm("Are you sure you want to delete this user?")) {
                window.location.href = "deleteuser?userID=" + userID;
            }
        }
    </script>
</head>
<body class="bg-light">
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="mb-0">User List</h2>
            <a href="${pageContext.request.contextPath}/listusers?action=logout" class="btn btn-danger"><i class="bi bi-box-arrow-right"></i> Logout</a>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/listusers" method="get" class="mb-3 d-flex">
            <input type="text" name="searchUsername" class="form-control me-2" 
                   placeholder="Enter username" value="${searchUsername}">
            <select name="searchRole" class="form-select me-2">
                <option value="">-- Select role --</option>
                <option value="Admin" ${searchRole == 'Admin' ? 'selected' : ''}>Admin</option>
                <option value="Supervisor" ${searchRole == 'Supervisor' ? 'selected' : ''}>Supervisor</option>
                <option value="Manager" ${searchRole == 'Manager' ? 'selected' : ''}>Manager</option>
                <option value="Staff" ${searchRole == 'Staff' ? 'selected' : ''}>Staff</option>
                <option value="Salesrep" ${searchRole == 'Salesrep' ? 'selected' : ''}>Salesrep</option>
            </select>
            <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i> Search</button>
        </form>

        <a href="${pageContext.request.contextPath}/adduser" class="btn btn-success mb-3"><i class="bi bi-plus-circle"></i> Add User</a>

        <table class="table table-hover table-bordered bg-white">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Role</th>
                    <th>Created At</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Number Phone</th>
                    <th>Address</th>
                    <th class="text-center">Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${not empty data}">
                    <c:forEach var="user" items="${data}">
                        <tr>
                            <td>${user.userID}</td>
                            <td>${user.username}</td>
                            <td>${user.role}</td>
                            <td>${user.createdAt}</td>
                            <td>${user.name}</td>
                            <td>${user.email}</td>
                            <td>${user.numberPhone}</td>
                            <td>${user.address}</td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/edituser?userID=${user.userID}" class="btn btn-warning btn-sm"><i class="bi bi-pencil"></i> Edit</a>
                                <button onclick="confirmDelete(${user.userID})" class="btn btn-danger btn-sm"><i class="bi bi-trash"></i> Delete</button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
                <c:if test="${empty data}">
                    <tr>
                        <td colspan="9" class="text-center">No users available</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <nav>
            <ul class="pagination justify-content-center">
                <c:if test="${currentPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="${pageContext.request.contextPath}/listusers?page=${currentPage - 1}&searchUsername=${searchUsername}&searchRole=${searchRole}">Previous</a>
                    </li>
                </c:if>
                <li class="page-item active">
                    <span class="page-link">${currentPage}</span>
                </li>
                <c:if test="${data.size() == 10}">
                    <li class="page-item">
                        <a class="page-link" href="${pageContext.request.contextPath}/listusers?page=${currentPage + 1}&searchUsername=${searchUsername}&searchRole=${searchRole}">Next</a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
</body>
</html>