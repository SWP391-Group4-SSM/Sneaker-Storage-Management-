package dal;

import model.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Product
 */
public class ProductDAO {
    private Connection connection;

    public ProductDAO() {
        DBContext db = new DBContext();
        connection = db.connection;
    }

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Products";
        try (PreparedStatement pstmt = connection.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) { // Fixed error: removed sql parameter
            while (rs.next()) {
                Product p = new Product();
                p.setProductID(rs.getInt("ProductID"));
                p.setName(rs.getString("Name"));
                p.setDescription(rs.getString("Description"));
                p.setSku(rs.getString("SKU"));
                p.setPrice(rs.getDouble("Price"));
                products.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public Product getProductById(int productId) {
        String sql = "SELECT * FROM Products WHERE ProductID = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, productId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Product p = new Product();
                    p.setProductID(rs.getInt("ProductID"));
                    p.setName(rs.getString("Name"));
                    p.setDescription(rs.getString("Description"));
                    p.setSku(rs.getString("SKU"));
                    p.setPrice(rs.getDouble("Price"));
                    return p;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Product> searchProducts(String keyword) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE Name LIKE ? OR Description LIKE ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, "%" + keyword + "%");
            pstmt.setString(2, "%" + keyword + "%");
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product();
                    p.setProductID(rs.getInt("ProductID"));
                    p.setName(rs.getString("Name"));
                    p.setDescription(rs.getString("Description"));
                    p.setSku(rs.getString("SKU"));
                    p.setPrice(rs.getDouble("Price"));
                    products.add(p);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> filterProductsByPrice(double minPrice, double maxPrice) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE Price BETWEEN ? AND ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setDouble(1, minPrice);
            pstmt.setDouble(2, maxPrice);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product();
                    p.setProductID(rs.getInt("ProductID"));
                    p.setName(rs.getString("Name"));
                    p.setDescription(rs.getString("Description"));
                    p.setSku(rs.getString("SKU"));
                    p.setPrice(rs.getDouble("Price"));
                    products.add(p);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> sortProductsByPrice(boolean ascending) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Products ORDER BY Price " + (ascending ? "ASC" : "DESC"); // Fixed error: secure query
        try (PreparedStatement pstmt = connection.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Product p = new Product();
                p.setProductID(rs.getInt("ProductID"));
                p.setName(rs.getString("Name"));
                p.setDescription(rs.getString("Description"));
                p.setSku(rs.getString("SKU"));
                p.setPrice(rs.getDouble("Price"));
                products.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
}
