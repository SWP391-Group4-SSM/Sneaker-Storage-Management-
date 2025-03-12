<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Danh Sách Bin</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
    <div class="container mt-4">
        <h2 class="text-center mb-4">Danh Sách Bin</h2>

        <form action="listbins" method="get" class="mb-3 d-flex">
            <input type="text" name="searchBinName" class="form-control me-2" 
                   placeholder="Nhập tên Bin" value="${searchBinName}">
            <button type="submit" class="btn btn-primary">Tìm kiếm</button>
        </form>

        <div class="d-flex justify-content-between mb-3">
            <a href="addBin.jsp" class="btn btn-success">Thêm Bin</a>
        </div>

        <table class="table table-hover table-bordered bg-white">
            <thead class="table-dark">
                <tr>
                    <th>Mã Bin</th>
                    <th>Tên Bin</th>
                    <th>Mô tả</th>
                    <th class="text-center">Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="bin" items="${data}">
                    <tr>
                        <td>${bin.binID}</td>
                        <td>${bin.binName}</td>
                        <td>${bin.description}</td>
                        <td class="text-center">
                            <a href="binDetails?binID=${bin.binID}" class="btn btn-info btn-sm">Chi tiết</a>
                            <a href="editBin?binID=${bin.binID}" class="btn btn-warning btn-sm">Sửa</a>
                            <a href="deleteBin?binID=${bin.binID}" class="btn btn-danger btn-sm">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
