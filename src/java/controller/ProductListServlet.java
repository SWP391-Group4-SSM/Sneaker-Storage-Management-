/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Product;

/**
 *
 * @author Admin
 */
public class ProductListServlet extends HttpServlet {
    ProductDAO productDAO = new ProductDAO();
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    String action = request.getParameter("action");
    int page = 1;
    int pageSize = 3; // Số sản phẩm trên mỗi trang
    if (request.getParameter("page") != null) {
        page = Integer.parseInt(request.getParameter("page"));
    }

    List<Product> products;
    int totalProducts = productDAO.getTotalProducts();
    int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

    if ("search".equals(action)) {
        String keyword = request.getParameter("keyword");
        products = productDAO.searchProducts(keyword);
    } else if ("filter".equals(action)) {
        double minPrice = Double.parseDouble(request.getParameter("minPrice"));
        double maxPrice = Double.parseDouble(request.getParameter("maxPrice"));
        products = productDAO.filterProductsByPrice(minPrice, maxPrice);
    } else if ("sort".equals(action)) {
        boolean ascending = "asc".equals(request.getParameter("order"));
        products = productDAO.sortProductsByPrice(ascending);
    } else {
        products = productDAO.getProductsByPage(page, pageSize);
    }

    request.setAttribute("products", products);
    request.setAttribute("currentPage", page);
    request.setAttribute("totalPages", totalPages);
    request.getRequestDispatcher("view/products.jsp").forward(request, response);
    } 

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");
            String sku = request.getParameter("sku");
            String imageURL = request.getParameter("imageURL");
            Product product = new Product(name, description, sku, price, imageURL);
            productDAO.addProduct(product);
            response.sendRedirect("productList");
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");
            String sku = request.getParameter("sku");
            String imageURL = request.getParameter("imageURL");
            Product product = new Product(name, description, sku, price, imageURL);
            productDAO.editProduct(product);
            response.sendRedirect("productList");
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            productDAO.deleteProduct(id);
            response.sendRedirect("ProductListServlet");
        } else {
            doGet(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
