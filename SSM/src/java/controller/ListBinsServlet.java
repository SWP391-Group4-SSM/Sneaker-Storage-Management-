package controller;

import dal.BinDAO;
import model.Bin;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ListBinsServlet", urlPatterns = {"/listbins"})
public class ListBinsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BinDAO binDAO = new BinDAO();

        String searchBinName = request.getParameter("searchBinName");

        List<Bin> listBins;
        if (searchBinName != null && !searchBinName.isEmpty()) {
            listBins = binDAO.searchBins(searchBinName);
        } else {
            listBins = binDAO.getAll();
        }

        request.setAttribute("data", listBins);
        request.setAttribute("searchBinName", searchBinName);
        request.getRequestDispatcher("view/listbins.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
