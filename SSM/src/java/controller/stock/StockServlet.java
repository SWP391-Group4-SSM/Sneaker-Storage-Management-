/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.stock;

import dal.BinDAO;
import dal.ProductDAO;
import dal.ProductDetailDAO;
import dal.StockDAO;
import dal.WarehouseDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Bin;
import model.Product;
import model.ProductDetail;
import model.Stock;
import model.Warehouse;

public class StockServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        StockDAO stDAO = new StockDAO();
        BinDAO binDAO = new BinDAO();
        ProductDAO proDAO = new ProductDAO();
        ProductDetailDAO prdDAO = new ProductDetailDAO();
        WarehouseDAO wDAO = new WarehouseDAO();
        
        List<Stock> stocks = stDAO.getAllStocks();
        List<Bin> bins = binDAO.getAllBins();
        List<Product> products = proDAO.getAllProductsInData();
        List<ProductDetail> productDetails = prdDAO.getAllProductDetailsInData();
        List<Warehouse> warehouses = wDAO.getAllWarehouses();
        
        request.setAttribute("stocks", stocks);
        request.setAttribute("bins", bins);
        request.setAttribute("products", products);
        request.setAttribute("productDetails", productDetails);
        request.setAttribute("warehouses", warehouses);
        request.getRequestDispatcher("view/Stock/stock.jsp").forward(request, response);
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
