package controller.bins;

import dal.BinDAO;
import dal.WarehouseSectionDAO;
import dal.StockDAO;
import model.Bin;
import model.WarehouseSection;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "EditBinServlet", urlPatterns = {"/editbin"})
public class EditBinServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int binID = Integer.parseInt(request.getParameter("binID"));
        BinDAO binDAO = new BinDAO();
        
        // Lấy thông tin bin theo binID
        Bin bin = binDAO.getBinById(binID);

        // Lấy danh sách các khu vực kho
        WarehouseSectionDAO sectionDAO = new WarehouseSectionDAO();
        List<WarehouseSection> sections = sectionDAO.getAllSections();
        request.setAttribute("sections", sections);
        
        if (bin != null) {
            if (bin.isLocked()) {
                request.setAttribute("error", "Bin này đang kiểm kho và không thể chỉnh sửa.");
                request.getRequestDispatcher("/listbins").forward(request, response);
                return;
            }
            request.setAttribute("bin", bin);
            request.getRequestDispatcher("/view/bins/editBin.jsp").forward(request, response);
        } else {
            response.sendRedirect("listbins");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int binID = Integer.parseInt(request.getParameter("binID"));
        int sectionID = Integer.parseInt(request.getParameter("sectionID"));
        String binName = request.getParameter("binName");
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        String description = request.getParameter("description");

        // Kiểm tra dữ liệu đầu vào
        if (binName == null || binName.trim().isEmpty()) {
            request.setAttribute("error", "Tên bin không được để trống!");
            request.getRequestDispatcher("/view/bins/editBin.jsp").forward(request, response);
            return;
        }

        BinDAO binDAO = new BinDAO();
        Bin existingBin = binDAO.getBinById(binID);

        if (existingBin.isLocked()) {
            request.setAttribute("error", "Bin này đang kiểm kho và không thể chỉnh sửa.");
            request.getRequestDispatcher("/listbins").forward(request, response);
            return;
        }

        // Kiểm tra trùng tên bin
        if (binDAO.isBinNameExist(binName) && !existingBin.getBinName().equals(binName)) {
            request.setAttribute("error", "Tên bin đã tồn tại!");
            request.getRequestDispatcher("/view/bins/editBin.jsp").forward(request, response);
            return;
        }

        StockDAO stockDAO = new StockDAO();
        int totalQuantity = stockDAO.getTotalQuantityForBin(binID);

        if (capacity < totalQuantity) {
            request.setAttribute("error", "Dung tích không được nhỏ hơn tổng số lượng hiện tại trong bin!");
            request.getRequestDispatcher("/view/bins/editBin.jsp").forward(request, response);
            return;
        }

        // Tạo Bin mới với thông tin đã cập nhật
        Bin updatedBin = new Bin(binID, sectionID, binName, capacity, description, new Timestamp(System.currentTimeMillis()), false, existingBin.isLocked());

        binDAO.updateBin(updatedBin);

        // Chuyển hướng đến danh sách bins
        response.sendRedirect("listbins");
    }
}