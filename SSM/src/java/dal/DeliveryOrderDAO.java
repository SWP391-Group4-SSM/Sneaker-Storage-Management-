package dal;

import model.DeliveryOrder;
import model.DeliveryOrderDetail;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class DeliveryOrderDAO {

    private Connection conn;

    public DeliveryOrderDAO() {
        DBContext db = new DBContext();
        conn = db.connection;
    }

    public List<DeliveryOrder> getAllDeliveryOrders() {
        List<DeliveryOrder> list = new ArrayList<>();
        String sql = "SELECT DeliveryOrderID FROM DeliveryOrders WHERE (isDeleted IS NULL OR isDeleted = 0) ORDER BY DeliveryOrderID";
        try (PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                DeliveryOrder deliveryOrder = new DeliveryOrder();
                deliveryOrder.setDeliveryOrderId(rs.getInt("DeliveryOrderID"));
                list.add(deliveryOrder);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addDeliveryOrder(DeliveryOrder deliveryOrder) {
        // Modify SQL statement to remove PurchaseOrderID
        String sql = "INSERT INTO DeliveryOrders (DeliveryOrderID, SupplierID, WarehouseID, CreatedByUserID, DocumentDate, DocumentStatus, UpdatedAt, isDeleted) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, deliveryOrder.getDeliveryOrderId());
            // Remove this line: pstmt.setInt(2, deliveryOrder.getPurchaseOrderId());
            // Adjust all parameter indices
            pstmt.setObject(2, deliveryOrder.getSupplierId()); // Handle null
            pstmt.setInt(3, deliveryOrder.getWarehouseId());
            pstmt.setInt(4, deliveryOrder.getCreatedByUserId());
            pstmt.setTimestamp(5, Timestamp.valueOf(deliveryOrder.getDocumentDate()));
            pstmt.setString(6, deliveryOrder.getDocumentStatus());
            pstmt.setTimestamp(7, Timestamp.valueOf(deliveryOrder.getUpdatedAt()));
            pstmt.setBoolean(8, deliveryOrder.getIsDeleted() != null ? deliveryOrder.getIsDeleted() : false);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean addDeliveryOrderDetail(DeliveryOrderDetail detail) {
        String sql = "INSERT INTO DeliveryOrderDetails (DeliveryOrderDetailID, DeliveryOrderID, ProductDetailID, QuantityOrdered, CreatedAt, UpdatedAt) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, detail.getDeliveryOrderDetailId());
            pstmt.setInt(2, detail.getDeliveryOrderId());
            pstmt.setInt(3, detail.getProductDetailId());
            pstmt.setInt(4, detail.getQuantityOrdered());
            pstmt.setTimestamp(5, Timestamp.valueOf(detail.getCreatedAt()));
            pstmt.setTimestamp(6, Timestamp.valueOf(detail.getUpdatedAt()));
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<DeliveryOrderDetail> getDeliveryOrderDetailsByOrderId(int deliveryOrderId) {
        List<DeliveryOrderDetail> list = new ArrayList<>();
        String sql = "SELECT d.* FROM DeliveryOrderDetails d "
                + "JOIN DeliveryOrders o ON d.DeliveryOrderID = o.DeliveryOrderID "
                + "WHERE d.DeliveryOrderID = ? AND (o.isDeleted IS NULL OR o.isDeleted = 0)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, deliveryOrderId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                DeliveryOrderDetail detail = new DeliveryOrderDetail(
                        rs.getInt("DeliveryOrderDetailID"),
                        rs.getInt("DeliveryOrderID"),
                        rs.getInt("ProductDetailID"),
                        rs.getInt("QuantityOrdered"),
                        rs.getTimestamp("CreatedAt").toLocalDateTime(),
                        rs.getTimestamp("UpdatedAt").toLocalDateTime()
                );
                list.add(detail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public DeliveryOrder getDeliveryOrderById(int deliveryOrderId) {
        DeliveryOrder deliveryOrder = null;
        String sql = "SELECT * FROM DeliveryOrders WHERE DeliveryOrderID = ? AND (isDeleted IS NULL OR isDeleted = 0)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, deliveryOrderId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                deliveryOrder = new DeliveryOrder();
                deliveryOrder.setDeliveryOrderId(rs.getInt("DeliveryOrderID"));

                Object supplierIdObj = rs.getObject("SupplierID");
                if (supplierIdObj != null) {
                    deliveryOrder.setSupplierId((Integer) supplierIdObj);
                } else {
                    deliveryOrder.setSupplierId(null);
                }

                deliveryOrder.setWarehouseId(rs.getInt("WarehouseID"));
                deliveryOrder.setCreatedByUserId(rs.getInt("CreatedByUserID"));
                deliveryOrder.setDocumentDate(rs.getTimestamp("DocumentDate").toLocalDateTime());
                deliveryOrder.setDocumentStatus(rs.getString("DocumentStatus"));
                deliveryOrder.setUpdatedAt(rs.getTimestamp("UpdatedAt").toLocalDateTime());

                Object isDeletedObj = rs.getObject("isDeleted");
                if (isDeletedObj != null) {
                    deliveryOrder.setIsDeleted(rs.getBoolean("isDeleted"));
                } else {
                    deliveryOrder.setIsDeleted(false);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return deliveryOrder;
    }

    public List<DeliveryOrder> getDeliveryOrders(int page, int recordsPerPage, int warehouseId, int deliveryOrderId) {
        List<DeliveryOrder> list = new ArrayList<>();
        String sql = "SELECT * FROM DeliveryOrders WHERE (isDeleted IS NULL OR isDeleted = 0) AND (? = -1 OR WarehouseID = ?) AND (? = -1 OR DeliveryOrderID = ?) ORDER BY DeliveryOrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, warehouseId);
            pstmt.setInt(2, warehouseId);
            pstmt.setInt(3, deliveryOrderId);
            pstmt.setInt(4, deliveryOrderId);
            pstmt.setInt(5, (page - 1) * recordsPerPage);
            pstmt.setInt(6, recordsPerPage);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                DeliveryOrder deliveryOrder = new DeliveryOrder();
                deliveryOrder.setDeliveryOrderId(rs.getInt("DeliveryOrderID"));

                Object supplierIdObj = rs.getObject("SupplierID");
                if (supplierIdObj != null) {
                    deliveryOrder.setSupplierId((Integer) supplierIdObj);
                } else {
                    deliveryOrder.setSupplierId(null);
                }

                deliveryOrder.setWarehouseId(rs.getInt("WarehouseID"));
                deliveryOrder.setCreatedByUserId(rs.getInt("CreatedByUserID"));
                deliveryOrder.setDocumentDate(rs.getTimestamp("DocumentDate").toLocalDateTime());
                deliveryOrder.setDocumentStatus(rs.getString("DocumentStatus"));
                deliveryOrder.setUpdatedAt(rs.getTimestamp("UpdatedAt").toLocalDateTime());

                Object isDeletedObj = rs.getObject("isDeleted");
                if (isDeletedObj != null) {
                    deliveryOrder.setIsDeleted(rs.getBoolean("isDeleted"));
                } else {
                    deliveryOrder.setIsDeleted(false);
                }

                list.add(deliveryOrder);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalDeliveryOrders(int warehouseId, int deliveryOrderId) {
        String sql = "SELECT COUNT(*) FROM DeliveryOrders WHERE (isDeleted IS NULL OR isDeleted = 0) AND (? = -1 OR WarehouseID = ?) AND (? = -1 OR DeliveryOrderID = ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, warehouseId);
            pstmt.setInt(2, warehouseId);
            pstmt.setInt(3, deliveryOrderId);
            pstmt.setInt(4, deliveryOrderId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean softDeleteDeliveryOrder(int deliveryOrderId) {
        String sql = "UPDATE DeliveryOrders SET isDeleted = 1, UpdatedAt = ? WHERE DeliveryOrderID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            pstmt.setInt(2, deliveryOrderId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean restoreDeliveryOrder(int deliveryOrderId) {
        String sql = "UPDATE DeliveryOrders SET isDeleted = 0, UpdatedAt = ? WHERE DeliveryOrderID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            pstmt.setInt(2, deliveryOrderId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateDeliveryOrder(DeliveryOrder deliveryOrder) {
        String sql = "UPDATE DeliveryOrders SET DocumentStatus = ?, UpdatedAt = ? WHERE DeliveryOrderID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, deliveryOrder.getDocumentStatus());
            pstmt.setTimestamp(2, Timestamp.valueOf(deliveryOrder.getUpdatedAt()));
            pstmt.setInt(3, deliveryOrder.getDeliveryOrderId());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
