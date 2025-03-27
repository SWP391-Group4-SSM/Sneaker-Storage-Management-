package controller.delivery;

import dal.*;
import model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CreateDeliveryOrderServlet extends HttpServlet {

    private PurchaseOrderDAO purchaseOrderDAO;
    private DeliveryOrderDAO deliveryOrderDAO;
    private WarehouseDAO warehouseDAO;
    private SupplierDAO supplierDAO;
    private BinDAO binDAO;
    private UserDAO userDAO;
    private StockDAO stockDAO;

    @Override
    public void init() throws ServletException {
        purchaseOrderDAO = new PurchaseOrderDAO();
        deliveryOrderDAO = new DeliveryOrderDAO();
        warehouseDAO = new WarehouseDAO();
        supplierDAO = new SupplierDAO();
        binDAO = new BinDAO();
        userDAO = new UserDAO();
        stockDAO = new StockDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<PurchaseOrder> purchaseOrders = purchaseOrderDAO.getApprovedOrOrderedPOs();
        request.setAttribute("purchaseOrders", purchaseOrders);

        // Initialize the added items map in the session if it doesn't exist
        HttpSession session = request.getSession();
        if (session.getAttribute("addedItems") == null) {
            session.setAttribute("addedItems", new HashMap<Integer, Map<String, Object>>());
        }

        request.getRequestDispatcher("/view/delivery/createDeliveryOrder.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            doGet(request, response);
            return;
        }

        switch (action) {
            case "selectPO":
                handleSelectPurchaseOrder(request, response);
                break;
            case "addMultipleItems":
                handleAddMultipleItems(request, response);
                break;
            case "removeItem":
                handleRemoveItem(request, response);
                break;
            case "createDO":
                handleCreateDeliveryOrder(request, response);
                break;
            case "updateStatus":
                handleUpdateStatus(request, response);
                break;
            default:
                doGet(request, response);
                break;
        }
    }

    private void handleSelectPurchaseOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String purchaseOrderIdStr = request.getParameter("purchaseOrderId");

        if (purchaseOrderIdStr == null || purchaseOrderIdStr.isEmpty()) {
            request.setAttribute("errorMessage", "Please select a Purchase Order.");
            doGet(request, response);
            return;
        }

        try {
            int purchaseOrderId = Integer.parseInt(purchaseOrderIdStr);
            PurchaseOrder selectedPO = purchaseOrderDAO.getPurchaseOrderById(purchaseOrderId);

            if (selectedPO == null) {
                request.setAttribute("errorMessage", "Selected Purchase Order not found.");
                doGet(request, response);
                return;
            }

            // Get PO details
            List<PurchaseOrderDetail> poDetails = purchaseOrderDAO.getPurchaseOrderDetails(purchaseOrderId);

            // Get temp bins for the warehouse
            List<Bin> tempBins = binDAO.getTemporaryBinsbyName(selectedPO.getWarehouseId());

            // Get warehouse and supplier names
            String warehouseName = warehouseDAO.getWarehouseById(selectedPO.getWarehouseId()).getName();

            // Get supplier name safely
            String supplierName = "Unknown Supplier";
            try {
                Supplier supplier = supplierDAO.getSupplierById(selectedPO.getSupplierId());
                if (supplier != null) {
                    supplierName = supplier.getSupplierName();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            // Set attributes
            request.setAttribute("selectedPO", selectedPO);
            request.setAttribute("poDetails", poDetails);
            request.setAttribute("tempBins", tempBins);
            request.setAttribute("warehouseName", warehouseName);
            request.setAttribute("supplierName", supplierName);

            // Get all purchase orders for the dropdown
            List<PurchaseOrder> purchaseOrders = purchaseOrderDAO.getApprovedOrOrderedPOs();
            request.setAttribute("purchaseOrders", purchaseOrders);

            // Get added items from session
            HttpSession session = request.getSession();
            Map<Integer, Map<String, Object>> addedItems
                    = (Map<Integer, Map<String, Object>>) session.getAttribute("addedItems");

            if (addedItems == null) {
                addedItems = new HashMap<>();
                session.setAttribute("addedItems", addedItems);
            }

            request.setAttribute("addedItems", addedItems);

            request.getRequestDispatcher("/view/delivery/createDeliveryOrder.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Purchase Order ID format.");
            doGet(request, response);
        } catch (Exception e) {
            // Catch any other exceptions
            request.setAttribute("errorMessage", "Error while processing request: " + e.getMessage());
            doGet(request, response);
        }
    }

    private void handleAddMultipleItems(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String purchaseOrderIdStr = request.getParameter("purchaseOrderId");
        String[] selectedItems = request.getParameterValues("selectedItems");

        if (purchaseOrderIdStr == null || selectedItems == null || selectedItems.length == 0) {
            request.setAttribute("errorMessage", "No items selected.");
            handleSelectPurchaseOrder(request, response);
            return;
        }

        try {
            int purchaseOrderId = Integer.parseInt(purchaseOrderIdStr);

            // Get the PO details to check max quantities
            List<PurchaseOrderDetail> poDetails = purchaseOrderDAO.getPurchaseOrderDetails(purchaseOrderId);
            Map<Integer, PurchaseOrderDetail> poDetailsMap = new HashMap<>();
            for (PurchaseOrderDetail detail : poDetails) {
                poDetailsMap.put(detail.getProductDetailId(), detail);
            }

            // Add items to session
            HttpSession session = request.getSession();
            Map<Integer, Map<String, Object>> addedItems
                    = (Map<Integer, Map<String, Object>>) session.getAttribute("addedItems");

            if (addedItems == null) {
                addedItems = new HashMap<>();
            }

            int successCount = 0;
            StringBuilder errorMessages = new StringBuilder();

            // Process each selected item
            for (String productDetailIdStr : selectedItems) {
                try {
                    int productDetailId = Integer.parseInt(productDetailIdStr);
                    String quantityStr = request.getParameter("quantity_" + productDetailId);
                    String binIdStr = request.getParameter("bin_" + productDetailId);

                    if (quantityStr == null || binIdStr == null) {
                        errorMessages.append("Missing data for product ").append(productDetailId).append(". ");
                        continue;
                    }

                    int quantity = Integer.parseInt(quantityStr);
                    int binId = Integer.parseInt(binIdStr);

                    PurchaseOrderDetail detail = poDetailsMap.get(productDetailId);
                    if (detail == null) {
                        errorMessages.append("Product ").append(productDetailId).append(" not found in purchase order. ");
                        continue;
                    }

                    // Validate quantity
                    if (quantity <= 0) {
                        errorMessages.append("Invalid quantity for product ").append(productDetailId).append(". ");
                        continue;
                    }

                    if (quantity > detail.getQuantityOrdered()) {
                        errorMessages.append("Quantity exceeds ordered amount for product ").append(productDetailId).append(". ");
                        continue;
                    }

                    // Check if product already added
                    if (addedItems.containsKey(productDetailId)) {
                        errorMessages.append("Product ").append(productDetailId).append(" already added. ");
                        continue;
                    }

                    // Add the new item
                    Map<String, Object> itemDetails = new HashMap<>();
                    itemDetails.put("quantity", quantity);
                    itemDetails.put("binId", binId);
                    addedItems.put(productDetailId, itemDetails);
                    successCount++;

                } catch (NumberFormatException e) {
                    errorMessages.append("Invalid input format for product ").append(productDetailIdStr).append(". ");
                }
            }

            // Update the session
            session.setAttribute("addedItems", addedItems);

            // Set appropriate messages
            if (successCount > 0) {
                request.setAttribute("successMessage", successCount + " item(s) added successfully.");
            }

            if (errorMessages.length() > 0) {
                request.setAttribute("errorMessage", errorMessages.toString());
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid input format.");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error while processing request: " + e.getMessage());
        }

        handleSelectPurchaseOrder(request, response);
    }

    private void handleRemoveItem(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String purchaseOrderIdStr = request.getParameter("purchaseOrderId");
        String productDetailIdStr = request.getParameter("productDetailId");

        if (productDetailIdStr == null) {
            request.setAttribute("errorMessage", "No item specified for removal.");
            handleSelectPurchaseOrder(request, response);
            return;
        }

        try {
            int productDetailId = Integer.parseInt(productDetailIdStr);

            // Remove item from session
            HttpSession session = request.getSession();
            Map<Integer, Map<String, Object>> addedItems
                    = (Map<Integer, Map<String, Object>>) session.getAttribute("addedItems");

            if (addedItems != null && addedItems.containsKey(productDetailId)) {
                addedItems.remove(productDetailId);
                session.setAttribute("addedItems", addedItems);
                request.setAttribute("successMessage", "Item removed successfully.");
            } else {
                request.setAttribute("errorMessage", "Item not found in added items.");
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid input format.");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error while processing request: " + e.getMessage());
        }

        handleSelectPurchaseOrder(request, response);
    }

    private void handleCreateDeliveryOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get Purchase Order ID from request
        String purchaseOrderIdStr = request.getParameter("purchaseOrderId");

        // Debug logging
        System.out.println("[" + LocalDateTime.now() + "] handleCreateDeliveryOrder - PO ID: " + purchaseOrderIdStr);

        if (purchaseOrderIdStr == null || purchaseOrderIdStr.isEmpty()) {
            request.setAttribute("errorMessage", "Purchase Order ID is missing");
            handleSelectPurchaseOrder(request, response);
            return;
        }

        // Use a hardcoded user ID temporarily - replace with session-based approach when login is fixed
        int createdByUserId = 1;
        System.out.println("[" + LocalDateTime.now() + "] Using hardcoded user ID: " + createdByUserId);

        // Get added items from session
        HttpSession session = request.getSession();
        Map<Integer, Map<String, Object>> addedItems
                = (Map<Integer, Map<String, Object>>) session.getAttribute("addedItems");

        if (addedItems == null || addedItems.isEmpty()) {
            System.out.println("[" + LocalDateTime.now() + "] No items found in session");
            request.setAttribute("errorMessage", "No items have been added to this delivery order. Please select at least one item.");
            handleSelectPurchaseOrder(request, response);
            return;
        } else {
            System.out.println("[" + LocalDateTime.now() + "] Found " + addedItems.size() + " items in session");
        }

        try {
            int purchaseOrderId = Integer.parseInt(purchaseOrderIdStr);
            System.out.println("[" + LocalDateTime.now() + "] Parsed purchaseOrderId: " + purchaseOrderId);

            // Get Purchase Order to get supplier and warehouse info
            PurchaseOrder po = purchaseOrderDAO.getPurchaseOrderById(purchaseOrderId);
            if (po == null) {
                System.out.println("[" + LocalDateTime.now() + "] Purchase order not found: " + purchaseOrderId);
                request.setAttribute("errorMessage", "Purchase order not found.");
                doGet(request, response);
                return;
            }

            // Generate a new delivery order ID
            int newDeliveryOrderId = generateNewDeliveryOrderId();
            System.out.println("[" + LocalDateTime.now() + "] Generated new DO ID: " + newDeliveryOrderId);

            // Create new delivery order - WITHOUT SETTING PURCHASEORDERID
            DeliveryOrder deliveryOrder = new DeliveryOrder();
            deliveryOrder.setDeliveryOrderId(newDeliveryOrderId);
            deliveryOrder.setSupplierId(po.getSupplierId());
            deliveryOrder.setWarehouseId(po.getWarehouseId());
            deliveryOrder.setCreatedByUserId(createdByUserId); // Use hardcoded user ID
            deliveryOrder.setDocumentDate(LocalDateTime.now());
            deliveryOrder.setDocumentStatus("Draft"); // Initial status is Draft
            deliveryOrder.setUpdatedAt(LocalDateTime.now());
            deliveryOrder.setIsDeleted(false);

            // Create the delivery order
            boolean success = deliveryOrderDAO.addDeliveryOrder(deliveryOrder);
            if (!success) {
                System.out.println("[" + LocalDateTime.now() + "] Failed to create DO record in database");
                request.setAttribute("errorMessage", "Failed to create delivery order in the database.");
                handleSelectPurchaseOrder(request, response);
                return;
            }

            System.out.println("[" + LocalDateTime.now() + "] Successfully created DO header record");

            // Create delivery order details
            int detailId = 1;
            for (Map.Entry<Integer, Map<String, Object>> entry : addedItems.entrySet()) {
                int productDetailId = entry.getKey();
                Map<String, Object> itemDetails = entry.getValue();
                int quantity = (int) itemDetails.get("quantity");

                DeliveryOrderDetail detail = new DeliveryOrderDetail();
                detail.setDeliveryOrderDetailId(newDeliveryOrderId * 100 + detailId); // Generate a unique ID
                detail.setDeliveryOrderId(newDeliveryOrderId);
                detail.setProductDetailId(productDetailId);
                detail.setQuantityOrdered(quantity);
                detail.setCreatedAt(LocalDateTime.now());
                detail.setUpdatedAt(LocalDateTime.now());

                success = deliveryOrderDAO.addDeliveryOrderDetail(detail);
                if (!success) {
                    System.out.println("[" + LocalDateTime.now() + "] Failed to add detail #" + detailId + " for product " + productDetailId);
                    request.setAttribute("errorMessage", "Failed to add item #" + detailId + " to delivery order.");
                    handleSelectPurchaseOrder(request, response);
                    return;
                }

                System.out.println("[" + LocalDateTime.now() + "] Added detail #" + detailId + " for product " + productDetailId);
                detailId++;
            }

            // Store bin assignments for later use when status changes to GoodsReceived
            session.setAttribute("doItemBins_" + newDeliveryOrderId, addedItems);
            System.out.println("[" + LocalDateTime.now() + "] Stored bin assignments in session with key: doItemBins_" + newDeliveryOrderId);

            // Clear the addedItems from session
            session.removeAttribute("addedItems");

            // Success message
            request.getSession().setAttribute("successMessage", "Delivery Order #" + newDeliveryOrderId + " created successfully.");

            // Redirect to delivery order details page
            System.out.println("[" + LocalDateTime.now() + "] Redirecting to delivery order details page");
            response.sendRedirect(request.getContextPath() + "/deliveryOrders?action=details&deliveryOrderId=" + newDeliveryOrderId);

        } catch (NumberFormatException e) {
            System.out.println("[" + LocalDateTime.now() + "] Number format exception: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Invalid Purchase Order ID format: " + e.getMessage());
            handleSelectPurchaseOrder(request, response);
        } catch (Exception e) {
            System.out.println("[" + LocalDateTime.now() + "] General exception: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error creating delivery order: " + e.getMessage());
            handleSelectPurchaseOrder(request, response);
        }
    }

    private void handleUpdateStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String deliveryOrderIdStr = request.getParameter("deliveryOrderId");
        String status = request.getParameter("status");

        System.out.println("[" + LocalDateTime.now() + "] handleUpdateStatus - DO ID: " + deliveryOrderIdStr + ", Status: " + status);

        if (deliveryOrderIdStr == null || status == null) {
            System.out.println("[" + LocalDateTime.now() + "] Missing required parameters for status update");
            request.setAttribute("errorMessage", "Missing required parameters for status update.");
            response.sendRedirect(request.getContextPath() + "/deliveryOrders");
            return;
        }

        try {
            int deliveryOrderId = Integer.parseInt(deliveryOrderIdStr);

            DeliveryOrder deliveryOrder = deliveryOrderDAO.getDeliveryOrderById(deliveryOrderId);
            if (deliveryOrder == null) {
                System.out.println("[" + LocalDateTime.now() + "] Delivery order not found: " + deliveryOrderId);
                request.setAttribute("errorMessage", "Delivery order not found.");
                response.sendRedirect(request.getContextPath() + "/deliveryOrders");
                return;
            }

            // If updating to GoodsReceived, create stock records
            if ("GoodsReceived".equals(status) && !"GoodsReceived".equals(deliveryOrder.getDocumentStatus())) {
                HttpSession session = request.getSession();
                Map<Integer, Map<String, Object>> itemBins
                        = (Map<Integer, Map<String, Object>>) session.getAttribute("doItemBins_" + deliveryOrderId);

                if (itemBins == null || itemBins.isEmpty()) {
                    System.out.println("[" + LocalDateTime.now() + "] Bin assignments not found for DO: " + deliveryOrderId);
                    request.setAttribute("errorMessage", "Bin assignments not found. Cannot update status to GoodsReceived.");
                    response.sendRedirect(request.getContextPath() + "/deliveryOrders?action=details&deliveryOrderId=" + deliveryOrderId);
                    return;
                }

                System.out.println("[" + LocalDateTime.now() + "] Processing bin assignments for " + itemBins.size() + " items");

                List<DeliveryOrderDetail> details = deliveryOrderDAO.getDeliveryOrderDetailsByOrderId(deliveryOrderId);

                // For each detail, create or update stock record
                for (DeliveryOrderDetail detail : details) {
                    int productDetailId = detail.getProductDetailId();
                    int quantity = detail.getQuantityOrdered();

                    Map<String, Object> itemDetails = itemBins.get(productDetailId);
                    if (itemDetails == null) {
                        System.out.println("[" + LocalDateTime.now() + "] Missing bin assignment for product: " + productDetailId);
                        request.setAttribute("errorMessage", "Missing bin assignment for product " + productDetailId);
                        response.sendRedirect(request.getContextPath() + "/deliveryOrders?action=details&deliveryOrderId=" + deliveryOrderId);
                        return;
                    }

                    int binId = (int) itemDetails.get("binId");

                    // Check if stock record exists
                    Stock existingStock = stockDAO.getStockByProductAndBin(productDetailId, binId);

                    if (existingStock != null) {
                        // Update existing stock
                        int newQuantity = existingStock.getQuantity() + quantity;
                        existingStock.setQuantity(newQuantity);
                        existingStock.setLastUpdated(LocalDateTime.now());
                        stockDAO.updateStock(existingStock);
                        System.out.println("[" + LocalDateTime.now() + "] Updated existing stock for product " + productDetailId + " in bin " + binId + " to " + newQuantity);
                    } else {
                        // Create new stock record
                        Stock newStock = new Stock();
                        // Get the next available StockID
                        List<Stock> allStocks = stockDAO.getAllStocks();
                        int maxId = 0;
                        for (Stock stock : allStocks) {
                            if (stock.getStockId() > maxId) {
                                maxId = stock.getStockId();
                            }
                        }

                        newStock.setStockId(maxId + 1);
                        newStock.setProductDetailId(productDetailId);
                        newStock.setWarehouseId(deliveryOrder.getWarehouseId());
                        newStock.setBinId(binId);
                        newStock.setQuantity(quantity);
                        newStock.setLastUpdated(LocalDateTime.now());
                        stockDAO.addStock(newStock);
                        System.out.println("[" + LocalDateTime.now() + "] Created new stock record " + (maxId + 1) + " for product " + productDetailId + " in bin " + binId);
                    }
                }

                // Clean up session once processing is complete
                session.removeAttribute("doItemBins_" + deliveryOrderId);
                System.out.println("[" + LocalDateTime.now() + "] Removed bin assignments from session");
            }

            // Update delivery order status
            deliveryOrder.setDocumentStatus(status);
            deliveryOrder.setUpdatedAt(LocalDateTime.now());
            deliveryOrderDAO.updateDeliveryOrder(deliveryOrder);
            System.out.println("[" + LocalDateTime.now() + "] Updated DO " + deliveryOrderId + " status to " + status);

            request.getSession().setAttribute("successMessage", "Delivery Order #" + deliveryOrderId + " status updated to " + status);
            response.sendRedirect(request.getContextPath() + "/deliveryOrders?action=details&deliveryOrderId=" + deliveryOrderId);

        } catch (NumberFormatException e) {
            System.out.println("[" + LocalDateTime.now() + "] Number format exception: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Invalid Delivery Order ID format: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/deliveryOrders");
        } catch (Exception e) {
            System.out.println("[" + LocalDateTime.now() + "] General exception: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error while updating status: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/deliveryOrders");
        }
    }

    private int generateNewDeliveryOrderId() {
        // Get all delivery orders and add 1 to the highest ID
        List<DeliveryOrder> allOrders = deliveryOrderDAO.getAllDeliveryOrders();
        int maxId = 0;
        for (DeliveryOrder order : allOrders) {
            if (order.getDeliveryOrderId() > maxId) {
                maxId = order.getDeliveryOrderId();
            }
        }
        return maxId + 1;
    }
}
