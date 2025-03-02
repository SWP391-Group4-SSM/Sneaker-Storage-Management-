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

}
