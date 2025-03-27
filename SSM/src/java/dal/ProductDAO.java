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

    private Connection conn;

    public ProductDAO() {
        DBContext db = new DBContext();
        conn = db.connection;
    }

    public List<Product> getAllProducts(int page, int pageSize) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE isDeleted = 0 ORDER BY ProductID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, (page - 1) * pageSize);
            pstmt.setInt(2, pageSize);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("ProductID"));
                p.setName(rs.getString("Name"));
                p.setDescription(rs.getString("Description"));
                p.setSku(rs.getString("SKU"));
                p.setPrice(rs.getBigDecimal("Price"));
                p.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                p.setUpdatedAt(rs.getTimestamp("UpdatedAt").toLocalDateTime());
                products.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    public List<Product> searchByName(String name, int page, int pageSize) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Products "
                + "WHERE isDeleted = 0 "
                + "AND Name LIKE ? "
                + "ORDER BY ProductID "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + name + "%");
            stmt.setInt(2, (page - 1) * pageSize);
            stmt.setInt(3, pageSize);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product(
                        rs.getInt("ProductID"),
                        rs.getString("Name"),
                        rs.getString("Description"),
                        rs.getString("SKU"),
                        rs.getBigDecimal("Price"),
                        rs.getTimestamp("CreatedAt").toLocalDateTime(),
                        rs.getTimestamp("UpdatedAt") != null ? 
                            rs.getTimestamp("UpdatedAt").toLocalDateTime() : null,
                        rs.getBoolean("isDeleted")
                    );
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> getAllProductsInData() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Products ";
        try (PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("ProductID"));
                p.setName(rs.getString("Name"));
                p.setDescription(rs.getString("Description"));
                p.setSku(rs.getString("SKU"));
                p.setPrice(rs.getBigDecimal("Price"));
                p.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                p.setUpdatedAt(rs.getTimestamp("UpdatedAt").toLocalDateTime());
                products.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public boolean addProduct(Product p) {
        String sql = "INSERT INTO Products (ProductID, Name, Description, SKU, Price, CreatedAt, UpdatedAt) "
                + "VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, p.getProductId());
            pstmt.setString(2, p.getName());
            pstmt.setString(3, p.getDescription());
            pstmt.setString(4, p.getSku());
            pstmt.setBigDecimal(5, p.getPrice());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteProduct(int productId) {
        String sql = "UPDATE Products SET isDeleted = 1 WHERE ProductID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getTotalProducts() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM Products WHERE isDeleted = 0";
        try (PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }
    public int getTotalRecords(String searchName) {
        int totalRecords = 0;
        String sql = "SELECT COUNT(*) FROM Products WHERE isDeleted = 0 "
                + (searchName != null && !searchName.trim().isEmpty() ? 
                   "AND Name LIKE ?" : "");
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            if (searchName != null && !searchName.trim().isEmpty()) {
                stmt.setString(1, "%" + searchName.trim() + "%");
            }
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                totalRecords = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalRecords;
    }

    public boolean isProductIdExists(int productId) {
        String query = "SELECT COUNT(*) FROM Products WHERE ProductID = ?";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
