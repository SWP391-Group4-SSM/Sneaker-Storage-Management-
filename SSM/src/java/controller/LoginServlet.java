package controller;

import dal.UserDAO;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("view/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userDAO.getUserByUsername(username);
        if (user != null && userDAO.checkPassword(user, password)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            String role = user.getRole();
            if (role.equals("Admin")) {
                response.sendRedirect("listusers");
            } else if (role.equals("Supervisor")) {
                response.sendRedirect("dashboard");
            } else if (role.equals("Manager")) {
                response.sendRedirect("dashboard");
            } else if (role.equals("Staff")) {
                response.sendRedirect("dashboard");
            } else {
                response.sendRedirect("login");
            }
        } else {
            request.setAttribute("error", "Invalid username or password.");
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
        }
    }
}
