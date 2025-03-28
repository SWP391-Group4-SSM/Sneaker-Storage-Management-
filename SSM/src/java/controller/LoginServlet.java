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
        // Forward request to login.jsp
        request.getRequestDispatcher("view/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Kiểm tra thông tin đăng nhập
        User user = userDAO.getUserByUsernameAndPassword(username, password);

        if (user != null) {
            // Lưu thông tin người dùng vào session
            HttpSession session = request.getSession();
            session.setAttribute("loggedUser", user);
            session.setAttribute("userID", user.getUserID());

            // Chuyển hướng dựa trên role
            String role = user.getRole();
            switch (role) {
                case "Admin":
                    response.sendRedirect(request.getContextPath() + "/listusers");
                    break;
                case "Supervisor":
                    response.sendRedirect(request.getContextPath() + "/listsuppliers");
                    break;
                case "Staff":
                    response.sendRedirect(request.getContextPath() + "/listbins");
                    break;
                default:
                    // Nếu không phải Admin, Supervisor, hoặc Staff, chuyển đến trang chính
                    response.sendRedirect("home.jsp");
                    break;
            }
        } else {
            // Nếu đăng nhập thất bại, quay lại trang login với thông báo lỗi
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
        }
    }
}