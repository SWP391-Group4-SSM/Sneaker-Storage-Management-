package controller;

import dal.UserDAO;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "EditUserServlet", urlPatterns = {"/edituser"})
public class EditUserServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userID = Integer.parseInt(request.getParameter("userID"));
        User user = userDAO.getUserById(userID);

        if (user == null) {
            response.sendRedirect("listusers");
            return;
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("view/edituser.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userID = Integer.parseInt(request.getParameter("userID"));
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("error", "Tên đăng nhập không được để trống!");
            request.getRequestDispatcher("view/edituser.jsp").forward(request, response);
            return;
        }

        User existingUser = userDAO.getUserById(userID);
        if (existingUser == null) {
            response.sendRedirect("listusers");
            return;
        }

        if (password == null || password.trim().isEmpty()) {
            password = existingUser.getPasswordHash();
        }

        User updatedUser = new User(userID, username, password, role, existingUser.getCreatedAt());
        userDAO.updateUser(updatedUser);

        response.sendRedirect("listusers");
    }
}
