package dal;

import model.WarehouseSection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WarehouseSectionDAO {
    private Connection connection;

    public WarehouseSectionDAO() {
        DBContext db = new DBContext();
        connection = db.connection;
    }

    // Lấy danh sách tất cả các khu vực trong kho
    public List<WarehouseSection> getAllSections() {
        List<WarehouseSection> sections = new ArrayList<>();
        String sql = "SELECT * FROM WarehouseSections";

        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                WarehouseSection section = new WarehouseSection(
                    rs.getInt("SectionID"),
                    rs.getInt("WarehouseID"),
                    rs.getString("SectionName"),
                    rs.getInt("Capacity"),
                    rs.getString("Description"),
                    rs.getTimestamp("CreatedAt")
                );
                sections.add(section);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sections;
    }

    // Lấy danh sách các khu vực trong một kho cụ thể
    public List<WarehouseSection> getSectionsByWarehouseID(int warehouseID) {
        List<WarehouseSection> sections = new ArrayList<>();
        String sql = "SELECT * FROM WarehouseSections WHERE WarehouseID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, warehouseID);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    WarehouseSection section = new WarehouseSection(
                        rs.getInt("SectionID"),
                        rs.getInt("WarehouseID"),
                        rs.getString("SectionName"),
                        rs.getInt("Capacity"),
                        rs.getString("Description"),
                        rs.getTimestamp("CreatedAt")
                    );
                    sections.add(section);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sections;
    }

    // Thêm một khu vực kho mới
    public boolean addSection(WarehouseSection section) {
        String sql = "INSERT INTO WarehouseSections (WarehouseID, SectionName, Capacity, Description, CreatedAt) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, section.getWarehouseID());
            stmt.setString(2, section.getSectionName());
            stmt.setInt(3, section.getCapacity());
            stmt.setString(4, section.getDescription());
            stmt.setTimestamp(5, section.getCreatedAt());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật thông tin khu vực kho
    public boolean updateSection(WarehouseSection section) {
        String sql = "UPDATE WarehouseSections SET WarehouseID = ?, SectionName = ?, Capacity = ?, Description = ? WHERE SectionID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, section.getWarehouseID());
            stmt.setString(2, section.getSectionName());
            stmt.setInt(3, section.getCapacity());
            stmt.setString(4, section.getDescription());
            stmt.setInt(5, section.getSectionID());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa một khu vực kho
    public boolean deleteSection(int sectionID) {
        String sql = "DELETE FROM WarehouseSections WHERE SectionID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, sectionID);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
