package dal;

import java.beans.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

public class DBContext {

    public Connection connection;

    public DBContext() {
        try {
            //Change the username password and url to connect your own database
            String username = "sa";
            String password = "123456";

            String url = "jdbc:sqlserver://localhost:1433;databaseName=SneakerManagement_testdelete";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

   
//    public static void main(String[] args) {
//        DBContext dbContext = new DBContext();
//        
//        // Test if the connection is not null and is valid
//        try {
//            Connection connection = dbContext.connection;
//            if (connection != null && !connection.isClosed()) {
//                System.out.println("Database connection successful!");
//            } else {
//                System.out.println("Failed to connect to the database.");
//            }
//        } catch (SQLException ex) {
//            System.out.println("Error occurred while checking the connection: " + ex.getMessage());
//        }
//    }
    
    
//    
//    public static void main(String[] args) {
//        UserDAO userDAO = new UserDAO();
//
//        // Get all users
//        List<User> users = userDAO.getAll();
//
//        // Display users
//        for (User user : users) {
//            System.out.println(user.getUsername() + " - " + user.getRole());
//        }
//    }

}
