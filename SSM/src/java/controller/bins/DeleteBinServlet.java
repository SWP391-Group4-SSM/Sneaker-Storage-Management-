package controller.bins;

import dal.BinDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class DeleteBinServlet extends HttpServlet {
    private final BinDAO binDAO = new BinDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int binID = Integer.parseInt(request.getParameter("binID"));
            binDAO.deleteBin(binID); // Đánh dấu bin là "đã xoá"
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        response.sendRedirect("listbins");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}