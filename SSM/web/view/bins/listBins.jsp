<%@page import="java.util.List"%>
<%@page import="model.Bin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Bins</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <script>
        function confirmDelete(binID) {
            if (confirm("Bạn có chắc chắn muốn xóa bin này?")) {
                window.location.href = "deletebin?binID=" + binID;
            }
        }
    </script>
</head>
<body class="bg-light">
    <div class="container mt-4">
        <h2 class="text-center mb-4">Danh Sách Bins</h2>

        <% if (request.getAttribute("message") != null) { %>
            <div class="alert alert-success"><%= request.getAttribute("message") %></div>
        <% } %>
        
        <form action="${pageContext.request.contextPath}/listbins" method="get" class="mb-3 d-flex">
            <input type="text" name="searchBinName" class="form-control me-2" 
                   placeholder="Nhập tên bin" value="${searchBinName}">
            <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i> Tìm kiếm</button>
        </form>

        <a href="${pageContext.request.contextPath}/addbin" class="btn btn-success mb-3"><i class="bi bi-plus-circle"></i> Thêm Bin</a>

        <table class="table table-hover table-bordered bg-white">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>SectionID</th>
                    <th>Tên Bin</th>
                    <th>Dung tích</th>
                    <th>Mô tả</th>
                    <th>Created At</th>
                    <th class="text-center">Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${not empty data}">
                    <c:forEach var="bin" items="${data}">
                        <tr>
                            <td>${bin.binID}</td>
                            <td>${bin.sectionID}</td>
                            <td>${bin.binName}</td>
                            <td>${bin.capacity}</td>
                            <td>${bin.description}</td>
                            <td>${bin.createdAt}</td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/editbin?binID=${bin.binID}" class="btn btn-warning btn-sm"><i class="bi bi-pencil"></i> Sửa</a>
                                <button onclick="confirmDelete(${bin.binID})" class="btn btn-danger btn-sm"><i class="bi bi-trash"></i> Xóa</button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
                <c:if test="${empty data}">
                    <tr>
                        <td colspan="7" class="text-center">Không có bins nào</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <nav>
            <ul class="pagination justify-content-center">
                <c:if test="${currentPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="${pageContext.request.contextPath}/listbins?page=${currentPage - 1}&searchBinName=${searchBinName}">Trước</a>
                    </li>
                </c:if>
                <li class="page-item active">
                    <span class="page-link">${currentPage}</span>
                </li>
                <c:if test="${data.size() == 10}">
                    <li class="page-item">
                        <a class="page-link" href="${pageContext.request.contextPath}/listbins?page=${currentPage + 1}&searchBinName=${searchBinName}">Sau</a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
</body>
</html>