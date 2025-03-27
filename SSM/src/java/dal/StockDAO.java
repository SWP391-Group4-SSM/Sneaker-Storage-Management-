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
        String sql = "SELECT s.* FROM Stock s "
                + "INNER JOIN UserWarehouses uw ON s.WarehouseID = uw.WarehouseID "
                + "WHERE uw.UserID = ?";

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, staffID);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Stock stock = new Stock(
                            rs.getInt("StockID"),
                            rs.getInt("ProductDetailID"),
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

    public Stock getStockByProductAndBin(int productDetailId, int binId) {
        String sql = "SELECT * FROM Stock WHERE ProductDetailID = ? AND BinID = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, productDetailId);
            pstmt.setInt(2, binId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Stock stock = new Stock();
                stock.setStockId(rs.getInt("StockID"));
                stock.setProductDetailId(rs.getInt("ProductDetailID"));
                stock.setWarehouseId(rs.getInt("WarehouseID"));
                stock.setBinId(rs.getInt("BinID"));
                stock.setQuantity(rs.getInt("Quantity"));
                stock.setLastUpdated(rs.getTimestamp("LastUpdated").toLocalDateTime());
                return stock;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật số lượng stock
    public void updateStock(Stock stock) {
        String sql = "UPDATE Stock SET Quantity = ?, LastUpdated = CURRENT_TIMESTAMP WHERE StockID = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, stock.getQuantity());
            pstmt.setInt(2, stock.getStockId());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Thêm mới stock
    public void addStock(Stock stock) {
        String sql = "INSERT INTO Stock (ProductDetailID, WarehouseID, BinID, Quantity, LastUpdated) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, stock.getProductDetailId());
            pstmt.setInt(2, stock.getWarehouseId());
            pstmt.setInt(3, stock.getBinId());
            pstmt.setInt(4, stock.getQuantity());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Add to your existing StockDAO class
    public List<Stock> getAllStocks() {
        List<Stock> stocks = new ArrayList<>();
        String sql = "SELECT * FROM Stock";

        try (PreparedStatement pstmt = connection.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Stock stock = new Stock();
                stock.setStockId(rs.getInt("StockID"));
                stock.setProductDetailId(rs.getInt("ProductDetailID"));
                stock.setWarehouseId(rs.getInt("WarehouseID"));
                stock.setBinId(rs.getInt("BinID"));
                stock.setQuantity(rs.getInt("Quantity"));
                if (rs.getTimestamp("LastUpdated") != null) {
                    stock.setLastUpdated(rs.getTimestamp("LastUpdated").toLocalDateTime());
                }
                stocks.add(stock);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return stocks;
    }
}
