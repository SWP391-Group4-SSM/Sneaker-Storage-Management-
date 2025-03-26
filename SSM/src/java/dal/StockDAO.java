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

    public List<Stock> getAllStocks(int page, int pageSize) {
        List<Stock> stocks = new ArrayList<>();
        String sql = "SELECT * FROM Stock ORDER BY StockID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, (page - 1) * pageSize);
            pstmt.setInt(2, pageSize);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Stock s = new Stock();
                s.setStockID(rs.getInt("StockID"));
                s.setProductDetailID(rs.getInt("ProductDetailID"));
                s.setWarehouseID(rs.getInt("WarehouseID"));
                s.setBinID(rs.getInt("BinID"));
                s.setQuantity(rs.getInt("Quantity"));
                s.setLastUpdated(rs.getTimestamp("LastUpdated").toLocalDateTime());
                stocks.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stocks;
    }
    public List<Stock> getAllStocks() {
        List<Stock> stocks = new ArrayList<>();
        String sql = "SELECT * FROM Stock ";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Stock s = new Stock();
                s.setStockID(rs.getInt("StockID"));
                s.setProductDetailID(rs.getInt("ProductDetailID"));
                s.setWarehouseID(rs.getInt("WarehouseID"));
                s.setBinID(rs.getInt("BinID"));
                s.setQuantity(rs.getInt("Quantity"));
                s.setLastUpdated(rs.getTimestamp("LastUpdated").toLocalDateTime());
                stocks.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stocks;
    }

    public int getTotalStocks() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM Stock";
        try (PreparedStatement pstmt = connection.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }
    
    public int getTotalQuantityByProductDetailId(int productDetailId) {
        String sql = "SELECT ISNULL(SUM(Quantity), 0) as TotalQuantity FROM Stock WHERE ProductDetailID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productDetailId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("TotalQuantity");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
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
                        rs.getInt("BinID"),
                        rs.getInt("Quantity"),
                        rs.getTimestamp("LastUpdated").toLocalDateTime()
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
