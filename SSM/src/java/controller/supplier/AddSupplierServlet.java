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


public class AddSupplierServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/view/supplier/addSupplier.jsp").forward(request, response);
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

            // Kiểm tra trùng lặp supplierID
            if (supplierDAO.isSupplierIdExist(supplierID)) {
                errors.put("supplierID", "ID nhà cung cấp đã tồn tại!");
            }

            // Kiểm tra dữ liệu đầu vào
            if (supplierName == null || supplierName.trim().isEmpty()) {
                errors.put("supplierName", "Tên nhà cung cấp không được để trống!");
            }

            if (!errors.isEmpty()) {
                request.setAttribute("errors", errors);
                request.getRequestDispatcher("/view/supplier/addSupplier.jsp").forward(request, response);
                return;
            }

            // Tạo đối tượng Supplier
            Supplier newSupplier = new Supplier(supplierID, supplierName, contactEmail, contactPhone, address, new Timestamp(System.currentTimeMillis()), null, false);

            // Lưu vào database
            boolean success = supplierDAO.addSupplier(newSupplier);

            if (success) {
                // Chuyển hướng về danh sách suppliers với thông báo thành công
                request.setAttribute("message", "Thêm nhà cung cấp thành công!");
                response.sendRedirect("listsuppliers");
            } else {
                errors.put("general", "Không thể thêm nhà cung cấp. Vui lòng thử lại!");
                request.setAttribute("errors", errors);
                request.getRequestDispatcher("/view/supplier/addSupplier.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            errors.put("general", "SupplierID phải là số nguyên hợp lệ!");
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/view/supplier/addSupplier.jsp").forward(request, response);
        }
    }
}