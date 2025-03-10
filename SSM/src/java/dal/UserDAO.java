package dal;

import model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private Connection connection;

    public UserDAO() {
        DBContext db = new DBContext();
        connection = db.connection;
    }

    // Lấy thông tin người dùng theo username
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM Users WHERE Username = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("UserID"),
                            rs.getString("Username"),
                            rs.getString("PasswordHash"),
                            rs.getString("Role"),
                            rs.getTimestamp("CreatedAt")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Kiểm tra mật khẩu của người dùng
    public boolean checkPassword(User user, String password) {
        return user.getPasswordHash().equals(password);
    }

    // Thêm người dùng mới vào cơ sở dữ liệu
    public void createUser(User user) {
        String sql = "INSERT INTO Users (Username, PasswordHash, Role, CreatedAt) VALUES (?, ?, ?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPasswordHash());
            pstmt.setString(3, user.getRole());
            pstmt.setTimestamp(4, user.getCreatedAt());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Lấy danh sách tất cả người dùng
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM Users";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                users.add(new User(
                        rs.getInt("UserID"),
                        rs.getString("Username"),
                        rs.getString("PasswordHash"),
                        rs.getString("Role"),
                        rs.getTimestamp("CreatedAt")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    // Cập nhật thông tin người dùng trong cơ sở dữ liệu
    public void updateUser(User user) {
        String sql = "UPDATE Users SET Username = ?, PasswordHash = ?, Role = ? WHERE UserID = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPasswordHash());
            pstmt.setString(3, user.getRole());
            pstmt.setInt(4, user.getUserID());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Xóa người dùng khỏi cơ sở dữ liệu
    public void deleteUser(int userID) {
        String sql = "DELETE FROM Users WHERE UserID = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, userID);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Lấy thông tin người dùng theo ID
    public User getUserById(int userID) {
        String sql = "SELECT * FROM Users WHERE UserID = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, userID);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("UserID"),
                            rs.getString("Username"),
                            rs.getString("PasswordHash"),
                            rs.getString("Role"),
                            rs.getTimestamp("CreatedAt")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy toàn bộ danh sách người dùng (hàm gọi lại getAllUsers)
    public List<User> getAll() {
        return getAllUsers();
    }

    // 🔹 Tìm kiếm người dùng theo username và/hoặc role
    public List<User> searchUsers(String username, String role) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM Users WHERE 1=1";

        if (username != null && !username.isEmpty()) {
            sql += " AND Username LIKE ?";
        }
        if (role != null && !role.isEmpty()) {
            sql += " AND Role = ?";
        }

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            int index = 1;
            if (username != null && !username.isEmpty()) {
                pstmt.setString(index++, "%" + username + "%");
            }
            if (role != null && !role.isEmpty()) {
                pstmt.setString(index++, role);
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    users.add(new User(
                            rs.getInt("UserID"),
                            rs.getString("Username"),
                            rs.getString("PasswordHash"),
                            rs.getString("Role"),
                            rs.getTimestamp("CreatedAt")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
}
