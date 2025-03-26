package controller;

import dal.StockDAO;
import dal.WarehouseDAO;
import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Stock;
import model.User;
import model.Warehouse;

public class DashboardServlet extends HttpServlet {

    private WarehouseDAO warehouseDAO = new WarehouseDAO();
    private StockDAO stockDAO = new StockDAO();
    private UserDAO UserDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String role = user.getRole();

       try { 
            if ("Supervisor".equals(role)) {
                List<Warehouse> warehouses = warehouseDAO.getAllWarehouses();
                request.setAttribute("warehouses", warehouses);
                request.getRequestDispatcher("view/supervisorDashboard.jsp").forward(request, response);
            } else if ("Manager".equals(role)) {
                List<Warehouse> assignedWarehouses = warehouseDAO.getWarehousesForManager(user.getUserID());
                request.setAttribute("warehouses", assignedWarehouses);
                request.getRequestDispatcher("view/managerDashboard.jsp").forward(request, response);
            } else if ("Staff".equals(role)) {
                List<Stock> stockItems = stockDAO.getStockForStaff(user.getUserID());
                request.setAttribute("stock", stockItems);
                request.getRequestDispatcher("view/staffDashboard.jsp").forward(request, response);
            } else {
                // If role is invalid or not recognized, redirect to login
                response.sendRedirect("login");
            }
        } catch (Exception e) {
            
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error occurred: " + e.getMessage());
            request.getRequestDispatcher("view/error.jsp").forward(request, response);
        }
    }
}
