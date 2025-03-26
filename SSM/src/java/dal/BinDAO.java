package dal;

import model.Bin;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BinDAO {
    private Connection conn;

    public BinDAO() {
        DBContext db = new DBContext();
        conn = db.connection;
    }

    // Lấy danh sách bin tạm theo WarehouseID
    public List<Bin> getTemporaryBins(int warehouseId) {
        List<Bin> bins = new ArrayList<>();
        String sql = "SELECT * FROM Bins WHERE WarehouseID = ? AND BinType = 'Temporary'";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, warehouseId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Bin bin = new Bin();
                bin.setBinId(rs.getInt("BinID"));
                bins.add(bin);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bins;
    }
}