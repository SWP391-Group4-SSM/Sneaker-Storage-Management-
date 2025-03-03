package dal;

import model.Warehouse;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class WarehouseDAO {
    private final Connection connection;

    public WarehouseDAO() {
        DBContext db = new DBContext();
        connection = db.connection;
    }

 public Warehouse getWarehouseById(int warehouseId) throws SQLException {
        String sql = "SELECT WarehouseID, WarehouseCode, Name, Location, CreatedAt FROM Warehouses WHERE WarehouseID = ?";
        Warehouse warehouse = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            pstmt = connection.prepareStatement(sql);
            pstmt.setInt(1, warehouseId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                warehouse = mapWarehouse(rs);
            }
        } finally {
            closeResources(pstmt, rs);
        }
        return warehouse;
    }

    public List<Warehouse> getAllWarehouses() {
        List<Warehouse> warehouses = new ArrayList<>();
        String sql = "SELECT * FROM Warehouses";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Warehouse warehouse = new Warehouse();
                warehouse.setWarehouseID(rs.getInt("WarehouseID"));
                warehouse.setWarehouseCode(rs.getString("WarehouseCode"));
                warehouse.setName(rs.getString("Name"));
                warehouse.setLocation(rs.getString("Location"));
                warehouse.setCreatedAt(rs.getTimestamp("CreatedAt"));
                warehouses.add(warehouse);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return warehouses;
    }

    private Warehouse mapWarehouse(ResultSet rs) throws SQLException {
        Warehouse warehouse = new Warehouse();
        warehouse.setWarehouseID(rs.getInt("WarehouseID"));
        warehouse.setWarehouseCode(rs.getString("WarehouseCode"));
        warehouse.setName(rs.getString("Name"));
        warehouse.setLocation(rs.getString("Location"));
        warehouse.setCreatedAt(rs.getDate("CreatedAt"));
        return warehouse;
    }
    
    public List<Warehouse> getWarehousesForManager(int managerId) throws SQLException {
        String sql = "SELECT w.WarehouseID, w.WarehouseCode, w.Name, w.Location, w.CreatedAt " +
                     "FROM Warehouses w " +
                     "JOIN WarehouseManagers wm ON w.WarehouseID = wm.WarehouseID " +
                     "WHERE wm.ManagerID = ?";
        List<Warehouse> warehouses = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            pstmt = connection.prepareStatement(sql);
            pstmt.setInt(1, managerId); 
            rs = pstmt.executeQuery();

            while (rs.next()) {
                warehouses.add(mapWarehouse(rs));
            }
        } finally {
            closeResources(pstmt, rs);
        }
        return warehouses;
    }

    private void closeResources(PreparedStatement pstmt, ResultSet rs) {
try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        // Connection is NOT closed here, relying on DBContext's management
    }
}