package controller.supplier;

import dal.SupplierDAO;
import model.Supplier;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class ListSuppliersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if ("logout".equals(request.getParameter("action"))) {
            request.getSession().invalidate();
            response.sendRedirect("http://localhost:9999/SSM/login");
            return;
        }

        String searchSupplierName = request.getParameter("searchSupplierName");
        String searchContactEmail = request.getParameter("searchContactEmail");
        String searchContactPhone = request.getParameter("searchContactPhone");
        int page = 1;
        int pageSize = 10;
        
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        SupplierDAO supplierDAO = new SupplierDAO();
        List<Supplier> suppliers;

        if ((searchSupplierName != null && !searchSupplierName.isEmpty()) || 
            (searchContactEmail != null && !searchContactEmail.isEmpty()) ||
            (searchContactPhone != null && !searchContactPhone.isEmpty())) {
            suppliers = supplierDAO.searchSuppliers(searchSupplierName, searchContactEmail, searchContactPhone, page, pageSize);
        } else {
            suppliers = supplierDAO.getAll(page, pageSize);
        }

        request.setAttribute("data", suppliers);
        request.setAttribute("currentPage", page);
        request.setAttribute("searchSupplierName", searchSupplierName);
        request.setAttribute("searchContactEmail", searchContactEmail);
        request.setAttribute("searchContactPhone", searchContactPhone);
        request.getRequestDispatcher("/view/supplier/listSupplier.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}