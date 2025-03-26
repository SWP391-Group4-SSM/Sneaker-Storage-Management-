package controller.bins;

import dal.BinDAO;
import dal.WarehouseSectionDAO;
import model.Bin;
import model.WarehouseSection;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AddBinServlet", urlPatterns = {"/addbin"})
public class AddBinServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        WarehouseSectionDAO sectionDAO = new WarehouseSectionDAO();
        List<WarehouseSection> sections = sectionDAO.getAllSections();
        request.setAttribute("sections", sections);
        request.getRequestDispatcher("/view/bins/addBin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Map<String, String> errors = new HashMap<>();

        try {
            // Lấy dữ liệu từ form
            int binId = Integer.parseInt(request.getParameter("binid"));
            int sectionId = Integer.parseInt(request.getParameter("sectionid"));
            String binName = request.getParameter("binname");
            int capacity = Integer.parseInt(request.getParameter("capacity"));
            String description = request.getParameter("description");

            BinDAO binDAO = new BinDAO();

            // Kiểm tra trùng lặp binID
            if (binDAO.isBinIdExist(binId)) {
                errors.put("binid", "ID bin đã tồn tại!");
            }

            // Kiểm tra dữ liệu đầu vào
            if (binName == null || binName.trim().isEmpty()) {
                errors.put("binname", "Tên bin không được để trống!");
            } else if (binDAO.isBinNameExist(binName)) {
                errors.put("binname", "Tên bin đã tồn tại!");
            }

            if (capacity <= 0) {
                errors.put("capacity", "Dung tích phải là một số dương!");
            }

            if (!errors.isEmpty()) {
                WarehouseSectionDAO sectionDAO = new WarehouseSectionDAO();
                List<WarehouseSection> sections = sectionDAO.getAllSections();
                request.setAttribute("sections", sections);
                request.setAttribute("errors", errors);
                request.getRequestDispatcher("/view/bins/addBin.jsp").forward(request, response);
                return;
            }

            // Tạo đối tượng Bin
            Bin newBin = new Bin(binId, sectionId, binName, capacity, description, new Timestamp(System.currentTimeMillis()), false, false);

            // Lưu vào database
            boolean success = binDAO.addBin(newBin);

            if (success) {
                // Chuyển hướng về danh sách bins với thông báo thành công
                response.sendRedirect(request.getContextPath() + "/listbins");
            } else {
                WarehouseSectionDAO sectionDAO = new WarehouseSectionDAO();
                List<WarehouseSection> sections = sectionDAO.getAllSections();
                request.setAttribute("sections", sections);
                errors.put("general", "Không thể thêm bin. Vui lòng thử lại!");
                request.setAttribute("errors", errors);
                request.getRequestDispatcher("/view/bins/addBin.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            WarehouseSectionDAO sectionDAO = new WarehouseSectionDAO();
            List<WarehouseSection> sections = sectionDAO.getAllSections();
            request.setAttribute("sections", sections);
            errors.put("general", "BinID và SectionID phải là số nguyên hợp lệ!");
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/view/bins/addBin.jsp").forward(request, response);
        }
    }
}