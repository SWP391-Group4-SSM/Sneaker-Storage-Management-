package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    public static Connection getConnection() {
    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String url = "jdbc:sqlserver://localhost:1433;databaseName=SneakerManagement;encrypt=false;trustServerCertificate=true";
        String user = "sa";
        String password = "123456";
        return DriverManager.getConnection(url, user, password);
    } catch (SQLException | ClassNotFoundException e) {
        System.err.println("Database connection failed: " + e.getMessage());
        throw new RuntimeException("Cannot connect to database", e);
    }
}

}



//package util;
//
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.SQLException;
//
//public class DBConnection {
//    public static Connection getConnection() {
//        try {
//            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//            String url = "jdbc:sqlserver://localhost:1433;databaseName=SneakerManagement;encrypt=false;trustServerCertificate=true";
//            String user = "sa";
//            String password = "123456789";
//            return DriverManager.getConnection(url, user, password);
//        } catch (SQLException | ClassNotFoundException e) {
//            System.err.println("Error " + e.getMessage() + " at DB Context");
//            e.printStackTrace();
//            return null;
//        }
//    }
//}