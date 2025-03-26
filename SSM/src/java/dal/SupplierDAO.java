package dal;

import model.Supplier;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SupplierDAO {

    private final Connection connection; // Final connection field

    public SupplierDAO() { // Constructor using DBContext
        DBContext db = new DBContext();
        connection = db.connection;
    }

    public Supplier getSupplierById(int supplierId) throws SQLException {
        String sql = "SELECT SupplierID, SupplierName, ContactEmail, ContactPhone, Address, CreatedAt, UpdatedAt FROM Suppliers WHERE SupplierID = ?";
        Supplier supplier = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            pstmt = connection.prepareStatement(sql);
            pstmt.setInt(1, supplierId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                supplier = mapSupplier(rs);
            }
        } finally {
            closeResources(pstmt, rs);
        }
        return supplier;
    }

    public List<Supplier> getAllSuppliers() {
        List<Supplier> suppliers = new ArrayList<>();
        String sql = "SELECT * FROM Suppliers";

        try (PreparedStatement pstmt = connection.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Supplier supplier = new Supplier();
                supplier.setSupplierID(rs.getInt("SupplierID"));
                supplier.setSupplierName(rs.getString("SupplierName"));
                supplier.setContactEmail(rs.getString("ContactEmail"));
                supplier.setContactPhone(rs.getString("ContactPhone"));
                supplier.setAddress(rs.getString("Address"));
                supplier.setCreatedAt(rs.getTimestamp("CreatedAt"));
                supplier.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
                suppliers.add(supplier);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return suppliers;
    }

    private Supplier mapSupplier(ResultSet rs) throws SQLException {
        Supplier supplier = new Supplier();
        supplier.setSupplierID(rs.getInt("SupplierID"));
        supplier.setSupplierName(rs.getString("SupplierName"));
        supplier.setContactEmail(rs.getString("ContactEmail"));
        supplier.setContactPhone(rs.getString("ContactPhone"));
        supplier.setAddress(rs.getString("Address"));
        supplier.setCreatedAt(rs.getDate("CreatedAt"));
        supplier.setUpdatedAt(rs.getDate("UpdatedAt"));
        return supplier;
    }
    
    public Map<Integer, String> getSupplierNamesMap() {
        Map<Integer, String> supplierMap = new HashMap<>();
        String sql = "SELECT SupplierID, SupplierName FROM Suppliers";
        
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            pstmt = connection.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                int id = rs.getInt("SupplierID");
                String name = rs.getString("SupplierName");
                supplierMap.put(id, name);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(pstmt, rs);
        }
        
        return supplierMap;
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
    }
}