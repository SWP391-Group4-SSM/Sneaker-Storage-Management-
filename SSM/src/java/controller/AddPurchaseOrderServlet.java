package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import dal.PurchaseOrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import model.PurchaseOrder;

/**
 *
 * @author Admin
 */
public class AddPurchaseOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("view/PurchaseOrder/addPurchaseOrder.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
