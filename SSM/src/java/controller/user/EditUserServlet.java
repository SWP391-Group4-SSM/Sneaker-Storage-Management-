package controller.user;

import dal.UserDAO;
import model.User;
import java.io.IOException;
import java.sql.Timestamp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "EditUserServlet", urlPatterns = {"/edituser"})
public class EditUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userID = Integer.parseInt(request.getParameter("userID"));
        UserDAO userDAO = new UserDAO();
        
        // Lấy thông tin người dùng theo userID
        User user = userDAO.getUserById(userID);
        
        if (user != null) {
            request.setAttribute("user", user);
            request.getRequestDispatcher("/view/user/editUser.jsp").forward(request, response);
        } else {
            response.sendRedirect("listusers");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userID = Integer.parseInt(request.getParameter("userID"));
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Kiểm tra dữ liệu đầu vào
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Tên đăng nhập và mật khẩu không được để trống!");
            request.getRequestDispatcher("/view/user/editUser.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();

        // Kiểm tra trùng lặp username
        User existingUser = userDAO.getUserByUsername(username);
        if (existingUser != null && existingUser.getUserID() != userID) {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
            request.getRequestDispatcher("/view/user/editUser.jsp").forward(request, response);
            return;
        }

        // Tạo User mới với thông tin đã cập nhật
        User updatedUser = new User(userID, username, password, role, new Timestamp(System.currentTimeMillis()), false);

        userDAO.updateUser(updatedUser);

        // Chuyển hướng đến danh sách người dùng
        response.sendRedirect("listusers");
    }
}