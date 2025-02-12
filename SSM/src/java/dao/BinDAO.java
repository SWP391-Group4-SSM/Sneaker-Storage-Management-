package dao;

import util.DBConnection;
import model.Bin;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BinDAO {

    public List<Bin> getAllBins() {
        List<Bin> bins = new ArrayList<>();
        String sql = "SELECT * FROM Bins";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                bins.add(new Bin(
                        rs.getInt("BinID"),
                        rs.getInt("ZoneID"),
                        rs.getString("BinName"),
                        rs.getInt("Capacity"),
                        rs.getInt("CurrentLoad"),
                        rs.getString("Description"), 
                        rs.getTimestamp("CreatedAt")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bins;
    }

    public boolean addBin(Bin bin) {
        String sql = "INSERT INTO Bins (ZoneID, BinName, Capacity, CurrentLoad, Description, CreatedAt) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bin.getZoneId());
            stmt.setString(2, bin.getName());
            stmt.setInt(3, bin.getCapacity());
            stmt.setInt(4, bin.getCurrentLoad()); 
            stmt.setString(5, bin.getDescription()); 
            stmt.setTimestamp(6, new Timestamp(System.currentTimeMillis()));

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateBin(Bin bin) {
        String sql = "UPDATE Bins SET ZoneID = ?, BinName = ?, Capacity = ?, CurrentLoad = ?, Description = ? WHERE BinID = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bin.getZoneId());
            stmt.setString(2, bin.getName());
            stmt.setInt(3, bin.getCapacity());
            stmt.setInt(4, bin.getCurrentLoad()); 
            stmt.setString(5, bin.getDescription());
            stmt.setInt(6, bin.getId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteBin(int id) {
        String sql = "DELETE FROM Bins WHERE BinID = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Bin> getBinsByZoneId(int zoneId) {
        List<Bin> bins = new ArrayList<>();
        String sql = "SELECT * FROM Bins WHERE ZoneID = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, zoneId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    bins.add(new Bin(
                            rs.getInt("BinID"),
                            rs.getInt("ZoneID"),
                            rs.getString("BinName"),
                            rs.getInt("Capacity"),
                            rs.getInt("CurrentLoad"),
                            rs.getString("Description"), 
                            rs.getTimestamp("CreatedAt")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bins;
    }

    public Bin getBinById(int id) {
        String sql = "SELECT * FROM Bins WHERE BinID = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Bin(
                            rs.getInt("BinID"),
                            rs.getInt("ZoneID"),
                            rs.getString("BinName"),
                            rs.getInt("Capacity"),
                            rs.getInt("CurrentLoad"),
                            rs.getString("Description"),
                            rs.getTimestamp("CreatedAt")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getTotalBinCapacityByZoneId(int zoneId) {
        String sql = "SELECT SUM(Capacity) AS TotalCapacity FROM Bins WHERE ZoneID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, zoneId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("TotalCapacity");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

}
