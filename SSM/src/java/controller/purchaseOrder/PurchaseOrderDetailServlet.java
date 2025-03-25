/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.purchaseOrder;

import dal.ProductDAO;
import dal.ProductDetailDAO;
import dal.PurchaseOrderDAO;
import dal.PurchaseOrderDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.List;
import model.Product;
import model.ProductDetail;
import model.PurchaseOrder;
import model.PurchaseOrderDetail;

public class PurchaseOrderDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        PurchaseOrderDetailDAO dao = new PurchaseOrderDetailDAO();
        ProductDetailDAO proDAO = new ProductDetailDAO();
        PurchaseOrderDAO poDAO = new PurchaseOrderDAO();
        ProductDAO prDAO = new ProductDAO();
        if ("add".equals(action)) {
            int purchaseOrderId = Integer.parseInt(request.getParameter("poId"));
            List<ProductDetail> productList = proDAO.getAllProductDetails();
            request.setAttribute("productList", productList);
            request.setAttribute("purchaseOrderId", purchaseOrderId);
            request.getRequestDispatcher("view/PurchaseOrder/addPurchaseOrderDetail.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            int purchaseOrderId = Integer.parseInt(request.getParameter("poId"));
            if (dao.deletePurchaseOrderDetail(id)) {
                response.sendRedirect("purchaseOrderDetail?poId=" + purchaseOrderId);
            } else {
                request.setAttribute("errorMessage", "Xóa đơn hàng thất bại.");
                request.getRequestDispatcher("view/PurchaseOrder/purchaseOrderList.jsp").forward(request, response);
            }
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            int purchaseOrderId = Integer.parseInt(request.getParameter("poId"));
            PurchaseOrderDetail pod = dao.getPurchaseOrderDetailById(id);
            request.setAttribute("purchaseOrderId", purchaseOrderId);
            request.setAttribute("purchaseOrderDetail", pod);
            request.getRequestDispatcher("view/PurchaseOrder/updatePurchaseOrderDetail.jsp").forward(request, response);
        } else {
            int purchaseOrderId = Integer.parseInt(request.getParameter("poId"));
            List<PurchaseOrderDetail> podList = dao.getPurchaseOrderDetailsByOrderId(purchaseOrderId);
            List<ProductDetail> prdList = proDAO.getAllProductDetailsInData();
            List<Product> proList = prDAO.getAllProductsInData();
            PurchaseOrder po = poDAO.getPurchaseOrderById(purchaseOrderId);

            request.setAttribute("purchaseOrderId", purchaseOrderId);
            request.setAttribute("prdList", prdList);
            request.setAttribute("proList", proList);
            request.setAttribute("podList", podList);
            request.setAttribute("po", po);
            request.getRequestDispatcher("view/PurchaseOrder/purchaseOrderDetail.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            int purchaseOrderDetailID = Integer.parseInt(request.getParameter("purchaseOrderDetailID"));
            int purchaseOrderID = Integer.parseInt(request.getParameter("poId"));
            int productDetailId = Integer.parseInt(request.getParameter("productDetailId"));
            int quantityOrdered = Integer.parseInt(request.getParameter("quantityOrdered"));
            BigDecimal unitPrice = new BigDecimal(request.getParameter("unitPrice"));
            HttpSession session = request.getSession();
            PurchaseOrderDetail pod = new PurchaseOrderDetail();
            pod.setPurchaseOrderDetailId(purchaseOrderDetailID);
            pod.setPurchaseOrderId(purchaseOrderID);
            pod.setProductDetailId(productDetailId);
            pod.setQuantityOrdered(quantityOrdered);
            pod.setUnitPrice(unitPrice);
            PurchaseOrderDetailDAO dao = new PurchaseOrderDetailDAO();
            
            if (!dao.isPurchaseOrderDetailIdExists(purchaseOrderDetailID)) {
                session.setAttribute("errorMessage", "ID này đã tồn tại! Vui lòng chọn ID khác.");
                response.sendRedirect("purchaseOrderDetail?action=add&poId=" + purchaseOrderID);
                return;
            }

            boolean success = dao.addPurchaseOrderDetail(pod);
            if (success) {
                response.sendRedirect("purchaseOrderDetail?poId=" + purchaseOrderID);
            } else {
                session.setAttribute("errorMessage", "Thêm đơn hàng thất bại!");
                response.sendRedirect("purchaseOrderDetail?action=add&poId=" + purchaseOrderID);
            }
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("purchaseOrderDetailId")); // Lấy ID cần cập nhật
            int quantityOrdered = Integer.parseInt(request.getParameter("quantityOrdered"));
            BigDecimal unitPrice = new BigDecimal(request.getParameter("unitPrice"));
            int purchaseOrderID = Integer.parseInt(request.getParameter("poId"));

            PurchaseOrderDetail pod = new PurchaseOrderDetail();
            pod.setPurchaseOrderDetailId(id);
            pod.setQuantityOrdered(quantityOrdered);
            pod.setUnitPrice(unitPrice);

            PurchaseOrderDetailDAO dao = new PurchaseOrderDetailDAO();
            boolean success = dao.updatePurchaseOrderDetail(pod);

            if (success) {
                response.sendRedirect("purchaseOrderDetail?poId=" + purchaseOrderID);
            } else {
                request.setAttribute("errorMessage", "Cập nhật đơn hàng thất bại!");
                request.getRequestDispatcher("view/PurchaseOrder/updatePurchaseOrderDetail.jsp").forward(request, response);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
