package controller.delivery;

import dal.DeliveryOrderDAO;
import dal.PurchaseOrderDAO;
import dal.PurchaseOrderDetailDAO;
import dal.StockDAO;
import model.DeliveryOrder;
import model.DeliveryOrderDetail;
import model.PurchaseOrder;
import model.PurchaseOrderDetail;
import model.Stock;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

public class CreateDeliveryOrderServlet extends HttpServlet {

    private DeliveryOrderDAO deliveryOrderDAO = new DeliveryOrderDAO();
    private PurchaseOrderDAO purchaseOrderDAO = new PurchaseOrderDAO();
    private PurchaseOrderDetailDAO purchaseOrderDetailDAO = new PurchaseOrderDetailDAO();
    private StockDAO stockDAO = new StockDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int purchaseOrderId = Integer.parseInt(request.getParameter("purchaseOrderId"));
        PurchaseOrder purchaseOrder = purchaseOrderDAO.getPurchaseOrderById(purchaseOrderId);

        if (purchaseOrder == null) {
            response.getWriter().write("Purchase Order not found.");
            return;
        }

        // Create Delivery Order
        DeliveryOrder deliveryOrder = new DeliveryOrder();
        deliveryOrder.setWarehouseId(purchaseOrder.getWarehouseId());
        deliveryOrder.setCreatedByUserId(Integer.parseInt(request.getParameter("createdByUserId"))); // Get from session or request
        deliveryOrder.setDocumentDate(LocalDateTime.now());
        deliveryOrder.setDocumentStatus("Processing");
        deliveryOrder.setUpdatedAt(LocalDateTime.now());

        // Generate a new DeliveryOrderID (You may need a better strategy for this)
        int newDeliveryOrderId = (int) (System.currentTimeMillis() / 1000); // Simple generation
        deliveryOrder.setDeliveryOrderId(newDeliveryOrderId);

        if (!deliveryOrderDAO.addDeliveryOrder(deliveryOrder)) {
            response.getWriter().write("Failed to create Delivery Order.");
            return;
        }

        // Create Delivery Order Details and update Stock
        List<PurchaseOrderDetail> purchaseOrderDetails = purchaseOrderDetailDAO.getPurchaseOrderDetailsByOrderId(purchaseOrderId);
        for (PurchaseOrderDetail pod : purchaseOrderDetails) {
            DeliveryOrderDetail dod = new DeliveryOrderDetail();
            dod.setDeliveryOrderId(newDeliveryOrderId);
            dod.setProductDetailId(pod.getProductDetailId());
            dod.setQuantityOrdered(pod.getQuantityOrdered());
            dod.setCreatedAt(LocalDateTime.now());
            dod.setUpdatedAt(LocalDateTime.now());

            // Generate a new DeliveryOrderDetailID (You may need a better strategy)
            int newDeliveryOrderDetailId = (int) (System.currentTimeMillis() / 1000); // Simple generation
            dod.setDeliveryOrderDetailId(newDeliveryOrderDetailId);

            if (!deliveryOrderDAO.addDeliveryOrderDetail(dod)) {
                response.getWriter().write("Failed to add Delivery Order Detail.");
                return;
            }

            // Update Stock (Assuming you have a bin selection logic)
            // You may need to implement a bin selection UI and logic
            int binId = Integer.parseInt(request.getParameter("binId")); // Get binId from request

            Stock existingStock = stockDAO.getStockByProductAndBin(pod.getProductDetailId(), binId);
            if (existingStock != null) {
                existingStock.setQuantity(existingStock.getQuantity() + pod.getQuantityOrdered());
                stockDAO.updateStock(existingStock);
            } else {
                Stock newStock = new Stock();
                newStock.setProductDetailId(pod.getProductDetailId());
                newStock.setWarehouseId(purchaseOrder.getWarehouseId());
                newStock.setBinId(binId);
                newStock.setQuantity(pod.getQuantityOrdered());
                stockDAO.addStock(newStock);
            }
        }

        response.getWriter().write("Delivery Order created successfully.");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<PurchaseOrder> purchaseOrders = purchaseOrderDAO.getApprovedOrOrderedPOs();
        request.setAttribute("purchaseOrders", purchaseOrders);
        request.getRequestDispatcher("/view/delivery/createDeliveryOrder.jsp").forward(request, response);
    }
}
