<%@ page import="java.util.List" %>
<%@ page import="model.Warehouse2" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Warehouse Management</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <a href="login" class="btn btn-secondary mb-3">🔙 Back to Login</a>
        <div class="container mt-4">
            <h2 class="text-center mb-4">Warehouse Management</h2>
            <div class="row">
                <div class="col-md-8">
                    <div class="card p-3">
                        <h4 class="mb-3" style="text-align: center"> Warehouse List</h4>
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Location</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                List<Warehouse2> warehouses = (List<Warehouse2>) request.getAttribute("warehouses");
                                if (warehouses != null && !warehouses.isEmpty()) {
                                    for (Warehouse2 warehouse : warehouses) { 
                                %>
                                <tr>
                                    <td><%= warehouse.getId() %></td>
                                    <td><%= warehouse.getName() %></td>
                                    <td><%= warehouse.getLocation() %></td>
                                    <td>
                                        <a href="warehouseservlet?editId=<%= warehouse.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                                        <form method="post" action="warehouseservlet" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this warehouse?');">
                                            <input type="hidden" name="id" value="<%= warehouse.getId() %>">
                                            <button type="submit" name="action" value="delete" class="btn btn-danger btn-sm">Delete</button>
                                        </form>
                                        <a href="zoneservlet?warehouseId=<%= warehouse.getId() %>" class="btn btn-info btn-sm">View Zones</a>
                                    </td>
                                </tr>
                                <% } 
                                } else { %>
                                <tr>
                                    <td colspan="4" class="text-center text-muted">No warehouses available</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card p-3">
                        <h4 class="text-center">Manage Warehouse</h4>
                        <form method="post" action="warehouseservlet">
                            <input type="hidden" name="id" value="<%= request.getAttribute("warehouseToEdit") != null ? ((Warehouse2) request.getAttribute("warehouseToEdit")).getId() : "" %>">

                            <div class="mb-3">
                                <label class="form-label">Warehouse Name</label>
                                <input type="text" class="form-control" name="name" required 
                                       value="<%= request.getAttribute("warehouseToEdit") != null ? ((Warehouse2) request.getAttribute("warehouseToEdit")).getName() : "" %>">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Location</label>
                                <input type="text" class="form-control" name="location" required 
                                       value="<%= request.getAttribute("warehouseToEdit") != null ? ((Warehouse2) request.getAttribute("warehouseToEdit")).getLocation() : "" %>">
                            </div>

                            <button type="submit" name="action" value="<%= request.getAttribute("warehouseToEdit") != null ? "update" : "add" %>" 
                                    class="btn btn-primary w-100">
                                <%= request.getAttribute("warehouseToEdit") != null ? "Update Warehouse" : "Add Warehouse" %>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
