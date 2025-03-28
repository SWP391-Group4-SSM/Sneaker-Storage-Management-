package controller.supplier;

import dal.SupplierDAO;
import model.Supplier;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class EditSupplierServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int supplierID = Integer.parseInt(request.getParameter("supplierID"));
        SupplierDAO supplierDAO = new SupplierDAO();
        Supplier supplier = supplierDAO.getSupplierById(supplierID);
        
        if (supplier != null) {
            request.setAttribute("supplier", supplier);
            request.getRequestDispatcher("/view/supplier/editSupplier.jsp").forward(request, response);
        } else {
            response.sendRedirect("listsuppliers");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Map<String, String> errors = new HashMap<>();

        try {
            // Lấy dữ liệu từ form
            int supplierID = Integer.parseInt(request.getParameter("supplierID"));
            String supplierName = request.getParameter("supplierName");
            String contactEmail = request.getParameter("contactEmail");
            String contactPhone = request.getParameter("contactPhone");
            String address = request.getParameter("address");

            SupplierDAO supplierDAO = new SupplierDAO();

            // Kiểm tra dữ liệu đầu vào
            if (supplierName == null || supplierName.trim().isEmpty()) {
                errors.put("supplierName", "Tên nhà cung cấp không được để trống!");
            }

            if (!errors.isEmpty()) {
                Supplier supplier = new Supplier(supplierID, supplierName, contactEmail, contactPhone, address, null, null, false);
                request.setAttribute("supplier", supplier);
                request.setAttribute("errors", errors);
                request.getRequestDispatcher("/view/supplier/editSupplier.jsp").forward(request, response);
                return;
            }

            // Cập nhật Supplier
            Supplier updatedSupplier = new Supplier(supplierID, supplierName, contactEmail, contactPhone, address, null, new Timestamp(System.currentTimeMillis()), false);
            supplierDAO.updateSupplier(updatedSupplier);

            // Chuyển hướng về danh sách suppliers với thông báo thành công
            request.setAttribute("message", "Cập nhật nhà cung cấp thành công!");
            response.sendRedirect("listsuppliers");

        } catch (NumberFormatException e) {
            errors.put("general", "SupplierID phải là số nguyên hợp lệ!");
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/view/supplier/editSupplier.jsp").forward(request, response);
        }
    }
}