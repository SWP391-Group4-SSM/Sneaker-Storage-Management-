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
        StockDAO stockDAO = new StockDAO();

        String productName = request.getParameter("searchProductName");
        String warehouseName = request.getParameter("searchWarehouseName");
        String binName = request.getParameter("searchBinName");

        int page = 1;
        int pageSize = 10;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.trim().isEmpty()) {
            try {
                page = Integer.parseInt(pageStr.trim());
            } catch (NumberFormatException e) {
                // Giữ mặc định page = 1
            }
        }

        List<Stock> listStocks;
        if ((productName != null && !productName.trim().isEmpty()) ||
            (warehouseName != null && !warehouseName.trim().isEmpty()) ||
            (binName != null && !binName.trim().isEmpty())) {
            listStocks = stockDAO.searchStocks(productName, warehouseName, binName, page, pageSize);
        } else {
            listStocks = stockDAO.getAll(page, pageSize);
        }

        request.setAttribute("data", listStocks);
        request.setAttribute("searchProductName", productName);
        request.setAttribute("searchWarehouseName", warehouseName);
        request.setAttribute("searchBinName", binName);
        request.setAttribute("currentPage", page);
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
