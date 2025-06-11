package Dal;

import Model.TheLoai;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TheLoaiDAO {
    private DBConnect dbConnect;

    public TheLoaiDAO() {
        dbConnect = new DBConnect();
    }

    // Lấy danh sách thể loại hiển thị
    public List<TheLoai> getVisibleTheLoaiList() throws SQLException {
        List<TheLoai> theLoaiList = new ArrayList<>();
        Connection conn = dbConnect.getConnection();
        String sql = "SELECT * FROM TheLoai WHERE VisibleTheLoai = 1";
        
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                TheLoai theLoai = new TheLoai();
                theLoai.setMaTheLoai(rs.getInt("MaTheLoai"));
                theLoai.setTenTheLoai(rs.getString("TenTheLoai"));
                theLoai.setVisibleTheLoai(rs.getBoolean("VisibleTheLoai"));
                theLoai.setVisibleTheLoai1(rs.getBoolean("VisibleTheLoai1"));
                theLoai.setSapXep(rs.getInt("SapXep"));
                theLoai.setUrl(rs.getString("Url"));
                theLoai.setTarget(rs.getString("Target"));
                theLoai.setLinkNgoai(rs.getBoolean("LinkNgoai"));
                theLoaiList.add(theLoai);
            }
        } finally {
            dbConnect.closeConnection();
        }
        
        return theLoaiList;
    }

    // Lấy tên thể loại theo MaTheLoai
    public String getTenTheLoai(int maTheLoai) throws SQLException {
        String tenTheLoai = "";
        Connection conn = dbConnect.getConnection();
        String sql = "SELECT TenTheLoai FROM TheLoai WHERE MaTheLoai = ?";
        
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, maTheLoai);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                tenTheLoai = rs.getString("TenTheLoai");
            }
        } finally {
            dbConnect.closeConnection();
        }
        
        return tenTheLoai;
    }
}