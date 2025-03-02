/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.PurchaseOrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import model.PurchaseOrder;

/**
 *
 * @author Admin
 */
public class UpdatePurchaseOrderServlet extends HttpServlet {
   

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        PurchaseOrderDAO dao = new PurchaseOrderDAO();
        PurchaseOrder po = dao.getPurchaseOrderById(id);

        request.setAttribute("purchaseOrder", po);
        request.getRequestDispatcher("view/PurchaseOrder/updatePurchaseOrder.jsp").forward(request, response);
    
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
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

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
