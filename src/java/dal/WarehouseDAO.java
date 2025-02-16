package dal;

import dal.DBContext;
import model.Warehouse;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WarehouseDAO {
    private Connection connection;

    public WarehouseDAO() {
        DBContext db = new DBContext();
        connection = db.connection;
    }

    public List<Warehouse> getAllWarehouses() {
        List<Warehouse> warehouses = new ArrayList<>();
        String sql = "SELECT * FROM Warehouses";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Warehouse warehouse = new Warehouse(
                    rs.getInt("WarehouseID"),
                    rs.getString("Name"),
                    rs.getString("Location")
                );
                warehouses.add(warehouse);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return warehouses;
    }

    public List<Warehouse> getWarehousesForManager(int managerID) {
        List<Warehouse> warehouses = new ArrayList<>();
        String sql = "SELECT w.* FROM Warehouses w " +
                    "INNER JOIN WarehouseManagers wm ON w.WarehouseID = wm.WarehouseID " +
                    "WHERE wm.ManagerID = ?";
                    
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, managerID);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Warehouse warehouse = new Warehouse(
                        rs.getInt("WarehouseID"),
                        rs.getString("Name"),
                        rs.getString("Location")
                    );
                    warehouses.add(warehouse);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return warehouses;
    }
}