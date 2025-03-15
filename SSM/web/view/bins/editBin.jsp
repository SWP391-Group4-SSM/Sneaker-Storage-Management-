<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chỉnh sửa Bin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet"> <!-- Bootstrap Icons -->
</head>
<body class="bg-light">

    <div class="container mt-5">
        <div class="card shadow-lg p-4">
            <h2 class="text-center text-primary">Chỉnh sửa Bin</h2>

            <!-- Hiển thị thông báo lỗi nếu có -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">${error}</div>
            </c:if>

            <form action="editbin" method="POST">
                <input type="hidden" name="binID" value="${bin.binID}" />

                <div class="mb-3">
                    <label class="form-label">Nhập SectionID</label>
                    <input type="number" name="sectionID" class="form-control" value="${bin.sectionID}" required/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Nhập Tên Bin</label>
                    <input type="text" name="binName" class="form-control" value="${bin.binName}" required/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Nhập Dung tích</label>
                    <input type="number" name="capacity" class="form-control" value="${bin.capacity}" required/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Nhập Mô tả</label>
                    <textarea name="description" class="form-control">${bin.description}</textarea>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-success"><i class="bi bi-pencil-square"></i> Lưu</button>
                    <a href="listbins" class="btn btn-secondary"><i class="bi bi-arrow-left"></i> Quay lại</a>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>