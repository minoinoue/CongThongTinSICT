package Dal;

import Model.BinhLuan;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class BinhLuanDAO extends DBConnect {

    public List<BinhLuan> getAllComments() {
        List<BinhLuan> list = new ArrayList<>();
        String sql = "SELECT c.MaBinhLuan, c.MaTinTuc, c.UserID, u.FullName, c.NoiDung, c.NgayBinhLuan, t.TieuDeTinTuc " +
                     "FROM Comments c " +
                     "JOIN Users u ON c.UserID = u.UserID " +
                     "JOIN TinTuc t ON c.MaTinTuc = t.MaTinTuc " +
                     "ORDER BY c.NgayBinhLuan DESC";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new BinhLuan(
                    rs.getInt("MaBinhLuan"),
                    rs.getInt("MaTinTuc"),
                    rs.getInt("UserID"),
                    rs.getString("FullName"),
                    rs.getString("NoiDung"),
                    rs.getTimestamp("NgayBinhLuan"),
                    rs.getString("TieuDeTinTuc") // Sử dụng TieuDeTinTuc
                ));
            }
            System.out.println("Fetched " + list.size() + " comments");
        } catch (SQLException e) {
            System.err.println("Database error in getAllComments: " + e.getMessage());
        }
        return list;
    }

    public List<BinhLuan> getCommentsByPage(int page, int pageSize) {
        List<BinhLuan> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = "SELECT c.MaBinhLuan, c.MaTinTuc, c.UserID, u.FullName, c.NoiDung, c.NgayBinhLuan, t.TieuDeTinTuc " +
                     "FROM Comments c " +
                     "JOIN Users u ON c.UserID = u.UserID " +
                     "JOIN TinTuc t ON c.MaTinTuc = t.MaTinTuc " +
                     "ORDER BY c.NgayBinhLuan DESC " +
                     "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, offset);
            st.setInt(2, pageSize);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new BinhLuan(
                    rs.getInt("MaBinhLuan"),
                    rs.getInt("MaTinTuc"),
                    rs.getInt("UserID"),
                    rs.getString("FullName"),
                    rs.getString("NoiDung"),
                    rs.getTimestamp("NgayBinhLuan"),
                    rs.getString("TieuDeTinTuc") // Sử dụng TieuDeTinTuc
                ));
            }
            System.out.println("Fetched " + list.size() + " comments for page " + page);
        } catch (SQLException e) {
            System.err.println("Database error in getCommentsByPage: " + e.getMessage());
        }
        return list;
    }

    public int getTotalCommentCount() {
        String sql = "SELECT COUNT(*) FROM Comments";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Database error in getTotalCommentCount: " + e.getMessage());
        }
        return 0;
    }

    public void deleteComment(int commentId) {
        String sql = "DELETE FROM Comments WHERE MaBinhLuan = ?";
        try (PreparedStatement st = getConnection().prepareStatement(sql)) {
            st.setInt(1, commentId);
            int rowsAffected = st.executeUpdate();
            System.out.println("Deleted comment ID: " + commentId + ", Rows affected: " + rowsAffected);
        } catch (SQLException e) {
            System.err.println("Error deleting comment: " + e.getMessage());
            throw new RuntimeException("Failed to delete comment: " + e.getMessage());
        }
    }
}	