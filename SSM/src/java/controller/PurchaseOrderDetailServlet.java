/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.PurchaseOrderDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.PurchaseOrderDetail;

/**
 *
 * @author Admin
 */
public class PurchaseOrderDetailServlet extends HttpServlet {
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int purchaseOrderId = Integer.parseInt(request.getParameter("poId"));

        PurchaseOrderDetailDAO dao = new PurchaseOrderDetailDAO();
        List<PurchaseOrderDetail> details = dao.getPurchaseOrderDetailsByOrderId(purchaseOrderId);

        request.setAttribute("purchaseOrderId", purchaseOrderId);
        request.setAttribute("details", details);
        request.getRequestDispatcher("view/PurchaseOrder/purchaseOrderDetail.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
