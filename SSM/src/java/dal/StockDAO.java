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


    public List<Stock> getAllStocks() {
        List<Stock> stocks = new ArrayList<>();
        String sql = "select * from Stock";
        try (PreparedStatement pstmt = connection.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {
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
    
    
}
