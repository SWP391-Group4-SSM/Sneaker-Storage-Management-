/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.PurchaseOrderDetail;

/**
 *
 * @author Admin
 */
public class PurchaseOrderDetailDAO {

    private Connection conn;

    public PurchaseOrderDetailDAO() {
        DBContext db = new DBContext();
        conn = db.connection;
    }

    public List<PurchaseOrderDetail> getPurchaseOrderDetailsByOrderId(int purchaseOrderId) {
        List<PurchaseOrderDetail> list = new ArrayList<>();
        String sql = "SELECT * FROM PurchaseOrderDetails WHERE PurchaseOrderID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, purchaseOrderId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                PurchaseOrderDetail pod = new PurchaseOrderDetail();
                pod.setPurchaseOrderDetailId(rs.getInt("PurchaseOrderDetailID"));
                pod.setPurchaseOrderId(rs.getInt("PurchaseOrderID"));
                pod.setProductDetailId(rs.getInt("ProductDetailID"));
                pod.setQuantityOrdered(rs.getInt("QuantityOrdered"));
                pod.setUnitPrice(rs.getBigDecimal("UnitPrice"));
                pod.setTotalPrice(rs.getBigDecimal("UnitPrice"));
                pod.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                pod.setUpdatedAt(rs.getTimestamp("UpdatedAt").toLocalDateTime());
                list.add(pod);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm mới chi tiết đơn hàng
    public boolean addPurchaseOrderDetail(PurchaseOrderDetail pod) {
        String sql = "INSERT INTO PurchaseOrderDetails (PurchaseOrderID, ProductID, Quantity, UnitPrice, CreatedAt, UpdatedAt) "
                + "VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, pod.getPurchaseOrderId());
            pstmt.setInt(2, pod.getProductDetailId());
            pstmt.setInt(3, pod.getQuantityOrdered());
            pstmt.setBigDecimal(4, pod.getUnitPrice());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật chi tiết đơn hàng
    public boolean updatePurchaseOrderDetail(PurchaseOrderDetail pod) {
        String sql = "UPDATE PurchaseOrderDetails SET Quantity = ?, UnitPrice = ?, TotalPrice = ? "
                + "WHERE PurchaseOrderID = ? AND ProductID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, pod.getQuantityOrdered());
            pstmt.setBigDecimal(2, pod.getUnitPrice());
            pstmt.setInt(4, pod.getPurchaseOrderId());
            pstmt.setInt(5, pod.getProductDetailId());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa chi tiết đơn hàng
    public boolean deletePurchaseOrderDetail(int purchaseOrderId, int productId) {
        String sql = "DELETE FROM PurchaseOrderDetails WHERE PurchaseOrderID = ? AND ProductID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, purchaseOrderId);
            pstmt.setInt(2, productId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isPurchaseOrderDetailIdExists(int purchaseOrderDetailId) {
        String sql = "SELECT COUNT(*) FROM PurchaseOrderDetails WHERE PurchaseOrderID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, purchaseOrderDetailId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
