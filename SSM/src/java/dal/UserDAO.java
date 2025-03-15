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
                        rs.getBoolean("isDeleted")
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
                        rs.getBoolean("isDeleted")
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

    public void deleteUser(int userID) {
        String sql = "UPDATE Users SET isDeleted = 1 WHERE userID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean addUser(User user) {
        String sql = "INSERT INTO Users (UserID, Username, PasswordHash, Role, CreatedAt, isDeleted) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, user.getUserID());
            stmt.setString(2, user.getUsername());
            stmt.setString(3, user.getPasswordHash());
            stmt.setString(4, user.getRole());
            stmt.setTimestamp(5, user.getCreatedAt());
            stmt.setBoolean(6, false);

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
                        rs.getBoolean("isDeleted")
                    );
                    System.out.println(">>> User: " + user.getUsername());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    public void updateUser(User user) {
        String sql = "UPDATE Users SET username = ?, passwordHash = ?, role = ?, createdAt = ? WHERE userID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPasswordHash());
            stmt.setString(3, user.getRole());
            stmt.setTimestamp(4, user.getCreatedAt());
            stmt.setInt(5, user.getUserID());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public User getUserByUsernameAndPassword(String username, String password) {
        User user = null;
        try {
            String sql = "SELECT * FROM Users WHERE Username = ? AND PasswordHash = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            System.out.println(">>> SQL: " + ps.toString());
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User(
                    rs.getInt("UserID"),
                    rs.getString("Username"),
                    rs.getString("PasswordHash"),
                    rs.getString("Role"),
                    rs.getTimestamp("CreatedAt"),
                    rs.getBoolean("isDeleted")
                );
                System.out.println(">>> User: " + user.getUsername());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // Phương thức kiểm tra trùng lặp username
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

    // Phương thức lấy user theo username
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
                        rs.getBoolean("isDeleted")
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