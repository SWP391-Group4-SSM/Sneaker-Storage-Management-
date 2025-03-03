/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.PurchaseOrderDAO;
import dal.PurchaseOrderDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import model.PurchaseOrder;
import model.PurchaseOrderDetail;

/**
 *
 * @author Admin
 */
public class AddPurchaseOrderDetailServlet extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("view/PurchaseOrder/addPurchaseOrderDetail.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int purchaseOrderID = Integer.parseInt(request.getParameter("purchaseOrderID"));
        int productDetailId = Integer.parseInt(request.getParameter("productDetailId"));
        int quantityOrdered = Integer.parseInt(request.getParameter("quantityOrdered"));
        BigDecimal unitPrice = new BigDecimal(request.getParameter("unitPrice"));
                
        
        PurchaseOrderDetail pod = new PurchaseOrderDetail();
        pod.setProductDetailId(productDetailId);
        pod.setQuantityOrdered(quantityOrdered);
        pod.setUnitPrice(unitPrice);
        pod.setPurchaseOrderId(purchaseOrderID);
        PurchaseOrderDetailDAO dao = new PurchaseOrderDetailDAO();

        if (dao.isPurchaseOrderDetailIdExists(productDetailId)) {
            request.setAttribute("errorMessage", "ID này đã tồn tại! Vui lòng chọn ID khác.");
            request.getRequestDispatcher("view/PurchaseOrder/addPurchaseOrderDetail.jsp").forward(request, response);
            return;
        }

        boolean success = dao.addPurchaseOrderDetail(pod);
        if (success) {
            response.sendRedirect("purchaseOrderDetail");
        } else {
            request.setAttribute("errorMessage", "Thêm đơn hàng thất bại!");
            request.getRequestDispatcher("view/PurchaseOrder/addPurchaseOrderDetail.jsp").forward(request, response);
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
