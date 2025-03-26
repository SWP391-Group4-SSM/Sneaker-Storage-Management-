package controller.user;

import dal.UserDAO;
import model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class ListUsersServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if ("logout".equals(request.getParameter("action"))) {
            request.getSession().invalidate();
            response.sendRedirect("http://localhost:9999/SSM/login");
            return;
        }

        UserDAO userDAO = new UserDAO();
        
        String searchUsername = request.getParameter("searchUsername");
        String searchRole = request.getParameter("searchRole");

        int page = 1;
        int pageSize = 10;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
            // Mặc định là trang 1 nếu không có tham số trang
        }

        List<User> listUsers;
        
        if ((searchUsername != null && !searchUsername.isEmpty()) || (searchRole != null && !searchRole.isEmpty())) {
            listUsers = userDAO.searchUsers(searchUsername, searchRole, page, pageSize);
        } else {
            listUsers = userDAO.getAll(page, pageSize);
        }

        request.setAttribute("data", listUsers);
        request.setAttribute("searchUsername", searchUsername);
        request.setAttribute("searchRole", searchRole);
        request.setAttribute("currentPage", page);
        request.getRequestDispatcher("view/user/listUsers.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}