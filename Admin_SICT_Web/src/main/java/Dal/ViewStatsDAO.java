package Dal;

import Model.TinTuc;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ViewStatsDAO {
    private DBConnect dbConnect = new DBConnect();

    // Lấy danh sách bài báo theo khoảng thời gian với phân trang
    public List<TinTuc> getFilteredViews(Timestamp startDate, Timestamp endDate, int offset, int pageSize, String sortOrder) {
        List<TinTuc> filteredViews = new ArrayList<>();
        Map<Integer, Integer> filteredViewCounts = new HashMap<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT t.MaTinTuc, t.TieuDeTinTuc, t.SoLanDoc AS ViewCount " +
                     "FROM TinTuc t " +
                     "WHERE t.SoLanDoc  >= 1  ";
        if (startDate != null && endDate != null) {
            sql += "AND t.NgayCapNhat BETWEEN ? AND ? ";
        }
        sql += "ORDER BY t.SoLanDoc " + (sortOrder != null && sortOrder.equals("desc") ? "DESC" : "ASC") +
               " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            conn = dbConnect.getConnection();
            if (conn == null || conn.isClosed()) {
                System.err.println("Connection is null or closed, creating new instance.");
                dbConnect = new DBConnect(); // Tạo instance mới nếu kết nối bị đóng
                conn = dbConnect.getConnection();
            }
            pstmt = conn.prepareStatement(sql);
            int paramIndex = 1;
            if (startDate != null && endDate != null) {
                pstmt.setTimestamp(paramIndex++, startDate);
                pstmt.setTimestamp(paramIndex++, endDate);
            }
            pstmt.setInt(paramIndex++, offset);
            pstmt.setInt(paramIndex, pageSize);

            rs = pstmt.executeQuery();
            while (rs.next()) {
                TinTuc tinTuc = new TinTuc();
                tinTuc.setMaTinTuc(rs.getInt("MaTinTuc"));
                tinTuc.setTieuDeTinTuc(rs.getString("TieuDeTinTuc"));
                filteredViews.add(tinTuc);
                filteredViewCounts.put(tinTuc.getMaTinTuc(), rs.getInt("ViewCount"));
            }
            System.out.println("Fetched " + filteredViews.size() + " articles");
        } catch (SQLException e) {
            System.err.println("Database error in getFilteredViews: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                // Không đóng connection ở đây để tránh ảnh hưởng đến các file khác
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }

        ViewStatsDAO.filteredViewCounts = filteredViewCounts;
        return filteredViews;
    }

    private static Map<Integer, Integer> filteredViewCounts = new HashMap<>();

    public Map<Integer, Integer> getFilteredViewCounts() {
        return filteredViewCounts;
    }

    // Đếm tổng số bài báo để phân trang
    public int getTotalFilteredArticles(Timestamp startDate, Timestamp endDate) {
        int totalFilteredArticles = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT COUNT(DISTINCT t.MaTinTuc) AS total FROM TinTuc t WHERE t.SoLanDoc  >= 1";
        if (startDate != null && endDate != null) {
            sql += " AND t.NgayCapNhat BETWEEN ? AND ?";
        }

        try {
            conn = dbConnect.getConnection();
            if (conn == null || conn.isClosed()) {
                System.err.println("Connection is null or closed, creating new instance.");
                dbConnect = new DBConnect();
                conn = dbConnect.getConnection();
            }
            pstmt = conn.prepareStatement(sql);
            if (startDate != null && endDate != null) {
                pstmt.setTimestamp(1, startDate);
                pstmt.setTimestamp(2, endDate);
            }
            rs = pstmt.executeQuery();
            if (rs.next()) {
                totalFilteredArticles = rs.getInt("total");
            }
            System.out.println("Total filtered articles: " + totalFilteredArticles);
        } catch (SQLException e) {
            System.err.println("Database error in getTotalFilteredArticles: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
        return totalFilteredArticles;
    }

    // Lấy số lượt đọc theo ngày
    public Map<String, Integer> getDailyViewCounts(Timestamp startDate, Timestamp endDate) {
        Map<String, Integer> dailyViewCounts = new HashMap<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT CAST(t.NgayCapNhat AS DATE) AS ViewDate, SUM(t.SoLanDoc) AS ViewCount " +
                     "FROM TinTuc t " +
                     "WHERE t.SoLanDoc  >= 1 ";
        if (startDate != null && endDate != null) {
            sql += "AND t.NgayCapNhat BETWEEN ? AND ? ";
        }
        sql += "GROUP BY CAST(t.NgayCapNhat AS DATE) ORDER BY ViewDate ASC";

        try {
            conn = dbConnect.getConnection();
            if (conn == null || conn.isClosed()) {
                System.err.println("Connection is null or closed, creating new instance.");
                dbConnect = new DBConnect();
                conn = dbConnect.getConnection();
            }
            pstmt = conn.prepareStatement(sql);
            if (startDate != null && endDate != null) {
                pstmt.setTimestamp(1, startDate);
                pstmt.setTimestamp(2, endDate);
            }
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String viewDate = rs.getString("ViewDate");
                int viewCount = rs.getInt("ViewCount");
                dailyViewCounts.put(viewDate, viewCount);
            }
            System.out.println("Daily view counts: " + dailyViewCounts);
        } catch (SQLException e) {
            System.err.println("Database error in getDailyViewCounts: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
        return dailyViewCounts;
    }
}