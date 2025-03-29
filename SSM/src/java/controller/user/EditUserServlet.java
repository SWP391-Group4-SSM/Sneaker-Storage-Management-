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
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String numberPhone = request.getParameter("numberPhone");
        String address = request.getParameter("address");

        // Kiểm tra dữ liệu đầu vào
        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Mật khẩu không được để trống!");
            request.getRequestDispatcher("/view/user/editUser.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();

        // Lấy thông tin người dùng hiện tại
        User existingUser = userDAO.getUserById(userID);
        if (existingUser == null) {
            request.setAttribute("error", "Người dùng không tồn tại!");
            request.getRequestDispatcher("/view/user/editUser.jsp").forward(request, response);
            return;
        }

        // Kiểm tra trùng lặp email
        if (userDAO.isEmailExistExcludingUserId(email, userID)) {
            request.setAttribute("error", "Email đã tồn tại!");
            request.getRequestDispatcher("/view/user/editUser.jsp").forward(request, response);
            return;
        }

        // Kiểm tra trùng lặp số điện thoại
        if (userDAO.isNumberPhoneExistExcludingUserId(numberPhone, userID)) {
            request.setAttribute("error", "Số điện thoại đã tồn tại!");
            request.getRequestDispatcher("/view/user/editUser.jsp").forward(request, response);
            return;
        }

        // Cập nhật thông tin người dùng (không thay đổi username)
        existingUser.setPasswordHash(password); // Cập nhật mật khẩu
        existingUser.setRole(role); // Cập nhật vai trò
        existingUser.setName(name);
        existingUser.setEmail(email);
        existingUser.setNumberPhone(numberPhone);
        existingUser.setAddress(address);
        
        boolean success = userDAO.updateUser(existingUser);

        if (success) {
            request.getSession().setAttribute("message", "Cập nhật người dùng thành công!");
        } else {
            request.getSession().setAttribute("error", "Không thể cập nhật người dùng. Vui lòng thử lại!");
        }

        // Chuyển hướng đến danh sách người dùng
        response.sendRedirect("listusers");
    }
}