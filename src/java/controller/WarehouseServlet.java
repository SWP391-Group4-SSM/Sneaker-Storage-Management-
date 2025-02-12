package controller;

import dao.WarehouseDAO;
import model.Warehouse;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class WarehouseServlet extends HttpServlet {

    private final WarehouseDAO warehouseDAO = new WarehouseDAO();

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    List<Warehouse> warehouses = warehouseDAO.getAllWarehouses();
    request.setAttribute("warehouses", warehouses);

    String warehouseId = request.getParameter("warehouseId");
    if (warehouseId != null) {
        response.sendRedirect("zoneservlet?warehouseId=" + warehouseId);
        return;
    }

    String id = request.getParameter("editId");
    if (id != null) {
        try {
            int warehouseIdInt = Integer.parseInt(id);
            Warehouse warehouse = warehouseDAO.getWarehouseById(warehouseIdInt);
            request.setAttribute("warehouseToEdit", warehouse);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    request.getRequestDispatcher("/warehouse.jsp").forward(request, response);
}


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/warehouseservlet");
            return;
        }

        try {
            switch (action) {
                case "add":
                    addWarehouse(request);
                    break;
                case "update":
                    updateWarehouse(request);
                    break;
                case "delete":
                    deleteWarehouse(request);
                    break;
                default:
                    break;
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/warehouseservlet");
    }

    private void addWarehouse(HttpServletRequest request) {
        String name = request.getParameter("name");
        String location = request.getParameter("location");
        if (name != null && location != null && !name.trim().isEmpty() && !location.trim().isEmpty()) {
            warehouseDAO.addWarehouse(new Warehouse(0, name, location));
        }
    }

    private void updateWarehouse(HttpServletRequest request) {
        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String location = request.getParameter("location");

        if (idStr != null && name != null && location != null) {
            int id = Integer.parseInt(idStr);
            warehouseDAO.updateWarehouse(new Warehouse(id, name, location));
        }
    }

    private void deleteWarehouse(HttpServletRequest request) {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            warehouseDAO.deleteWarehouse(id);
        }
    }
}
