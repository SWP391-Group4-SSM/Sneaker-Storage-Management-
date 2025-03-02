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

/**
 *
 * @author Admin
 */
public class DeletePurchaseOrderServlet extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int purchaseOrderId = Integer.parseInt(request.getParameter("id"));
        PurchaseOrderDAO poDAO = new PurchaseOrderDAO();

        if (poDAO.deletePurchaseOrder(purchaseOrderId)) {
            response.sendRedirect("purchaseOrder");
        } else {
            request.setAttribute("errorMessage", "Xóa đơn hàng thất bại.");
            request.getRequestDispatcher("view/PurchaseOrder/purchaseOrderList.jsp").forward(request, response);
        }
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
