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

@WebServlet(name = "AddUserServlet", urlPatterns = {"/adduser"})
public class AddUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/view/user/addUser.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ form
            int userId = Integer.parseInt(request.getParameter("userid"));
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            // Kiểm tra dữ liệu đầu vào
            if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
                request.setAttribute("error", "Tên đăng nhập và mật khẩu không được để trống!");
                request.getRequestDispatcher("/view/user/addUser.jsp").forward(request, response);
                return;
            }

            UserDAO userDAO = new UserDAO();
            
            // Kiểm tra trùng lặp username
            if (userDAO.isUsernameExist(username)) {
                request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
                request.getRequestDispatcher("/view/user/addUser.jsp").forward(request, response);
                return;
            }

            // Tạo đối tượng User
            User newUser = new User(userId, username, password, role, new Timestamp(System.currentTimeMillis()), false);

            // Lưu vào database
            userDAO.addUser(newUser);

            // Chuyển hướng về danh sách người dùng
            response.sendRedirect("listusers");

        } catch (NumberFormatException e) {
            request.setAttribute("error", "UserID phải là số nguyên hợp lệ!");
            request.getRequestDispatcher("/view/user/addUser.jsp").forward(request, response);
        }
    }
}