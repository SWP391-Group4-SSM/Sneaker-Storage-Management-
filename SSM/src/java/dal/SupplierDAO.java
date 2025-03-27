package dal;

import model.Supplier;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SupplierDAO {
    private Connection connection;

    public SupplierDAO() {
        DBContext db = new DBContext();
        connection = db.connection;
    }

    public boolean addSupplier(Supplier supplier) {
        String sql = "INSERT INTO Suppliers (SupplierID, SupplierName, ContactEmail, ContactPhone, Address, CreatedAt, UpdatedAt, isDeleted) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, supplier.getSupplierID());
            stmt.setString(2, supplier.getSupplierName());
            stmt.setString(3, supplier.getContactEmail());
            stmt.setString(4, supplier.getContactPhone());
            stmt.setString(5, supplier.getAddress());
            stmt.setTimestamp(6, supplier.getCreatedAt());
            stmt.setTimestamp(7, supplier.getUpdatedAt());
            stmt.setBoolean(8, supplier.isDeleted());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isSupplierIdExist(int supplierID) {
        String sql = "SELECT COUNT(*) FROM Suppliers WHERE SupplierID = ? AND isDeleted = 0";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, supplierID);
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

    public List<Supplier> getAll(int page, int pageSize) {
        List<Supplier> suppliers = new ArrayList<>();
        String sql = "SELECT * FROM Suppliers WHERE isDeleted = 0 ORDER BY SupplierID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, (page - 1) * pageSize);
            stmt.setInt(2, pageSize);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Supplier supplier = new Supplier(
                        rs.getInt("SupplierID"),
                        rs.getString("SupplierName"),
                        rs.getString("ContactEmail"),
                        rs.getString("ContactPhone"),
                        rs.getString("Address"),
                        rs.getTimestamp("CreatedAt"),
                        rs.getTimestamp("UpdatedAt"),
                        rs.getBoolean("isDeleted")
                    );
                    suppliers.add(supplier);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return suppliers;
    }

    public Supplier getSupplierById(int supplierID) {
        Supplier supplier = null;
        String sql = "SELECT * FROM Suppliers WHERE SupplierID = ? AND isDeleted = 0";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, supplierID);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    supplier = new Supplier(
                        rs.getInt("SupplierID"),
                        rs.getString("SupplierName"),
                        rs.getString("ContactEmail"),
                        rs.getString("ContactPhone"),
                        rs.getString("Address"),
                        rs.getTimestamp("CreatedAt"),
                        rs.getTimestamp("UpdatedAt"),
                        rs.getBoolean("isDeleted")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return supplier;
    }

    public void updateSupplier(Supplier supplier) {
        String sql = "UPDATE Suppliers SET SupplierName = ?, ContactEmail = ?, ContactPhone = ?, Address = ?, UpdatedAt = ? WHERE SupplierID = ? AND isDeleted = 0";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, supplier.getSupplierName());
            stmt.setString(2, supplier.getContactEmail());
            stmt.setString(3, supplier.getContactPhone());
            stmt.setString(4, supplier.getAddress());
            stmt.setTimestamp(5, supplier.getUpdatedAt());
            stmt.setInt(6, supplier.getSupplierID());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteSupplier(int supplierID) {
        String sql = "UPDATE Suppliers SET isDeleted = 1 WHERE SupplierID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, supplierID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Supplier> searchSuppliers(String supplierName, String contactEmail, String contactPhone, int page, int pageSize) {
        List<Supplier> suppliers = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Suppliers WHERE isDeleted = 0");
        
        if (supplierName != null && !supplierName.isEmpty()) {
            sql.append(" AND SupplierName LIKE ?");
        }
        if (contactEmail != null && !contactEmail.isEmpty()) {
            sql.append(" AND ContactEmail LIKE ?");
        }
        if (contactPhone != null && !contactPhone.isEmpty()) {
            sql.append(" AND ContactPhone LIKE ?");
        }
        
        sql.append(" ORDER BY SupplierID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            int index = 1;
            if (supplierName != null && !supplierName.isEmpty()) {
                stmt.setString(index++, "%" + supplierName + "%");
            }
            if (contactEmail != null && !contactEmail.isEmpty()) {
                stmt.setString(index++, "%" + contactEmail + "%");
            }
            if (contactPhone != null && !contactPhone.isEmpty()) {
                stmt.setString(index++, "%" + contactPhone + "%");
            }
            stmt.setInt(index++, (page - 1) * pageSize);
            stmt.setInt(index, pageSize);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Supplier supplier = new Supplier(
                        rs.getInt("SupplierID"),
                        rs.getString("SupplierName"),
                        rs.getString("ContactEmail"),
                        rs.getString("ContactPhone"),
                        rs.getString("Address"),
                        rs.getTimestamp("CreatedAt"),
                        rs.getTimestamp("UpdatedAt"),
                        rs.getBoolean("isDeleted")
                    );
                    suppliers.add(supplier);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return suppliers;
    }
}