package dal;

import model.Bin;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BinDAO extends DBContext {

    public List<Bin> getAll() {
        List<Bin> list = new ArrayList<>();
        String sql = "SELECT * FROM Bins";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Bin(
                        rs.getInt("binID"),
                        rs.getString("binName"),
                        rs.getString("description")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Bin> searchBins(String searchName) {
        List<Bin> list = new ArrayList<>();
        String sql = "SELECT * FROM Bins WHERE binName LIKE ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + searchName + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Bin(
                            rs.getInt("binID"),
                            rs.getString("binName"),
                            rs.getString("description")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Bin getBinByID(int binID) {
        String sql = "SELECT * FROM Bins WHERE binID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, binID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Bin(
                            rs.getInt("binID"),
                            rs.getString("binName"),
                            rs.getString("description")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addBin(Bin bin) {
        String sql = "INSERT INTO Bins (binName, description) VALUES (?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, bin.getBinName());
            ps.setString(2, bin.getDescription());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateBin(Bin bin) {
        String sql = "UPDATE Bins SET binName = ?, description = ? WHERE binID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, bin.getBinName());
            ps.setString(2, bin.getDescription());
            ps.setInt(3, bin.getBinID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteBin(int binID) {
        String sql = "DELETE FROM Bins WHERE binID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, binID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
