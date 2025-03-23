/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import model.Bin;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author Admin
 */
public class BinDAO {
    private Connection conn;

    public BinDAO() {
        DBContext db = new DBContext();
        conn = db.connection;
    }
    public List<Bin> getAllBins() {
        List<Bin> bins = new ArrayList<>();
        String sql = "SELECT * FROM Bins";
        
        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Bin bin = new Bin();
                bin.setBinID(rs.getInt("BinID"));
                bin.setSectionID(rs.getInt("SectionID"));
                bin.setBinName(rs.getString("BinName"));
                bin.setCapacity(rs.getInt("Capacity"));
                bin.setDescription(rs.getString("Description"));
                bin.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                bins.add(bin);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bins;
    }
}
