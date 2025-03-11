package dal;

import model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Supplier;

public class UserDAO {

    private Connection connection;

    public UserDAO() {
        DBContext db = new DBContext();
        connection = db.connection;
    }

    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM Users WHERE Username = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new User(
                        rs.getInt("UserID"),
                        rs.getString("Username"),
                        rs.getString("PasswordHash"),
                        rs.getString("Role"),
                        rs.getTimestamp("CreatedAt").toLocalDateTime()
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM Users";

        try (PreparedStatement pstmt = connection.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                User user = new User();
                user.setUserID(rs.getInt("UserID"));
                user.setUsername(rs.getString("Username"));
                user.setPasswordHash(rs.getString("PasswordHash"));
                user.setRole(rs.getString("Role"));
                user.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
    
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public boolean checkPassword(User user, String password) {
        return user.getPasswordHash().equals(password);
    }
}
