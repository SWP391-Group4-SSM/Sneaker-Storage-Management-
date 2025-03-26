package dal;

import java.math.BigDecimal;
import model.PurchaseOrder;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.PurchaseOrderDetail;

public class PurchaseOrderDAO {

    private Connection conn;

    public PurchaseOrderDAO() {
        DBContext db = new DBContext();
        conn = db.connection;
    }

    public List<PurchaseOrder> getAllPurchaseOrders() {
        List<PurchaseOrder> purchaseOrders = new ArrayList<>();
        String sql = "SELECT * FROM PurchaseOrders";
        try (PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {
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
                + "VALUES (?, ?, ?, ?, ?, 'Draft', ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, po.getPurchaseOrderId()); // Tự nhập ID
            pstmt.setInt(2, po.getSupplierId());
            pstmt.setInt(3, po.getWarehouseId());
            pstmt.setInt(4, po.getCreatedByUserId());
            pstmt.setTimestamp(5, Timestamp.valueOf(po.getOrderDate())); // Chuyển từ LocalDateTime sang Timestamp
            pstmt.setBigDecimal(6, po.getTotalAmount());
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
        String sql = "DELETE FROM PurchaseOrders WHERE PurchaseOrderID = ?";
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
    
    // Lấy danh sách Purchase Orders có trạng thái "Ordered" hoặc "Approved"
    public List<PurchaseOrder> getApprovedOrOrderedPOs() {
        List<PurchaseOrder> purchaseOrders = new ArrayList<>();
        String sql = "SELECT * FROM PurchaseOrders WHERE PurchaseOrderStatus IN ('Ordered', 'Approved')";
        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                PurchaseOrder po = new PurchaseOrder();
                po.setPurchaseOrderId(rs.getInt("PurchaseOrderID"));
                purchaseOrders.add(po);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return purchaseOrders;
    }
    
    public List<PurchaseOrderDetail> getPurchaseOrderDetails(int poId) {
    List<PurchaseOrderDetail> details = new ArrayList<>();
    String sql = "SELECT PurchaseOrderDetailID, PurchaseOrderID, ProductDetailID, QuantityOrdered, UnitPrice, TotalPrice, CreatedAt, UpdatedAt " +
                 "FROM PurchaseOrderDetails WHERE PurchaseOrderID = ?";

    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setInt(1, poId);
        try (ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                int purchaseOrderDetailId = rs.getInt("PurchaseOrderDetailID");
                int purchaseOrderId = rs.getInt("PurchaseOrderID");
                int productDetailId = rs.getInt("ProductDetailID");
                int quantityOrdered = rs.getInt("QuantityOrdered");
                BigDecimal unitPrice = rs.getBigDecimal("UnitPrice");
                BigDecimal totalPrice = rs.getBigDecimal("TotalPrice");

                // Handle nullable timestamps
                Timestamp createdAtTs = rs.getTimestamp("CreatedAt");
                LocalDateTime createdAt = (createdAtTs != null) ? createdAtTs.toLocalDateTime() : null;
                Timestamp updatedAtTs = rs.getTimestamp("UpdatedAt");
                LocalDateTime updatedAt = (updatedAtTs != null) ? updatedAtTs.toLocalDateTime() : null;

                // Create and populate PurchaseOrderDetail object
                PurchaseOrderDetail detail = new PurchaseOrderDetail(
                    purchaseOrderDetailId,
                    purchaseOrderId,
                    productDetailId,
                    quantityOrdered,
                    unitPrice,
                    totalPrice,
                    createdAt,
                    updatedAt
                );
                details.add(detail);
            }
        }
    } catch (SQLException e) {
        System.err.println("Error retrieving purchase order details: " + e.getMessage());
        // In a production environment, consider logging or rethrowing a custom exception
    }
    return details;
}

}
