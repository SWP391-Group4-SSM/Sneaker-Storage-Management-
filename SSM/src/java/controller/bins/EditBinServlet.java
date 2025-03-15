package controller.bins;

import dal.BinDAO;
import model.Bin;
import java.io.IOException;
import java.sql.Timestamp;
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
        
        if (bin != null) {
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

        // Tạo Bin mới với thông tin đã cập nhật
        Bin updatedBin = new Bin(binID, sectionID, binName, capacity, description, new Timestamp(System.currentTimeMillis()), false);

        binDAO.updateBin(updatedBin);

        // Chuyển hướng đến danh sách bins
        response.sendRedirect("listbins");
    }
}