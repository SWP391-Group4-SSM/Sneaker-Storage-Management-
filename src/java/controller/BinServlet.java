package controller;

import dal.BinDAO;
import dal.ZoneDAO;
import dal.WarehouseDAO2;
import model.Bin;
import model.Zone;
import model.Warehouse2;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

public class BinServlet extends HttpServlet {

    private final BinDAO binDAO = new BinDAO();
    private final ZoneDAO zoneDAO = new ZoneDAO();
    private final WarehouseDAO2 warehouseDAO = new WarehouseDAO2();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String zoneIdStr = request.getParameter("zoneId");
        if (zoneIdStr != null) {
            try {
                int zoneId = Integer.parseInt(zoneIdStr);
                loadCommonAttributes(request, zoneId);

                if ("edit".equals(request.getParameter("action"))) {
                    int binId = Integer.parseInt(request.getParameter("id"));
                    Bin binToEdit = binDAO.getBinById(binId);
                    request.setAttribute("binToEdit", binToEdit);
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        request.getRequestDispatcher("view/bin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int zoneId = Integer.parseInt(request.getParameter("zoneId"));
        boolean hasError = false;

        String name = request.getParameter("name");
        String capacityStr = request.getParameter("capacity");
        String currentLoadStr = request.getParameter("currentLoad");
        String description = request.getParameter("description");

        if ("delete".equals(action)) {
            deleteBin(request);
            response.sendRedirect(request.getContextPath() + "/binservlet?zoneId=" + zoneId);
            return;
        }

        int capacity = 0;
        int currentLoad = 0;

        if ("add".equals(action) || "update".equals(action)) {
            if (name == null || name.trim().isEmpty()) {
                hasError = true;
                request.setAttribute("nameError", "Bin name cannot be empty");
            }

            try {
                capacity = Integer.parseInt(capacityStr);
                if (capacity <= 0) {
                    hasError = true;
                    request.setAttribute("capacityError", "Capacity must be a positive integer");
                }
            } catch (NumberFormatException e) {
                hasError = true;
                request.setAttribute("capacityError", "Capacity must be a positive integer");
            }

            try {
                currentLoad = Integer.parseInt(currentLoadStr);
                if (currentLoad < 0) {
                    hasError = true;
                    request.setAttribute("currentLoadError", "Current load must be a non-negative integer");
                }
            } catch (NumberFormatException e) {
                hasError = true;
                request.setAttribute("currentLoadError", "Current load must be a non-negative integer");
            }

            if (capacity > 0 && currentLoad >= 0 && currentLoad > capacity) {
                hasError = true;
                request.setAttribute("currentLoadError", "Current load must not exceed capacity");
            }

            int totalCapacity = binDAO.getTotalBinCapacityByZoneId(zoneId);
            int zoneCapacity = zoneDAO.getZoneById(zoneId).getCapacity();

            if ("update".equals(action)) {
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Bin existingBin = binDAO.getBinById(id);
                    if (existingBin != null) {
                        totalCapacity -= existingBin.getCapacity();
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }

            if (totalCapacity + capacity > zoneCapacity) {
                hasError = true;
                request.setAttribute("zoneCapacityError", "Total bin capacity exceeds zone capacity.");
            }

            if (hasError) {
                if ("update".equals(action)) {
                    try {
                        int id = Integer.parseInt(request.getParameter("id"));
                        Bin binInput = new Bin(id, zoneId, name, capacity, currentLoad, description, null);
                        request.setAttribute("binToEdit", binInput);
                    } catch (NumberFormatException ex) {
                        ex.printStackTrace();
                    }
                }
                loadCommonAttributes(request, zoneId);
                request.getRequestDispatcher("view/bin.jsp").forward(request, response);
                return;
            }
        }

        if ("add".equals(action)) {
            Bin newBin = new Bin(0, zoneId, name, capacity, currentLoad, description, new Timestamp(System.currentTimeMillis()));
            binDAO.addBin(newBin);
        } else if ("update".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Bin updateBin = new Bin(id, zoneId, name, capacity, currentLoad, description, null);
                binDAO.updateBin(updateBin);
            } catch (NumberFormatException ex) {
                ex.printStackTrace();
            }
        }

        response.sendRedirect(request.getContextPath() + "/binservlet?zoneId=" + zoneId);
    }

    private void loadCommonAttributes(HttpServletRequest request, int zoneId) {
        List<Bin> bins = binDAO.getBinsByZoneId(zoneId);
        request.setAttribute("bins", bins);
        request.setAttribute("zoneId", zoneId);

        Zone zone = zoneDAO.getZoneById(zoneId);
        if (zone != null) {
            request.setAttribute("zoneName", zone.getName());
            request.setAttribute("zoneCapacity", zone.getCapacity()); // 🔹 Lấy tổng Capacity của Zone
            request.setAttribute("warehouseId", zone.getWarehouseId());

            Warehouse2 warehouse = warehouseDAO.getWarehouseById(zone.getWarehouseId());
            if (warehouse != null) {
                request.setAttribute("warehouseName", warehouse.getName());
            }

            int currentZoneCapacity = bins.stream().mapToInt(Bin::getCapacity).sum();
            request.setAttribute("currentZoneCapacity", currentZoneCapacity);
        }
    }

    private void deleteBin(HttpServletRequest request) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            binDAO.deleteBin(id);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }
}
