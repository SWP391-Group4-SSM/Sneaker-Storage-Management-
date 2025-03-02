<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thêm người dùng mới</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card shadow-lg p-4">
            <h2 class="text-center text-primary">Thêm người dùng mới</h2>
            
            <!-- Hiển thị thông báo lỗi nếu có -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form action="adduser" method="POST">
                <div class="mb-3">
                    <label class="form-label">Nhập Username:</label>
                    <input type="text" name="username" class="form-control" required/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Nhập Password:</label>
                    <input type="password" name="password" class="form-control" required/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Chọn Role:</label>
                    <select name="role" class="form-select">
                        <option value="Admin">Admin</option>
                        <option value="Supervisor">Supervisor</option>
                        <option value="Manager">Manager</option>
                        <option value="Staff">Staff</option>
                        <option value="Salesrep">Salesrep</option>
                    </select>
                </div>

                <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                    <button type="submit" class="btn btn-success">
                        <i class="bi bi-floppy-fill"></i> Lưu
                    </button>
                    <a href="listusers" class="btn btn-secondary">
                        <i class="bi bi-arrow-left-circle"></i> Quay lại
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
