package dal;

import model.Warehouse;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class WarehouseDAO {

    private Connection conn;

    public WarehouseDAO() {
        try {
            DBContext db = new DBContext();
            conn = db.connection;

            if (conn == null || conn.isClosed()) {
                System.err.println("ERROR: Database connection is null or closed in WarehouseDAO constructor");
            } else {
                System.out.println("Database connection established successfully in WarehouseDAO");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Warehouse getWarehouseById(int warehouseID) {
        String sql = "SELECT WarehouseID, WarehouseCode, Name, Location, CreatedAt FROM Warehouses WHERE WarehouseID = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, warehouseID);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Warehouse warehouse = new Warehouse();
                    warehouse.setWarehouseID(rs.getInt("WarehouseID"));
                    warehouse.setWarehouseCode(rs.getString("WarehouseCode"));
                    warehouse.setName(rs.getString("Name"));
                    warehouse.setLocation(rs.getString("Location"));
                    warehouse.setCreatedAt(rs.getTimestamp("CreatedAt"));

                    return warehouse;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<Warehouse> getAllWarehouses() {
        List<Warehouse> warehouses = new ArrayList<>();
        String sql = "SELECT WarehouseID, WarehouseCode, Name, Location, CreatedAt FROM Warehouses";

        try (PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Warehouse warehouse = new Warehouse();
                warehouse.setWarehouseID(rs.getInt("WarehouseID"));
                warehouse.setWarehouseCode(rs.getString("WarehouseCode"));
                warehouse.setName(rs.getString("Name"));
                warehouse.setLocation(rs.getString("Location"));
                warehouse.setCreatedAt(rs.getTimestamp("CreatedAt"));

                warehouses.add(warehouse);
            }

            System.out.println("Total warehouses loaded: " + warehouses.size());

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error loading warehouses: " + e.getMessage());
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
        String sql = "SELECT w.WarehouseID, w.WarehouseCode, w.Name, w.Location, w.CreatedAt "
                + "FROM Warehouses w "
                + "JOIN WarehouseManagers wm ON w.WarehouseID = wm.WarehouseID "
                + "WHERE wm.ManagerID = ?";
        List<Warehouse> warehouses = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            pstmt = conn.prepareStatement(sql);
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
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            if (pstmt != null) {
                pstmt.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // Connection is NOT closed here, relying on DBContext's management
    }
}
