package controller.delivery;

import dal.DeliveryOrderDAO;
import dal.SupplierDAO;
import dal.UserDAO;
import model.DeliveryOrder;
import model.DeliveryOrderDetail;
import dal.WarehouseDAO;
import model.Warehouse;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

public class DeliveryOrderServlet extends HttpServlet {

    private DeliveryOrderDAO deliveryOrderDAO = new DeliveryOrderDAO();
    private WarehouseDAO warehouseDAO = new WarehouseDAO();
    private SupplierDAO supplierDAO = new SupplierDAO();
    private UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "details":
                showDeliveryOrderDetails(request, response);
                break;
            case "delete":  
                deleteDeliveryOrder(request, response);
                break;
            case "list":
            default:
                listDeliveryOrders(request, response);
                break;
        }
    }

    private void listDeliveryOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1;
        int recordsPerPage = 10;
        int warehouseId = -1; 
        int deliveryOrderId = -1; 
        String page_raw = request.getParameter("page");
        String warehouseId_raw = request.getParameter("warehouseId");
        String deliveryOrderId_raw = request.getParameter("deliveryOrderId");

        if (page_raw != null) {
            try {
                page = Integer.parseInt(page_raw);
            } catch (NumberFormatException e) {
            }
        }

        if (warehouseId_raw != null && !warehouseId_raw.isEmpty()) {
            try {
                warehouseId = Integer.parseInt(warehouseId_raw);
            } catch (NumberFormatException e) {
            }
        }

        if (deliveryOrderId_raw != null && !deliveryOrderId_raw.isEmpty()) {
            try {
                deliveryOrderId = Integer.parseInt(deliveryOrderId_raw);
            } catch (NumberFormatException e) {
            }
        }

        List<DeliveryOrder> deliveryOrders = deliveryOrderDAO.getDeliveryOrders(page, recordsPerPage, warehouseId, deliveryOrderId);
        int totalRecords = deliveryOrderDAO.getTotalDeliveryOrders(warehouseId, deliveryOrderId);
        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

        // Get all warehouses for the dropdown
        List<Warehouse> warehouses = warehouseDAO.getAllWarehouses();

        // Get all delivery orders for the dropdown (without pagination for the dropdown)
        List<DeliveryOrder> allDeliveryOrders = deliveryOrderDAO.getAllDeliveryOrders();

        // Get supplier names mapping
        Map<Integer, String> supplierNames = supplierDAO.getSupplierNamesMap();

        // Get user names mapping
        Map<Integer, String> userNames = userDAO.getUserNamesMap();

        // Create a map of warehouse IDs to arrays of delivery order IDs
        java.util.Map<Integer, java.util.List<Integer>> deliveryOrderIdsByWarehouse = new java.util.HashMap<>();

        java.util.List<Integer> allOrderIds = new java.util.ArrayList<>();
        for (DeliveryOrder order : allDeliveryOrders) {
            allOrderIds.add(order.getDeliveryOrderId());
        }
        deliveryOrderIdsByWarehouse.put(-1, allOrderIds);

        // Group delivery orders by warehouse
        for (DeliveryOrder order : allDeliveryOrders) {
            int orderWarehouseId = order.getWarehouseId();
            if (!deliveryOrderIdsByWarehouse.containsKey(orderWarehouseId)) {
                deliveryOrderIdsByWarehouse.put(orderWarehouseId, new java.util.ArrayList<>());
            }
            deliveryOrderIdsByWarehouse.get(orderWarehouseId).add(order.getDeliveryOrderId());
        }

        System.out.println("--- deliveryOrderIdsByWarehouse Map Debug ---");
        System.out.println("Total warehouses in map: " + deliveryOrderIdsByWarehouse.size());
        for (Map.Entry<Integer, List<Integer>> entry : deliveryOrderIdsByWarehouse.entrySet()) {
            System.out.println("Warehouse ID " + entry.getKey() + " has " + entry.getValue().size() + " orders");
        }

        for (DeliveryOrder order : deliveryOrders) {
            if (order.getSupplierId() != null) {
                System.out.println("Order " + order.getDeliveryOrderId()
                        + " has supplier ID: " + order.getSupplierId()
                        + ", name in map: " + supplierNames.get(order.getSupplierId()));
            } else {
                System.out.println("Order " + order.getDeliveryOrderId() + " has null supplier ID");
            }
        }

        // debug code to listDeliveryOrders after fetching allDeliveryOrders
        System.out.println("--- All Delivery Orders ---");
        System.out.println("Found " + allDeliveryOrders.size() + " total delivery orders");
        if (!allDeliveryOrders.isEmpty()) {
            DeliveryOrder firstOrder = allDeliveryOrders.get(0);
            System.out.println("Sample order: ID=" + firstOrder.getDeliveryOrderId()
                    + ", WarehouseID=" + firstOrder.getWarehouseId());
        }

        request.setAttribute("deliveryOrders", deliveryOrders);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("warehouseId", warehouseId);
        request.setAttribute("deliveryOrderId", deliveryOrderId);
        request.setAttribute("warehouses", warehouses);
        request.setAttribute("allDeliveryOrders", allDeliveryOrders);
        request.setAttribute("supplierNames", supplierNames);
        request.setAttribute("userNames", userNames);
        request.setAttribute("deliveryOrderIdsByWarehouse", deliveryOrderIdsByWarehouse);

        request.getRequestDispatcher("/view/delivery/deliveryOrders.jsp").forward(request, response);
    }

    private void showDeliveryOrderDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int deliveryOrderId = Integer.parseInt(request.getParameter("deliveryOrderId"));

            DeliveryOrder deliveryOrder = deliveryOrderDAO.getDeliveryOrderById(deliveryOrderId);
            if (deliveryOrder == null) {
                request.getSession().setAttribute("errorMessage", "Delivery Order #" + deliveryOrderId + " not found.");
                response.sendRedirect(request.getContextPath() + "/deliveryOrders");
                return;
            }

            List<DeliveryOrderDetail> details = deliveryOrderDAO.getDeliveryOrderDetailsByOrderId(deliveryOrderId);
            Map<Integer, String> supplierNames = supplierDAO.getSupplierNamesMap();
            Map<Integer, String> userNames = userDAO.getUserNamesMap();
            List<Warehouse> warehouses = warehouseDAO.getAllWarehouses();

            request.setAttribute("deliveryOrder", deliveryOrder);
            request.setAttribute("orderDetails", details);
            request.setAttribute("supplierNames", supplierNames);
            request.setAttribute("userNames", userNames);
            request.setAttribute("warehouses", warehouses);

            request.getRequestDispatcher("/view/delivery/deliveryOrderDetails.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid delivery order ID format.");
            response.sendRedirect(request.getContextPath() + "/deliveryOrders");
        }
    }

    private void deleteDeliveryOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String deliveryOrderId_raw = request.getParameter("deliveryOrderId");
        int deliveryOrderId;

        try {
            deliveryOrderId = Integer.parseInt(deliveryOrderId_raw);
            boolean success = deliveryOrderDAO.softDeleteDeliveryOrder(deliveryOrderId);
            if (success) {
                request.getSession().setAttribute("deleteMessage", "Delivery Order " + deliveryOrderId + " has been successfully deleted.");
                request.getSession().setAttribute("deleteStatus", "success");
            } else {
                request.getSession().setAttribute("deleteMessage", "Failed to delete Delivery Order " + deliveryOrderId + ".");
                request.getSession().setAttribute("deleteStatus", "error");
            }

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("deleteMessage", "Invalid delivery order ID format.");
            request.getSession().setAttribute("deleteStatus", "error");
        }
        response.sendRedirect(request.getContextPath() + "/deliveryOrders");
    }

}
