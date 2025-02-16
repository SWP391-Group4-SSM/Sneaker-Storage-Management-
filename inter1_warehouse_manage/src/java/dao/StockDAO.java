package dao;

import model.Stock;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StockDAO {
    
    public void addStock(Stock stock) {
        String sql = "INSERT INTO Stock (ProductID, WarehouseID, ZoneID, BinID, Quantity, LastUpdated) VALUES (?, ?, ?, ?, ?, GETDATE())";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, stock.getProductID());
            stmt.setInt(2, stock.getWarehouseID());
            stmt.setInt(3, stock.getZoneID());
            stmt.setInt(4, stock.getBinID());
            stmt.setInt(5, stock.getQuantity());
            stmt.executeUpdate();
            System.out.println("Stock added successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Stock> getAllStocks() {
        List<Stock> stockList = new ArrayList<>();
        String sql = "SELECT * FROM Stock";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                stockList.add(new Stock(
                    rs.getInt("StockID"),
                    rs.getInt("ProductID"),
                    rs.getInt("WarehouseID"),
                    rs.getInt("ZoneID"),
                    rs.getInt("BinID"),
                    rs.getInt("Quantity"),
                    rs.getTimestamp("LastUpdated")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stockList;
    }

    public void updateStockQuantity(int stockID, int quantity) {
        String sql = "UPDATE Stock SET Quantity = ?, LastUpdated = GETDATE() WHERE StockID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, quantity);
            stmt.setInt(2, stockID);
            stmt.executeUpdate();
            System.out.println("Stock updated successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteStock(int stockID) {
        String sql = "DELETE FROM Stock WHERE StockID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, stockID);
            stmt.executeUpdate();
            System.out.println("Stock deleted successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

