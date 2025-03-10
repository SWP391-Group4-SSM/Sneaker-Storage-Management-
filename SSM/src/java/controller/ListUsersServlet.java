package controller;

import dal.UserDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

@WebServlet(name = "ListUsersServlet", urlPatterns = {"/listusers"})
public class ListUsersServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        
        // Nhận dữ liệu từ form tìm kiếm
        String searchUsername = request.getParameter("searchUsername");
        String searchRole = request.getParameter("searchRole");

        List<User> listUsers;
        
        if ((searchUsername != null && !searchUsername.isEmpty()) || (searchRole != null && !searchRole.isEmpty())) {
            listUsers = userDAO.searchUsers(searchUsername, searchRole); // Lọc kết quả tìm kiếm
        } else {
            listUsers = userDAO.getAll(); // Hiển thị tất cả khi chưa tìm kiếm
        }

        request.setAttribute("data", listUsers);
        request.setAttribute("searchUsername", searchUsername);
        request.setAttribute("searchRole", searchRole);
        request.getRequestDispatcher("view/listusers.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
