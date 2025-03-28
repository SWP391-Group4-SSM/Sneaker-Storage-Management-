package controller.supplier;

import dal.SupplierDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class DeleteSupplierServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int supplierID = Integer.parseInt(request.getParameter("supplierID"));
        SupplierDAO supplierDAO = new SupplierDAO();
        supplierDAO.deleteSupplier(supplierID);
        response.sendRedirect("listsuppliers");
    }
}