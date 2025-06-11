package connection;

import model.Comments;
import connection.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {

    public boolean addComment(int maTinTuc, int userID, String noiDung) {
        String query = "INSERT INTO Comments (MaTinTuc, UserID, NoiDung) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, maTinTuc);
            stmt.setInt(2, userID);
            stmt.setString(3, noiDung);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Comments> getCommentsByNewsID(int maTinTuc) {
        List<Comments> comments = new ArrayList<>();
        String query = "SELECT c.MaBinhLuan, c.MaTinTuc, c.UserID, c.NoiDung, c.NgayBinhLuan, u.FullName " +
                      "FROM Comments c JOIN Users u ON c.UserID = u.UserID " +
                      "WHERE c.MaTinTuc = ? " +
                      "ORDER BY c.NgayBinhLuan DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, maTinTuc);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Comments comment = new Comments();
                comment.setCommentID(rs.getInt("MaBinhLuan")); 
                comment.setMaTinTuc(rs.getInt("MaTinTuc"));
                comment.setUserID(rs.getInt("UserID"));
                comment.setNoiDung(rs.getString("NoiDung"));
                comment.setNgayBinhLuan(rs.getTimestamp("NgayBinhLuan"));
                comment.setFullName(rs.getString("FullName"));
                comments.add(comment);
            }
            System.out.println("Fetched " + comments.size() + " comments for MaTinTuc: " + maTinTuc);
        } catch (SQLException e) {
            System.err.println("Error fetching comments for MaTinTuc: " + maTinTuc + " - " + e.getMessage());
            e.printStackTrace();
        }
        return comments;
    }
}