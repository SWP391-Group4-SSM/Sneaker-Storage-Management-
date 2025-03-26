package controller.bins;

import dal.BinDAO;
import dal.WarehouseSectionDAO;
import model.Bin;
import model.WarehouseSection;
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
        String searchBinName = request.getParameter("searchBinName");
        int page = 1;
        int pageSize = 10;
        
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        BinDAO binDAO = new BinDAO();
        List<Bin> bins;
        WarehouseSectionDAO sectionDAO = new WarehouseSectionDAO();
        List<WarehouseSection> sections = sectionDAO.getAllSections();

        if (searchBinName != null && !searchBinName.isEmpty()) {
            bins = binDAO.searchBinsByName(searchBinName, page, pageSize);
        } else {
            bins = binDAO.getAll(page, pageSize);
        }

        request.setAttribute("data", bins);
        request.setAttribute("sections", sections);
        request.setAttribute("currentPage", page);
        request.setAttribute("searchBinName", searchBinName);
        request.getRequestDispatcher("/view/bins/listBins.jsp").forward(request, response);
    }
}