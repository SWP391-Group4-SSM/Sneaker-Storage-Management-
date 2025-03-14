/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.*;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import model.ProductDetail;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
/**
 *
 * @author Admin
 */
public class ProductDetailDAO {
    private Connection conn;

    public ProductDetailDAO() {
        DBContext db = new DBContext();
        conn = db.connection;
    }
    public List<ProductDetail> getAllProductDetails() {
        List<ProductDetail> productDetails = new ArrayList<>();
        String sql = "SELECT * FROM ProductDetails WHERE isDeleted = 0";
        try (PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                ProductDetail pd = new ProductDetail();
                pd.setProductDetailId(rs.getInt("ProductDetailID"));
                pd.setProductId(rs.getInt("ProductID"));
                pd.setSize(rs.getString("Size"));
                pd.setColor(rs.getString("Color"));
                pd.setImageUrl(rs.getString("ImageURL"));
                pd.setStatus(rs.getString("Status"));
                pd.setMaterial(rs.getString("Material"));
                pd.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                pd.setUpdatedAt(rs.getTimestamp("UpdatedAt").toLocalDateTime());
                pd.setIsDeleted(rs.getBoolean("isDeleted"));
                productDetails.add(pd);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productDetails;
    }
    
    public List<ProductDetail> getProductDetailByProId(int proId) {
        List<ProductDetail> productDetails = new ArrayList<>();
        String sql = "SELECT * FROM ProductDetails WHERE isDeleted = 0 and ProductID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {
            pstmt.setInt(1, proId);
            while (rs.next()) {
                ProductDetail pd = new ProductDetail();
                pd.setProductDetailId(rs.getInt("ProductDetailID"));
                pd.setProductId(rs.getInt("ProductID"));
                pd.setSize(rs.getString("Size"));
                pd.setColor(rs.getString("Color"));
                pd.setImageUrl(rs.getString("ImageURL"));
                pd.setStatus(rs.getString("Status"));
                pd.setMaterial(rs.getString("Material"));
                pd.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                pd.setUpdatedAt(rs.getTimestamp("UpdatedAt").toLocalDateTime());
                pd.setIsDeleted(rs.getBoolean("isDeleted"));
                productDetails.add(pd);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productDetails;
    }
    
    public boolean addProductDetail(ProductDetail pd) {
        String sql = "INSERT INTO ProductDetails (ProductID, Size, Color, ImageURL, Status, Material, CreatedAt, UpdatedAt, isDeleted) "
                   + "VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 0)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, pd.getProductId());
            pstmt.setString(2, pd.getSize());
            pstmt.setString(3, pd.getColor());
            pstmt.setString(4, pd.getImageUrl());
            pstmt.setString(5, pd.getStatus());
            pstmt.setString(6, pd.getMaterial());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
}
