package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Stock;

public class StockDAO {

    private Connection connection;

    public StockDAO() {
        DBContext db = new DBContext();
        connection = db.connection;
    }

    public List<Stock> getStockForStaff(int staffID) {
        List<Stock> stockItems = new ArrayList<>();
        String sql = "SELECT s.* FROM Stock s " +
                    "INNER JOIN UserWarehouses uw ON s.WarehouseID = uw.WarehouseID " +
                    "WHERE uw.UserID = ?";
                    
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, staffID);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Stock stock = new Stock(
                        rs.getInt("StockID"),
                        rs.getInt("ProductID"),
                        rs.getInt("WarehouseID"),
                        rs.getInt("ZoneID"),
                        rs.getInt("BinID"),
                        rs.getInt("Quantity")
                    );
                    stockItems.add(stock);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Consider logging the error and throwing a custom exception
        }
        return stockItems;
    }
    
    public int getTotalQuantityForBin(int binID) {
        String sql = "SELECT SUM(Quantity) as total FROM Stock WHERE BinID = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, binID);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Consider logging the error and throwing a custom exception
        }
        return 0;
    }
}