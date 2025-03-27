<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edit User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet"> <!-- Bootstrap Icons -->
    <style>
        .bold-input {
            font-weight: bold;
        }
    </style>
</head>
<body class="bg-light">

    <div class="container mt-5">
        <div class="card shadow-lg p-4">
            <h2 class="text-center text-primary">Edit User</h2>

            <!-- Display error message if any -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">${error}</div>
            </c:if>

            <form action="edituser" method="POST">
                <input type="hidden" name="userID" value="${user.userID}" />

                <div class="mb-3">
                    <label class="form-label">Username</label>
                    <input type="text" name="username" class="form-control bold-input" value="${user.username}" readonly/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Enter Password</label>
                    <input type="password" name="password" class="form-control"/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Select Role</label>
                    <select name="role" class="form-select">
                        <option value="Admin" ${user.role == 'Admin' ? 'selected' : ''}>Admin</option>
                        <option value="Supervisor" ${user.role == 'Supervisor' ? 'selected' : ''}>Supervisor</option>
                        <option value="Manager" ${user.role == 'Manager' ? 'selected' : ''}>Manager</option>
                        <option value="Staff" ${user.role == 'Staff' ? 'selected' : ''}>Staff</option>
                        <option value="Salesrep" ${user.role == 'Salesrep' ? 'selected' : ''}>Salesrep</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Name</label>
                    <input type="text" name="name" class="form-control" value="${user.name}"/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" value="${user.email}"/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Number Phone</label>
                    <input type="text" name="numberPhone" class="form-control" value="${user.numberPhone}"/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Address</label>
                    <input type="text" name="address" class="form-control" value="${user.address}"/>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-success"><i class="bi bi-pencil-square"></i> Save</button>
                    <a href="listusers" class="btn btn-secondary"><i class="bi bi-arrow-left"></i> Back</a>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>