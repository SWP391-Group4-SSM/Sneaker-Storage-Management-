package dal;

import model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class UserDAO {
    private Connection connection;

    public UserDAO() {
        DBContext db = new DBContext();
        connection = db.connection;
    }

    // Phương thức để băm mật khẩu
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedPassword = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedPassword) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

    // Lấy danh sách tất cả người dùng với phân trang
    public List<User> getAll(int page, int pageSize) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM Users WHERE isDeleted = 0 ORDER BY userID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, (page - 1) * pageSize);
            stmt.setInt(2, pageSize);
            System.out.println(">>> SQL: " + stmt.toString());
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    User user = new User(
                        rs.getInt("userID"),
                        rs.getString("username"),
                        rs.getString("passwordHash"),
                        rs.getString("role"),
                        rs.getTimestamp("createdAt"),
                        rs.getBoolean("isDeleted"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("numberPhone"),
                        rs.getString("address")
                    );
                    users.add(user);
                    System.out.println(">>> User: " + user.getUsername());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    // Tìm kiếm người dùng theo tên đăng nhập và vai trò với phân trang
    public List<User> searchUsers(String username, String role, int page, int pageSize) {
        List<User> users = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Users WHERE isDeleted = 0");

        if (username != null && !username.isEmpty()) {
            sql.append(" AND username LIKE ?");
        }
        if (role != null && !role.isEmpty()) {
            sql.append(" AND role = ?");
        }
        sql.append(" ORDER BY userID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            int index = 1;
            if (username != null && !username.isEmpty()) {
                stmt.setString(index++, "%" + username + "%");
            }
            if (role != null && !role.isEmpty()) {
                stmt.setString(index++, role);
            }
            stmt.setInt(index++, (page - 1) * pageSize);
            stmt.setInt(index, pageSize);
            System.out.println(">>> SQL: " + stmt.toString());
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    User user = new User(
                        rs.getInt("userID"),
                        rs.getString("username"),
                        rs.getString("passwordHash"),
                        rs.getString("role"),
                        rs.getTimestamp("createdAt"),
                        rs.getBoolean("isDeleted"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("numberPhone"),
                        rs.getString("address")
                    );
                    users.add(user);
                    System.out.println(">>> User: " + user.getUsername());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    // Đánh dấu người dùng là đã xóa
    public void deleteUser(int userID) {
        String sql = "UPDATE Users SET isDeleted = 1 WHERE userID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Thêm người dùng mới
    public boolean addUser(User user) {
        String sql = "INSERT INTO Users (UserID, Username, PasswordHash, Role, CreatedAt, isDeleted, Name, Email, NumberPhone, Address) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, user.getUserID());
            stmt.setString(2, user.getUsername());
            stmt.setString(3, hashPassword(user.getPasswordHash())); // Băm mật khẩu trước khi lưu
            stmt.setString(4, user.getRole());
            stmt.setTimestamp(5, user.getCreatedAt());
            stmt.setBoolean(6, false);
            stmt.setString(7, user.getName());
            stmt.setString(8, user.getEmail());
            stmt.setString(9, user.getNumberPhone());
            stmt.setString(10, user.getAddress());

            System.out.println(">>> SQL: " + stmt.toString());
            int rowsInserted = stmt.executeUpdate();
            System.out.println(">>> Rows affected: " + rowsInserted);

            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(">>> Lỗi SQL khi thêm user: " + e.getMessage());
            return false;
        }
    }

    // Lấy thông tin người dùng theo ID
    public User getUserById(int userID) {
        User user = null;
        String sql = "SELECT * FROM Users WHERE userID = ? AND isDeleted = 0";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userID);
            System.out.println(">>> SQL: " + stmt.toString());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    user = new User(
                        rs.getInt("userID"),
                        rs.getString("username"),
                        rs.getString("passwordHash"),
                        rs.getString("role"),
                        rs.getTimestamp("createdAt"),
                        rs.getBoolean("isDeleted"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("numberPhone"),
                        rs.getString("address")
                    );
                    System.out.println(">>> User: " + user.getUsername());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    // Cập nhật thông tin người dùng
    public boolean updateUser(User user) {
        String sql = "UPDATE Users SET passwordHash = ?, role = ?, createdAt = ?, name = ?, email = ?, numberPhone = ?, address = ? WHERE userID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, hashPassword(user.getPasswordHash())); // Băm mật khẩu trước khi lưu
            stmt.setString(2, user.getRole());
            stmt.setTimestamp(3, user.getCreatedAt());
            stmt.setString(4, user.getName());
            stmt.setString(5, user.getEmail());
            stmt.setString(6, user.getNumberPhone());
            stmt.setString(7, user.getAddress());
            stmt.setInt(8, user.getUserID());

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Lấy thông tin người dùng theo tên đăng nhập và mật khẩu
    public User getUserByUsernameAndPassword(String username, String password) {
        User user = null;
        try {
            String sql = "SELECT * FROM Users WHERE Username = ? AND PasswordHash = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, hashPassword(password)); // Băm mật khẩu trước khi so sánh
            System.out.println(">>> SQL: " + ps.toString());
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User(
                    rs.getInt("UserID"),
                    rs.getString("Username"),
                    rs.getString("PasswordHash"),
                    rs.getString("Role"),
                    rs.getTimestamp("CreatedAt"),
                    rs.getBoolean("isDeleted"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("numberPhone"),
                    rs.getString("address")
                );
                System.out.println(">>> User: " + user.getUsername());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // Kiểm tra trùng lặp tên người dùng
    public boolean isUsernameExist(String username) {
        String sql = "SELECT COUNT(*) FROM Users WHERE Username = ? AND isDeleted = 0";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, username);
            System.out.println(">>> SQL: " + stmt.toString());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Kiểm tra trùng lặp email
    public boolean isEmailExist(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE Email = ? AND isDeleted = 0";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            System.out.println(">>> SQL: " + stmt.toString());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Kiểm tra trùng lặp số điện thoại
    public boolean isNumberPhoneExist(String numberPhone) {
        String sql = "SELECT COUNT(*) FROM Users WHERE NumberPhone = ? AND isDeleted = 0";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, numberPhone);
            System.out.println(">>> SQL: " + stmt.toString());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Kiểm tra trùng lặp email khi cập nhật thông tin người dùng
    public boolean isEmailExistExcludingUserId(String email, int userId) {
        String sql = "SELECT COUNT(*) FROM Users WHERE Email = ? AND isDeleted = 0 AND UserID != ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setInt(2, userId);
            System.out.println(">>> SQL: " + stmt.toString());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Kiểm tra trùng lặp số điện thoại khi cập nhật thông tin người dùng
    public boolean isNumberPhoneExistExcludingUserId(String numberPhone, int userId) {
        String sql = "SELECT COUNT(*) FROM Users WHERE NumberPhone = ? AND isDeleted = 0 AND UserID != ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, numberPhone);
            stmt.setInt(2, userId);
            System.out.println(">>> SQL: " + stmt.toString());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy thông tin người dùng theo tên đăng nhập
    public User getUserByUsername(String username) {
        User user = null;
        String sql = "SELECT * FROM Users WHERE Username = ? AND isDeleted = 0";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, username);
            System.out.println(">>> SQL: " + stmt.toString());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    user = new User(
                        rs.getInt("userID"),
                        rs.getString("username"),
                        rs.getString("passwordHash"),
                        rs.getString("role"),
                        rs.getTimestamp("createdAt"),
                        rs.getBoolean("isDeleted"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("numberPhone"),
                        rs.getString("address")
                    );
                    System.out.println(">>> User: " + user.getUsername());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}