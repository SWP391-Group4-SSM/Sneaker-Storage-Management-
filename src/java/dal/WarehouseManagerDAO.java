package dal;

import dal.DBContext;
import model.WarehouseManager;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WarehouseManagerDAO {

    private Connection connection;

    public WarehouseManagerDAO() {
        DBContext db = new DBContext();
        connection = db.connection;
    }

    // Get all warehouses assigned to a specific manager
    public List<WarehouseManager> getWarehousesForManager(int managerID) {
        List<WarehouseManager> warehouseManagers = new ArrayList<>();
        String sql = "SELECT * FROM WarehouseManagers WHERE ManagerID = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, managerID);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                warehouseManagers.add(new WarehouseManager(
                        rs.getInt("ManagerID"),
                        rs.getInt("WarehouseID")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return warehouseManagers;
    }
}
