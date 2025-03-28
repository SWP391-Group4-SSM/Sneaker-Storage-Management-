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

    public List<PurchaseOrder> getAll(int page, int pageSize) {
        List<PurchaseOrder> orders = new ArrayList<>();
        String sql = "SELECT po.*, s.SupplierName, w.Name as WarehouseName, "
                + "u.Username as CreatedByName "
                + "FROM PurchaseOrders po "
                + "JOIN Suppliers s ON po.SupplierID = s.SupplierID "
                + "JOIN Warehouses w ON po.WarehouseID = w.WarehouseID "
                + "JOIN Users u ON po.CreatedByUserID = u.UserID "
                + "WHERE po.isDeleted = 0 "
                + "ORDER BY po.CreatedAt DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, (page - 1) * pageSize);
            stmt.setInt(2, pageSize);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    PurchaseOrder order = new PurchaseOrder(
                        rs.getInt("PurchaseOrderID"),
                        rs.getInt("SupplierID"),
                        rs.getInt("WarehouseID"),
                        rs.getInt("CreatedByUserID"),
                        rs.getTimestamp("OrderDate").toLocalDateTime(),
                        rs.getString("PurchaseOrderStatus"),
                        rs.getBigDecimal("TotalAmount"),
                        rs.getTimestamp("CreatedAt").toLocalDateTime(),
                        rs.getTimestamp("UpdatedAt") != null ? rs.getTimestamp("UpdatedAt").toLocalDateTime() : null
                        
                    );
                    // Thêm thông tin bổ sung
                    order.setSupplierName(rs.getString("SupplierName"));
                    order.setWarehouseName(rs.getString("WarehouseName"));
                    order.setCreatedByName(rs.getString("CreatedByName"));
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
    
    public List<PurchaseOrder> searchOrders(String supplierName, String warehouseName, int page, int pageSize) {
        List<PurchaseOrder> orders = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT po.*, s.SupplierName, w.Name as WarehouseName, "
            + "u.Username as CreatedByName "
            + "FROM PurchaseOrders po "
            + "JOIN Suppliers s ON po.SupplierID = s.SupplierID "
            + "JOIN Warehouses w ON po.WarehouseID = w.WarehouseID "
            + "JOIN Users u ON po.CreatedByUserID = u.UserID "
            + "WHERE po.isDeleted = 0 "
        );

        List<Object> params = new ArrayList<>();

        if (supplierName != null && !supplierName.trim().isEmpty()) {
            sql.append(" AND s.SupplierName LIKE ?");
            params.add("%" + supplierName.trim() + "%");
        }
        if (warehouseName != null && !warehouseName.trim().isEmpty()) {
            sql.append(" AND w.Name LIKE ?");
            params.add("%" + warehouseName.trim() + "%");
        }

        sql.append(" ORDER BY po.PurchaseOrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            int parameterIndex = 1;
            for (Object param : params) {
                stmt.setObject(parameterIndex++, param);
            }
            stmt.setInt(parameterIndex++, (page - 1) * pageSize);
            stmt.setInt(parameterIndex, pageSize);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    PurchaseOrder order = new PurchaseOrder(
                        rs.getInt("PurchaseOrderID"),
                        rs.getInt("SupplierID"),
                        rs.getInt("WarehouseID"),
                        rs.getInt("CreatedByUserID"),
                        rs.getTimestamp("OrderDate").toLocalDateTime(),
                        rs.getString("PurchaseOrderStatus"),
                        rs.getBigDecimal("TotalAmount"),
                        rs.getTimestamp("CreatedAt").toLocalDateTime(),
                        rs.getTimestamp("UpdatedAt") != null ? rs.getTimestamp("UpdatedAt").toLocalDateTime() : null
                    );
                    // Thêm thông tin bổ sung
                    order.setSupplierName(rs.getString("SupplierName"));
                    order.setWarehouseName(rs.getString("WarehouseName"));
                    order.setCreatedByName(rs.getString("CreatedByName"));
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
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
    String sql = "UPDATE PurchaseOrders SET SupplierID=?, WarehouseID=?, UpdatedAt=CURRENT_TIMESTAMP WHERE PurchaseOrderID=?";
    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setInt(1, po.getSupplierId());
        pstmt.setInt(2, po.getWarehouseId());
      
        pstmt.setInt(4, po.getPurchaseOrderId()); // Lưu ý: Đổi chỉ số do bỏ UpdatedAt
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
