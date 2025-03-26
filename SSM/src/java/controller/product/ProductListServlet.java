/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.product;

import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.List;
import model.Product;

/**
 *
 * @author Admin
 */
public class ProductListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        ProductDAO dao = new ProductDAO();
        if ("add".equals(action)) {
            request.getRequestDispatcher("view/Product/addProduct.jsp").forward(request, response);
        } else {
            List<Product> productList = dao.getAllProducts();
            request.setAttribute("productList", productList);
            request.getRequestDispatcher("view/Product/productList.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        ProductDAO dao = new ProductDAO();
        if ("add".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String sku = request.getParameter("sku");
            BigDecimal price = new BigDecimal(request.getParameter("price"));

            Product pr = new Product();
            pr.setProductId(productId);
            pr.setName(name);
            pr.setDescription(description);
            pr.setSku(sku);
            pr.setPrice(price);

            boolean success = dao.addProduct(pr);
            if (success) {
                response.sendRedirect("productList");
            } else {
                request.setAttribute("errorMessage", "Thêm đơn hàng thất bại!");
                request.getRequestDispatcher("view/Product/addProduct.jsp").forward(request, response);
            }
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
