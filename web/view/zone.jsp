<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.Zone" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Zone Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="text-center">Zone Management</h2>
        <h5 class="text-end">Warehouse: <%= request.getAttribute("warehouseName") %></h5>
    </div>
    <a href="warehouseservlet" class="btn btn-secondary mb-3">Back to Warehouses</a>

    <% 
        Map<String, String> errors = (Map<String, String>) request.getAttribute("errors");
        String name = (String) request.getAttribute("name");
        String capacity = (String) request.getAttribute("capacity");
        String description = (String) request.getAttribute("description");
    %>

    <div class="row">
        <div class="col-md-8">
            <div class="card p-3">
                <h4 class="text-center">Zone List</h4>
                <table class="table table-bordered text-center">
                    <thead>
                        <tr>
                            <th>Zone ID</th>
                            <th>Zone Name</th>
                            <th>Capacity</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% List<Zone> zones = (List<Zone>) request.getAttribute("zones");
                           if (zones != null && !zones.isEmpty()) {
                               for (Zone zone : zones) { %>
                        <tr>
                            <td><%= zone.getId() %></td>
                            <td><%= zone.getName() %></td>
                            <td><%= zone.getCapacity() %></td>
                            <td>
                                <a href="zoneservlet?editId=<%= zone.getId() %>&warehouseId=<%= zone.getWarehouseId() %>" class="btn btn-warning btn-sm">Edit</a>
                                <form method="post" action="zoneservlet" onsubmit="return confirm('Are you sure you want to delete this zone?');" style="display:inline;">
                                    <input type="hidden" name="id" value="<%= zone.getId() %>">
                                    <input type="hidden" name="warehouseId" value="<%= request.getAttribute("warehouseId") %>">
                                    <button type="submit" name="action" value="delete" class="btn btn-danger btn-sm">Delete</button>
                                </form>
                                <a href="binservlet?zoneId=<%= zone.getId() %>" class="btn btn-info btn-sm">View Bins</a>
                            </td>
                        </tr>
                        <% } } else { %>
                        <tr><td colspan="4" class="text-center">No zones available</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card p-3">
                <h4 class="text-center">Manage Zone</h4>
                <form method="post" action="zoneservlet">
                    <input type="hidden" name="id" value="<%= request.getAttribute("zoneToEdit") != null ? ((Zone) request.getAttribute("zoneToEdit")).getId() : "" %>">
                    <input type="hidden" name="warehouseId" value="<%= request.getAttribute("warehouseId") %>">
                    <div class="mb-3">
                        <label class="form-label">Zone Name</label>
                        <input type="text" class="form-control" name="name" value="<%= name != null ? name : (request.getAttribute("zoneToEdit") != null ? ((Zone) request.getAttribute("zoneToEdit")).getName() : "") %>">
                        <% if (errors != null && errors.containsKey("name")) { %>
                        <div class="text-danger"><%= errors.get("name") %></div>
                        <% } %>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Capacity</label>
                        <input type="text" class="form-control" name="capacity" 
                               value="<%= capacity != null ? capacity : (request.getAttribute("zoneToEdit") != null ? ((Zone) request.getAttribute("zoneToEdit")).getCapacity() : "") %>">
                        <% if (errors != null && errors.containsKey("capacityError")) { %>
                        <div class="text-danger"><%= errors.get("capacityError") %></div>
                        <% } %>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Description</label>
                        <textarea class="form-control" name="description"><%= description != null ? description : (request.getAttribute("zoneToEdit") != null ? ((Zone) request.getAttribute("zoneToEdit")).getDescription() : "") %></textarea>
                    </div>
                    <button type="submit" name="action" value="<%= request.getAttribute("zoneToEdit") != null ? "update" : "add" %>" 
                            class="btn btn-primary w-100">
                        <%= request.getAttribute("zoneToEdit") != null ? "🔄 Update Zone" : "➕ Add Zone" %>
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
