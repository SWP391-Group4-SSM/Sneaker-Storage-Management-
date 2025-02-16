package dal;

import util.DBConnection;
import model.Warehouse2;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WarehouseDAO2 {

    public List<Warehouse2> getAllWarehouses() {
        List<Warehouse2> warehouses = new ArrayList<>();
        String sql = "SELECT * FROM Warehouses";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                warehouses.add(new Warehouse2(
                        rs.getInt("WarehouseID"),
                        rs.getString("Name"),
                        rs.getString("Location")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return warehouses;
    }

    public Warehouse2 getWarehouseById(int id) {
        String sql = "SELECT * FROM Warehouses WHERE WarehouseID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Warehouse2(
                            rs.getInt("WarehouseID"),
                            rs.getString("Name"),
                            rs.getString("Location")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Warehouse2 getWarehouseByName(String name) {
        String sql = "SELECT * FROM Warehouses WHERE Name = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, name);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Warehouse2(
                            rs.getInt("WarehouseID"),
                            rs.getString("Name"),
                            rs.getString("Location")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addWarehouse(Warehouse2 warehouse) {
        String sql = "INSERT INTO Warehouses (Name, Location) VALUES (?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, warehouse.getName());
            stmt.setString(2, warehouse.getLocation());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateWarehouse(Warehouse2 warehouse) {
        String sql = "UPDATE Warehouses SET Name = ?, Location = ? WHERE WarehouseID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, warehouse.getName());
            stmt.setString(2, warehouse.getLocation());
            stmt.setInt(3, warehouse.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteWarehouse(int id) {
        String sql = "DELETE FROM Warehouses WHERE WarehouseID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int countWarehouses() {
        String sql = "SELECT COUNT(*) FROM Warehouses";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean exists(int id) {
        String sql = "SELECT 1 FROM Warehouses WHERE WarehouseID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next(); // Nếu có dòng dữ liệu => Warehouse tồn tại
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public String getWarehouseNameById(int warehouseId) {
        String sql = "SELECT Name FROM Warehouses WHERE WarehouseID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, warehouseId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("Name");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
}
