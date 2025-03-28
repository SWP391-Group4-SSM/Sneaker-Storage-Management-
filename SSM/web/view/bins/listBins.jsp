<%@page import="java.util.List"%>
<%@page import="model.Bin"%>
<%@page import="model.WarehouseSection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bin Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <script>
        function confirmDelete(binID) {
            if (confirm("Are you sure you want to delete this bin?")) {
                window.location.href = "deletebin?binID=" + binID;
            }
        }
    </script>
</head>
<body class="bg-light">
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="mb-0">Bin List</h2>
            <a href="${pageContext.request.contextPath}/listbins?action=logout" class="btn btn-danger"><i class="bi bi-box-arrow-right"></i> Logout</a>
        </div>

        <% if (request.getAttribute("message") != null) { %>
            <div class="alert alert-success"><%= request.getAttribute("message") %></div>
        <% } %>
        
        <form action="${pageContext.request.contextPath}/listbins" method="get" class="mb-3 d-flex">
            <input type="text" name="searchBinName" class="form-control me-2" 
                   placeholder="Enter bin name" value="${searchBinName}">
            <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i> Search</button>
        </form>

        <a href="${pageContext.request.contextPath}/addbin" class="btn btn-success mb-3"><i class="bi bi-plus-circle"></i> Add Bin</a>

        <table class="table table-hover table-bordered bg-white">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Section Name</th>
                    <th>Bin Name</th>
                    <th>Capacity</th>
                    <th>Description</th>
                    <th>Created At</th>
                    <th class="text-center">Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${not empty data}">
                    <c:forEach var="bin" items="${data}">
                        <tr>
                            <td>${bin.binID}</td>
                            <td>
                                <c:forEach var="section" items="${sections}">
                                    <c:if test="${section.sectionID == bin.sectionID}">
                                        ${section.sectionName}
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td>${bin.binName}</td>
                            <td>${bin.capacity}</td>
                            <td>${bin.description}</td>
                            <td>${bin.createdAt}</td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${bin.locked}">
                                        <span class="badge bg-secondary">Locked</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/editbin?binID=${bin.binID}" class="btn btn-warning btn-sm"><i class="bi bi-pencil"></i> Edit</a>
                                        <button onclick="confirmDelete(${bin.binID})" class="btn btn-danger btn-sm"><i class="bi bi-trash"></i> Delete</button>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
                <c:if test="${empty data}">
                    <tr>
                        <td colspan="7" class="text-center">No bins available</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <nav>
            <ul class="pagination justify-content-center">
                <c:if test="${currentPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="${pageContext.request.contextPath}/listbins?page=${currentPage - 1}&searchBinName=${searchBinName}">Previous</a>
                    </li>
                </c:if>
                <li class="page-item active">
                    <span class="page-link">${currentPage}</span>
                </li>
                <c:if test="${data.size() == 10}">
                    <li class="page-item">
                        <a class="page-link" href="${pageContext.request.contextPath}/listbins?page=${currentPage + 1}&searchBinName=${searchBinName}">Next</a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
</body>
</html>