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
                pd.setSize(rs.getInt("Size"));
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
    public List<ProductDetail> getAllProductDetailsInData() {
        List<ProductDetail> productDetails = new ArrayList<>();
        String sql = "SELECT * FROM ProductDetails WHERE isDeleted = 0";
        try (PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                ProductDetail pd = new ProductDetail();
                pd.setProductDetailId(rs.getInt("ProductDetailID"));
                pd.setProductId(rs.getInt("ProductID"));
                pd.setSize(rs.getInt("Size"));
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
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, proId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                ProductDetail pd = new ProductDetail();
                pd.setProductDetailId(rs.getInt("ProductDetailID"));
                pd.setProductId(rs.getInt("ProductID"));
                pd.setSize(rs.getInt("Size"));
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
        String sql = " INSERT INTO ProductDetails \n"
                + "  (ProductDetailID,ProductID, Size, Color, ImageURL, Status, Material, CreatedAt, UpdatedAt, isDeleted) "
                + "VALUES (?, ?, ?, ?, ?, 'Active', ?,CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 0)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, pd.getProductDetailId());
            pstmt.setInt(2, pd.getProductId());
            pstmt.setInt(3,pd.getSize());
            pstmt.setString(4, pd.getColor());
            pstmt.setString(5, pd.getImageUrl());
            pstmt.setString(6, pd.getMaterial());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteProductDetail(int productDetailId) {
        String sql = "UPDATE ProductDetails SET isDeleted = 1 WHERE ProductDetailID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1,productDetailId );
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
