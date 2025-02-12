package dao;

import util.DBConnection;
import model.Zone;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ZoneDAO {

    public List<Zone> getZonesByWarehouseId(int warehouseId) {
        List<Zone> zones = new ArrayList<>();
        String sql = "SELECT * FROM WarehouseZones WHERE WarehouseID = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, warehouseId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    zones.add(new Zone(
                            rs.getInt("ZoneID"),
                            rs.getInt("WarehouseID"),
                            rs.getString("ZoneName"),
                            rs.getInt("Capacity"),
                            rs.getString("Description")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return zones;
    }

    public Zone getZoneById(int id) {
        String sql = "SELECT * FROM WarehouseZones WHERE ZoneID = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Zone(
                            rs.getInt("ZoneID"),
                            rs.getInt("WarehouseID"),
                            rs.getString("ZoneName"),
                            rs.getInt("Capacity"),
                            rs.getString("Description")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addZone(Zone zone) {
        String sql = "INSERT INTO WarehouseZones (WarehouseID, ZoneName, Capacity, Description) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, zone.getWarehouseId());
            stmt.setString(2, zone.getName());
            stmt.setInt(3, zone.getCapacity());
            stmt.setString(4, zone.getDescription());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateZone(Zone zone) {
        String sql = "UPDATE WarehouseZones SET ZoneName = ?, Capacity = ?, Description = ? WHERE ZoneID = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, zone.getName());
            stmt.setInt(2, zone.getCapacity());
            stmt.setString(3, zone.getDescription());
            stmt.setInt(4, zone.getId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteZone(int id) {
        String sql = "DELETE FROM WarehouseZones WHERE ZoneID = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getCurrentCapacity(int zoneId) {
        String sql = "SELECT COUNT(*) AS CurrentCapacity FROM Bins WHERE ZoneID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, zoneId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("CurrentCapacity");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; 
    }

}
