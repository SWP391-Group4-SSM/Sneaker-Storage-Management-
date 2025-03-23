/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author Admin
 */
import model.PurchaseOrder;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PurchaseOrderDAO {

    private Connection conn;

    public PurchaseOrderDAO() {
        DBContext db = new DBContext();
        conn = db.connection;
    }

    public List<PurchaseOrder> getAllPurchaseOrders(int page, int pageSize) {
    List<PurchaseOrder> purchaseOrders = new ArrayList<>();
    String sql = "SELECT * FROM PurchaseOrders WHERE isDeleted = 0 ORDER BY PurchaseOrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
    
    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setInt(1, (page - 1) * pageSize); // OFFSET
        pstmt.setInt(2, pageSize); // FETCH NEXT
        
        try (ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                PurchaseOrder po = new PurchaseOrder();
                po.setPurchaseOrderId(rs.getInt("PurchaseOrderID"));
                po.setSupplierId(rs.getInt("SupplierID"));
                po.setWarehouseId(rs.getInt("WarehouseID"));
                po.setCreatedByUserId(rs.getInt("CreatedByUserID"));
                po.setOrderDate(rs.getTimestamp("OrderDate").toLocalDateTime());
                po.setPurchaseOrderStatus(rs.getString("PurchaseOrderStatus"));
                po.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                po.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                po.setUpdatedAt(rs.getTimestamp("UpdatedAt").toLocalDateTime());
                purchaseOrders.add(po);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return purchaseOrders;
}

    public boolean addPurchaseOrder(PurchaseOrder po) {
    // Kiểm tra xem PurchaseOrderID đã tồn tại chưa
    if (isPurchaseOrderIdExists(po.getPurchaseOrderId())) {
        return false; // Không thêm nếu ID đã tồn tại
    }
    String sql = "INSERT INTO PurchaseOrders (PurchaseOrderID, SupplierID, WarehouseID, CreatedByUserID, OrderDate, PurchaseOrderStatus, TotalAmount, CreatedAt, UpdatedAt) "
           + "VALUES (?, ?, ?, ?, ?, 'Draft', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)";

    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setInt(1, po.getPurchaseOrderId()); // Tự nhập ID
        pstmt.setInt(2, po.getSupplierId());
        pstmt.setInt(3, po.getWarehouseId());
        pstmt.setInt(4, po.getCreatedByUserId());
        pstmt.setTimestamp(5, Timestamp.valueOf(po.getOrderDate())); // Chuyển từ LocalDateTime sang Timestamp
        
        return pstmt.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

    public boolean updatePurchaseOrder(PurchaseOrder po) {
    String sql = "UPDATE PurchaseOrders SET SupplierID=?, WarehouseID=?, CreatedByUserID=?, PurchaseOrderStatus=?, TotalAmount=?, UpdatedAt=CURRENT_TIMESTAMP WHERE PurchaseOrderID=?";
    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setInt(1, po.getSupplierId());
        pstmt.setInt(2, po.getWarehouseId());
        pstmt.setInt(3, po.getCreatedByUserId());
        pstmt.setString(4, po.getPurchaseOrderStatus());
        pstmt.setBigDecimal(5, po.getTotalAmount());
        pstmt.setInt(6, po.getPurchaseOrderId()); // Lưu ý: Đổi chỉ số do bỏ UpdatedAt
        return pstmt.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

    public boolean deletePurchaseOrder(int purchaseOrderId) {
        String sql = "update PurchaseOrders set isDeleted =1 where PurchaseOrderID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, purchaseOrderId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public PurchaseOrder getPurchaseOrderById(int purchaseOrderId) {
        PurchaseOrder po = null;
        String sql = "SELECT * FROM PurchaseOrders WHERE PurchaseOrderID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, purchaseOrderId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    po = new PurchaseOrder();
                    po.setPurchaseOrderId(rs.getInt("PurchaseOrderID"));
                    po.setSupplierId(rs.getInt("SupplierID"));
                    po.setWarehouseId(rs.getInt("WarehouseID"));
                    po.setCreatedByUserId(rs.getInt("CreatedByUserID"));
                    po.setOrderDate(rs.getTimestamp("OrderDate").toLocalDateTime());
                    po.setPurchaseOrderStatus(rs.getString("PurchaseOrderStatus"));
                    po.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                    po.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                    po.setUpdatedAt(rs.getTimestamp("UpdatedAt").toLocalDateTime());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return po;
    }
    
    public boolean isPurchaseOrderIdExists(int purchaseOrderId) {
    String sql = "SELECT COUNT(*) FROM PurchaseOrders WHERE PurchaseOrderID = ?";
    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setInt(1, purchaseOrderId);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}
    
    public boolean updatePurchaseOrderStatus(PurchaseOrder po) {
    String sql = "update PurchaseOrders set PurchaseOrderStatus = ? where PurchaseOrderID =?";
    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setString(1, po.getPurchaseOrderStatus());
        pstmt.setInt(2, po.getPurchaseOrderId()); // Lưu ý: Đổi chỉ số do bỏ UpdatedAt
        return pstmt.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}
    
    public int getTotalNumberPurchaseOrders() {
    int total = 0;
    String sql = "SELECT COUNT(*) FROM PurchaseOrders WHERE isDeleted = 0";
    try (PreparedStatement pstmt = conn.prepareStatement(sql);
         ResultSet rs = pstmt.executeQuery()) {
        if (rs.next()) {
            total = rs.getInt(1);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return total;
}

    
}
