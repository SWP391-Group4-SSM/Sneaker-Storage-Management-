package controller;

import dal.WarehouseDAO2;
import dal.ZoneDAO;
import model.Zone;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

public class ZoneServlet extends HttpServlet {

    private final ZoneDAO zoneDAO = new ZoneDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String warehouseIdStr = request.getParameter("warehouseId");
        String editIdStr = request.getParameter("editId");

        if (warehouseIdStr != null) {
            try {
                int warehouseId = Integer.parseInt(warehouseIdStr);
                List<Zone> zones = zoneDAO.getZonesByWarehouseId(warehouseId);
                String warehouseName = new WarehouseDAO2().getWarehouseNameById(warehouseId);

                request.setAttribute("zones", zones);
                request.setAttribute("warehouseId", warehouseId);
                request.setAttribute("warehouseName", warehouseName);

                if (editIdStr != null) {
                    int editId = Integer.parseInt(editIdStr);
                    Zone zoneToEdit = zoneDAO.getZoneById(editId);
                    request.setAttribute("zoneToEdit", zoneToEdit);
                }

            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        request.getRequestDispatcher("view/zone.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String warehouseIdStr = request.getParameter("warehouseId");
        String name = request.getParameter("name");
        String capacityStr = request.getParameter("capacity");
        String description = request.getParameter("description");

        Map<String, String> errors = new HashMap<>();
        int warehouseId = 0;
        int capacity = 0;

        // Xử lý action delete
        if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Zone zoneToDelete = zoneDAO.getZoneById(id);
                if (zoneToDelete != null) {
                    warehouseId = zoneToDelete.getWarehouseId();
                }
                zoneDAO.deleteZone(id);
                response.sendRedirect("zoneservlet?warehouseId=" + warehouseId);
                return;
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // Validate warehouseId
        try {
            warehouseId = Integer.parseInt(warehouseIdStr);
        } catch (NumberFormatException e) {
            errors.put("warehouseId", "Invalid warehouse ID.");
        }

        // Validate name
        if (name == null || name.trim().isEmpty()) {
            errors.put("name", "Zone name cannot be empty.");
        }

        // Validate capacity
        try {
            capacity = Integer.parseInt(capacityStr);
            if (capacity < 0) {
                errors.put("capacityError", "Capacity must be a non-negative integer.");
            }
        } catch (NumberFormatException e) {
            errors.put("capacityError", "Capacity must be a valid number.");
        }

        // Xử lý action update
        if ("update".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Zone existingZone = zoneDAO.getZoneById(id);
                int currentCapacity = zoneDAO.getCurrentCapacity(id);

                if (capacity < currentCapacity) {
                    errors.put("capacityError", "Capacity cannot be less than the current number of stored items (" + currentCapacity + ").");
                }

                if (!errors.isEmpty()) {
                    request.setAttribute("errors", errors);
                    request.setAttribute("name", name);
                    request.setAttribute("capacity", capacityStr);
                    request.setAttribute("description", description);
                    request.setAttribute("zoneToEdit", existingZone);
                    doGet(request, response);
                    return;
                }

                Zone updatedZone = new Zone(id, warehouseId, name, capacity, description);
                if (zoneDAO.updateZone(updatedZone)) {
                    response.sendRedirect("zoneservlet?warehouseId=" + warehouseId);
                } else {
                    errors.put("general", "Failed to update zone.");
                    request.setAttribute("errors", errors);
                    request.setAttribute("zoneToEdit", existingZone);
                    doGet(request, response);
                }
                return;
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        } // Xử lý action add
        else if ("add".equals(action)) {
            if (!errors.isEmpty()) {
                request.setAttribute("errors", errors);
                request.setAttribute("name", name);
                request.setAttribute("capacity", capacityStr);
                request.setAttribute("description", description);
                doGet(request, response);
                return;
            }

            Zone newZone = new Zone(0, warehouseId, name, capacity, description);
            if (zoneDAO.addZone(newZone)) {
                response.sendRedirect("zoneservlet?warehouseId=" + warehouseId);
            } else {
                errors.put("general", "Failed to add zone.");
                request.setAttribute("errors", errors);
                doGet(request, response);
            }
            return;
        }

        response.sendRedirect("zoneservlet?warehouseId=" + warehouseId);
    }
}
