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
    
    int page = 1;
    int pageSize = 10;

    if (request.getParameter("page") != null) {
        page = Integer.parseInt(request.getParameter("page"));
    }

    String searchKeyword = request.getParameter("search");
    String warehouseFilter = request.getParameter("warehouse");

    // Lấy toàn bộ danh sách để xử lý lọc
    List<Stock> stocks = stDAO.getAllStocks();
    List<Bin> bins = binDAO.getAllBins();
    List<Product> products = proDAO.getAllProductsInData();
    List<ProductDetail> productDetails = prdDAO.getAllProductDetailsInData();
    List<Warehouse> warehouses = wDAO.getAllWarehouses();

    // Lọc theo tìm kiếm
    if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
        stocks.removeIf(stock -> {
            String productName = "Không xác định";
            for (ProductDetail pd : productDetails) {
                if (pd.getProductDetailId() == stock.getProductDetailID()) {
                    for (Product pr : products) {
                        if (pr.getProductId() == pd.getProductId()) {
                            productName = pr.getName();
                            break;
                        }
                    }
                }
            }
            return !productName.toLowerCase().contains(searchKeyword.toLowerCase());
        });
    }

    // Lọc theo kho hàng
    if (warehouseFilter != null && !warehouseFilter.isEmpty()) {
        int warehouseId = Integer.parseInt(warehouseFilter);
        stocks.removeIf(stock -> stock.getWarehouseID() != warehouseId);
    }

    // Cập nhật totalRecords và totalPages sau khi lọc
    int totalRecords = stocks.size();
int totalPages = (totalRecords + pageSize - 1) / pageSize; // Tính tổng số trang
page = Math.max(1, Math.min(page, totalPages)); // Đảm bảo page không vượt giới hạn


    // Lấy danh sách theo trang sau khi lọc
    int fromIndex = (page - 1) * pageSize;
    int toIndex = Math.min(fromIndex + pageSize, stocks.size());
    List<Stock> paginatedStocks = stocks.subList(fromIndex, toIndex);

    request.setAttribute("stocks", paginatedStocks);
    request.setAttribute("bins", bins);
    request.setAttribute("products", products);
    request.setAttribute("productDetails", productDetails);
    request.setAttribute("warehouses", warehouses);
    request.setAttribute("currentPage", page);
    request.setAttribute("totalPages", totalPages);
    request.setAttribute("searchKeyword", searchKeyword);
    request.setAttribute("warehouseFilter", warehouseFilter);

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
