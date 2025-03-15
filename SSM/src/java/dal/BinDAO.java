package dal;

import model.Bin;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BinDAO {
    private Connection connection;

    public BinDAO() {
        DBContext db = new DBContext();
        connection = db.connection;
    }

    public boolean addBin(Bin bin) {
        String sql = "INSERT INTO Bins (BinID, SectionID, BinName, Capacity, Description, CreatedAt, isDeleted) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, bin.getBinID());
            stmt.setInt(2, bin.getSectionID());
            stmt.setString(3, bin.getBinName());
            stmt.setInt(4, bin.getCapacity());
            stmt.setString(5, bin.getDescription());
            stmt.setTimestamp(6, bin.getCreatedAt());
            stmt.setBoolean(7, bin.isDeleted());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to check if a BinID already exists
    public boolean isBinIdExist(int binId) {
        String sql = "SELECT COUNT(*) FROM Bins WHERE BinID = ? AND isDeleted = 0";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, binId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to check if a BinName already exists
    public boolean isBinNameExist(String binName) {
        String sql = "SELECT COUNT(*) FROM Bins WHERE BinName = ? AND isDeleted = 0";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, binName);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to get all bins with pagination
    public List<Bin> getAll(int page, int pageSize) {
        List<Bin> bins = new ArrayList<>();
        String sql = "SELECT * FROM Bins WHERE isDeleted = 0 ORDER BY BinID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, (page - 1) * pageSize);
            stmt.setInt(2, pageSize);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Bin bin = new Bin(
                        rs.getInt("BinID"),
                        rs.getInt("SectionID"),
                        rs.getString("BinName"),
                        rs.getInt("Capacity"),
                        rs.getString("Description"),
                        rs.getTimestamp("CreatedAt"),
                        rs.getBoolean("isDeleted")
                    );
                    bins.add(bin);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bins;
    }

    // Method to get a bin by ID
    public Bin getBinById(int binID) {
        Bin bin = null;
        String sql = "SELECT * FROM Bins WHERE BinID = ? AND isDeleted = 0";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, binID);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    bin = new Bin(
                        rs.getInt("BinID"),
                        rs.getInt("SectionID"),
                        rs.getString("BinName"),
                        rs.getInt("Capacity"),
                        rs.getString("Description"),
                        rs.getTimestamp("CreatedAt"),
                        rs.getBoolean("isDeleted")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bin;
    }

    // Method to update a bin
    public void updateBin(Bin bin) {
        String sql = "UPDATE Bins SET SectionID = ?, BinName = ?, Capacity = ?, Description = ?, CreatedAt = ? WHERE BinID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, bin.getSectionID());
            stmt.setString(2, bin.getBinName());
            stmt.setInt(3, bin.getCapacity());
            stmt.setString(4, bin.getDescription());
            stmt.setTimestamp(5, bin.getCreatedAt());
            stmt.setInt(6, bin.getBinID());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to delete a bin (soft delete)
    public void deleteBin(int binID) {
        String sql = "UPDATE Bins SET isDeleted = 1 WHERE BinID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, binID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to search bins by name with pagination
    public List<Bin> searchBinsByName(String binName, int page, int pageSize) {
        List<Bin> bins = new ArrayList<>();
        String sql = "SELECT * FROM Bins WHERE isDeleted = 0 AND BinName LIKE ? ORDER BY BinID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, "%" + binName + "%");
            stmt.setInt(2, (page - 1) * pageSize);
            stmt.setInt(3, pageSize);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Bin bin = new Bin(
                        rs.getInt("BinID"),
                        rs.getInt("SectionID"),
                        rs.getString("BinName"),
                        rs.getInt("Capacity"),
                        rs.getString("Description"),
                        rs.getTimestamp("CreatedAt"),
                        rs.getBoolean("isDeleted")
                    );
                    bins.add(bin);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bins;
    }
}