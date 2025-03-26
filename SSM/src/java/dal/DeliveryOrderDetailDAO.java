//package dal;
//
//import model.DeliveryOrderDetail;
//import java.sql.*;
//import java.util.ArrayList;
//import java.util.List;
//
//public class DeliveryOrderDetailDAO {
//    private Connection connection;
//
//    public DeliveryOrderDetailDAO(Connection connection) {
//        this.connection = connection;
//    }
//
//    public void createDeliveryOrderDetail(DeliveryOrderDetail detail) throws SQLException {
//        String sql = "INSERT INTO DeliveryOrderDetails (DeliveryOrderID, ProductDetailID, QuantityOrdered, CreatedAt, UpdatedAt) " +
//                     "VALUES (?, ?, ?, ?, ?)";
//        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
//            stmt.setInt(1, detail.getDeliveryOrderID());
//            stmt.setInt(2, detail.getProductDetailID());
//            stmt.setInt(3, detail.getQuantityOrdered());
//            stmt.setTimestamp(4, new Timestamp(detail.getCreatedAt().getTime()));
//            stmt.setTimestamp(5, new Timestamp(detail.getUpdatedAt().getTime()));
//            stmt.executeUpdate();
//        }
//    }
//
//    public List<DeliveryOrderDetail> getDetailsByDeliveryOrderId(int deliveryOrderId) throws SQLException {
//        List<DeliveryOrderDetail> details = new ArrayList<>();
//        String sql = "SELECT * FROM DeliveryOrderDetails WHERE DeliveryOrderID = ?";
//        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
//            stmt.setInt(1, deliveryOrderId);
//            try (ResultSet rs = stmt.executeQuery()) {
//                while (rs.next()) {
//                    DeliveryOrderDetail detail = new DeliveryOrderDetail();
//                    detail.setDeliveryOrderDetailID(rs.getInt("DeliveryOrderDetailID"));
//                    detail.setDeliveryOrderID(rs.getInt("DeliveryOrderID"));
//                    detail.setProductDetailID(rs.getInt("ProductDetailID"));
//                    detail.setQuantityOrdered(rs.getInt("QuantityOrdered"));
//                    detail.setCreatedAt(rs.getTimestamp("CreatedAt"));
//                    detail.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
//                    details.add(detail);
//                }
//            }
//        }
//        return details;
//    }
//}