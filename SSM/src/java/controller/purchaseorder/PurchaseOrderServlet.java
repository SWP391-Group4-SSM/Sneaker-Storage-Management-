/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.purchaseorder;

import dal.PurchaseOrderDAO;
import dal.SupplierDAO;
import dal.UserDAO;
import dal.WarehouseDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import model.PurchaseOrder;
import model.Supplier;
import model.User;
import model.Warehouse;

/**
 *
 * @author Admin
 */
public class PurchaseOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        PurchaseOrderDAO poDAO = new PurchaseOrderDAO();

        if ("add".equals(action)) {
            request.getRequestDispatcher("view/PurchaseOrder/addPurchaseOrder.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            PurchaseOrder po = poDAO.getPurchaseOrderById(id);
            request.setAttribute("purchaseOrder", po);
            request.getRequestDispatcher("view/PurchaseOrder/updatePurchaseOrder.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            if (poDAO.deletePurchaseOrder(id)) {
                response.sendRedirect("purchaseOrder");
            } else {
                request.setAttribute("errorMessage", "Xóa đơn hàng thất bại.");
                request.getRequestDispatcher("view/PurchaseOrder/purchaseOrderList.jsp").forward(request, response);
            }
        } else {
            List<PurchaseOrder> poList = poDAO.getAllPurchaseOrders();
            List<Supplier> suppliers = new SupplierDAO().getAllSuppliers();
            List<Warehouse> warList = new WarehouseDAO().getAllWarehouses();
            List<User> userList = new UserDAO().getAll();

            request.setAttribute("purchaseOrders", poList);
            request.setAttribute("suppliers", suppliers);
            request.setAttribute("warList", warList);
            request.setAttribute("userList", userList);
            request.getRequestDispatcher("view/PurchaseOrder/purchaseOrderList.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        PurchaseOrderDAO poDAO = new PurchaseOrderDAO();

        if ("add".equals(action)) {
            int purchaseOrderId = Integer.parseInt(request.getParameter("purchaseOrderId"));
        int supplierId = Integer.parseInt(request.getParameter("supplierId"));
        int warehouseId = Integer.parseInt(request.getParameter("warehouseId"));
        
        BigDecimal totalAmount = new BigDecimal(request.getParameter("totalAmount"));
        String orderDateStr = request.getParameter("orderDate");
        LocalDateTime orderDate = LocalDateTime.parse(orderDateStr);
        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("userID");
      
        PurchaseOrder po = new PurchaseOrder();
        po.setPurchaseOrderId(purchaseOrderId); // Người dùng nhập ID
        po.setSupplierId(supplierId);
        po.setWarehouseId(warehouseId);
        po.setCreatedByUserId(userID);
        po.setTotalAmount(totalAmount);
        po.setOrderDate(orderDate);
        PurchaseOrderDAO dao = new PurchaseOrderDAO();

        if (dao.isPurchaseOrderIdExists(purchaseOrderId)) {
            request.setAttribute("errorMessage", "ID này đã tồn tại! Vui lòng chọn ID khác.");
            request.getRequestDispatcher("view/PurchaseOrder/addPurchaseOrder.jsp").forward(request, response);
            return;
        }

        boolean success = dao.addPurchaseOrder(po);
        if (success) {
            response.sendRedirect("purchaseOrder");
        } else {
            request.setAttribute("errorMessage", "Thêm đơn hàng thất bại!");
            request.getRequestDispatcher("view/PurchaseOrder/addPurchaseOrder.jsp").forward(request, response);
        }
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            int supplierId = Integer.parseInt(request.getParameter("supplierId"));
            int warehouseId = Integer.parseInt(request.getParameter("warehouseId"));
            int createdByUserId = Integer.parseInt(request.getParameter("createdByUserId"));
            BigDecimal totalAmount = new BigDecimal(request.getParameter("totalAmount"));
            String purchaseOrderStatus = request.getParameter("purchaseOrderStatus");

            PurchaseOrder po = new PurchaseOrder();
            po.setPurchaseOrderId(id);
            po.setSupplierId(supplierId);
            po.setWarehouseId(warehouseId);
            po.setCreatedByUserId(createdByUserId);
            po.setTotalAmount(totalAmount);
            po.setPurchaseOrderStatus(purchaseOrderStatus);

            PurchaseOrderDAO dao = new PurchaseOrderDAO();
            dao.updatePurchaseOrder(po);

            response.sendRedirect("purchaseOrder");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
