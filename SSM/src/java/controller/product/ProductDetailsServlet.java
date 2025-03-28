/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.product;

import dal.ProductDAO;
import dal.ProductDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Product;
import model.ProductDetail;

/**
 *
 * @author Admin
 */
public class ProductDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        ProductDetailDAO dao = new ProductDetailDAO();
        if ("add".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("proId"));
            request.setAttribute("productId", productId);
            request.getRequestDispatcher("view/Product/addProductDetail.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            int proId = Integer.parseInt(request.getParameter("proId"));
            if (dao.deleteProductDetail(id)) {
                response.sendRedirect("productDetails?proId=" + proId);
            } else {
                request.setAttribute("errorMessage", "Xóa đơn hàng thất bại.");
                request.getRequestDispatcher("view/Product/productList.jsp").forward(request, response);
            }
        } else {
            ProductDAO proDAO = new ProductDAO();
            List<Product> proList = proDAO.getAllProductsInData();
            ProductDetailDAO prd = new ProductDetailDAO();
            int proId = Integer.parseInt(request.getParameter("proId"));
            List<ProductDetail> prdList = prd.getProductDetailByProId(proId);
            request.setAttribute("productId", proId);
            request.setAttribute("prdList", prdList);
            request.setAttribute("proList", proList);
            request.getRequestDispatcher("view/Product/productDetail.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            int ProductDetailID = Integer.parseInt(request.getParameter("ProductDetailID"));
            int proId = Integer.parseInt(request.getParameter("proId"));
            int Size = Integer.parseInt(request.getParameter("Size"));
            String Color = request.getParameter("Color");
            String ImageURL = request.getParameter("ImageURL");
            String Material = request.getParameter("Material");
            ProductDetailDAO dao = new ProductDetailDAO();

            if (dao.isProductDetailIdExists(ProductDetailID)) {
                request.setAttribute("errorMessage", "ID chi tiết sản phẩm đã tồn tại! Vui lòng nhập ID khác.");
              
                request.getRequestDispatcher("view/Product/addProductDetail.jsp").forward(request, response);
                return;
            }

            ProductDetail prod = new ProductDetail();
            prod.setProductDetailId(ProductDetailID);
            prod.setProductId(proId);
            prod.setSize(Size);
            prod.setColor(Color);
            prod.setImageUrl(ImageURL);
            prod.setMaterial(Material);
            
            boolean success = dao.addProductDetail(prod);
            if (success) {
                response.sendRedirect("productDetails?proId=" + proId);
            } else {
                request.setAttribute("errorMessage", "Thêm đơn hàng thất bại!");
                request.getRequestDispatcher("view/Product/addProductDetail.jsp").forward(request, response);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
