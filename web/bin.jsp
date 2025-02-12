<%@ page import="java.util.List" %>
<%@ page import="model.Bin" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Bin Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="CSS/style.css">
    </head>
    <body>

        <!-- Display Zone & Warehouse Name -->
        <div class="container-fluid text-end p-3">
            <h5>🏢 Warehouse: <strong><%= request.getAttribute("warehouseName") %></strong></h5>
            <h6>📍 Zone: <strong><%= request.getAttribute("zoneName") %></strong></h6>
        </div>
        <!-- Hiển thị Zone Capacity -->
        <div class="container-fluid text-center p-3">
            <h4>📦 Zone Capacity: <strong><%= request.getAttribute("zoneCapacity") %></strong></h4>
        </div>

        <!-- Hiển thị Current Capacity -->
        <div class="container-fluid text-center p-3">
            <h4>📦 Current Capacity: <strong><%= request.getAttribute("currentZoneCapacity") %></strong></h4>
        </div>


        <!-- Back Button -->
        <a href="zoneservlet?warehouseId=<%= request.getAttribute("warehouseId") %>" class="btn btn-secondary mb-3">
            ⬅ Back to Zones
        </a>

        <div class="container mt-4">
            <h2 class="text-center mb-4">📦 Bin Management</h2>

            <div class="row">
                <!-- Bin List -->
                <div class="col-md-8">
                    <div class="card p-3">
                        <h4 class="mb-3">📋 Bin List</h4>
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                                <tr>
                                    <th>Bin ID</th>
                                    <th>Name</th>
                                    <th>Capacity</th>
                                    <th>Current Load</th>
                                    <th>Product ID</th>
                                    <th>Description</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Bin> bins = (List<Bin>) request.getAttribute("bins");
                                   if (bins != null && !bins.isEmpty()) {
                                       for (Bin bin : bins) { %>
                                <tr>
                                    <td><%= bin.getId() %></td>
                                    <td><%= bin.getName() %></td>
                                    <td><%= bin.getCapacity() %></td>
                                    <td><%= bin.getCurrentLoad() %></td>
                                    <td></td>
                                    <td><%= bin.getDescription() %></td>
                                    <td>
                                        <a href="binservlet?action=edit&id=<%= bin.getId() %>&zoneId=<%= request.getParameter("zoneId") %>" class="btn btn-warning btn-sm">✏ Edit</a>
                                        <form method="post" action="binservlet" style="display:inline;">
                                            <input type="hidden" name="id" value="<%= bin.getId() %>">
                                            <input type="hidden" name="zoneId" value="<%= request.getParameter("zoneId") %>">
                                            <button type="submit" name="action" value="delete" class="btn btn-danger btn-sm">❌ Delete</button>
                                        </form>
                                    </td>
                                </tr>
                                <%       }
                               } else { %>
                                <tr><td colspan="7" class="text-center text-muted">No bins available</td></tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Add/Edit Bin Form -->
                <div class="col-md-4">
                    <div class="card p-3">
                        <h4 class="text-center">
                            Bin manage
                        </h4>
                        <form method="post" action="binservlet">
                            <!-- Các trường ẩn để giữ id và zoneId -->
                            <input type="hidden" name="id" 
                                   value="<%= request.getParameter("id") != null ? request.getParameter("id") : (request.getAttribute("binToEdit") != null ? ((Bin) request.getAttribute("binToEdit")).getId() : "") %>">
                            <input type="hidden" name="zoneId" 
                                   value="<%= request.getParameter("zoneId") != null ? request.getParameter("zoneId") : (request.getAttribute("binToEdit") != null ? ((Bin) request.getAttribute("binToEdit")).getZoneId() : request.getAttribute("zoneId")) %>">

                            <!-- Bin Name -->
                            <div class="mb-3">
                                <label class="form-label">Bin Name</label>
                                <input type="text" class="form-control" name="name" required
                                       value="<%= request.getParameter("name") != null ? request.getParameter("name") 
                   : (request.getAttribute("binToEdit") != null ? ((Bin) request.getAttribute("binToEdit")).getName() : "") %>">
                                <% if(request.getAttribute("nameError") != null) { %>
                                <div class="text-danger"><%= request.getAttribute("nameError") %></div>
                                <% } %>
                            </div>

                            <!-- Capacity -->
                            <div class="mb-3">
                                <label class="form-label">Capacity</label>
                                <input type="number" class="form-control" name="capacity" required
                                       value="<%= request.getParameter("capacity") != null ? request.getParameter("capacity")
                   : (request.getAttribute("binToEdit") != null ? ((Bin) request.getAttribute("binToEdit")).getCapacity() : "") %>">
                                <% if(request.getAttribute("capacityError") != null) { %>
                                <div class="text-danger"><%= request.getAttribute("capacityError") %></div>
                                <% } %>
                            </div>

                            <!-- Current Load -->
                            <div class="mb-3">
                                <label class="form-label">Current Load</label>
                                <input type="number" class="form-control" name="currentLoad" required
                                       value="<%= request.getParameter("currentLoad") != null ? request.getParameter("currentLoad")
                   : (request.getAttribute("binToEdit") != null ? ((Bin) request.getAttribute("binToEdit")).getCurrentLoad() : "") %>">
                                <% if(request.getAttribute("currentLoadError") != null) { %>
                                <div class="text-danger"><%= request.getAttribute("currentLoadError") %></div>
                                <% } %>
                            </div>

                            <!-- Description -->
                            <div class="mb-3">
                                <label class="form-label">Description</label>
                                <input type="text" class="form-control" name="description" required
                                       value="<%= request.getParameter("description") != null ? request.getParameter("description")
                   : (request.getAttribute("binToEdit") != null ? ((Bin) request.getAttribute("binToEdit")).getDescription() : "") %>">
                            </div>

                            <!-- Kiểm tra tổng Capacity không vượt quá Zone Capacity -->
                            <% if(request.getAttribute("zoneCapacityError") != null) { %>
                            <div class="mb-3 text-danger">
                                <%= request.getAttribute("zoneCapacityError") %>
                            </div>
                            <% } %>

                            <button type="submit" name="action" value="<%= request.getAttribute("binToEdit") != null ? "update" : "add" %>"
                                    class="btn btn-primary w-100">
                                <%= request.getAttribute("binToEdit") != null ? "Update Bin" : "Add Bin" %>
                            </button>
                        </form>

                    </div>
                </div>
            </div>
        </div>

    </body>
</html>