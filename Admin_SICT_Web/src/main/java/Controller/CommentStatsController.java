package Controller;

import Dal.DBConnect;
import Model.TinTuc;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CommentStatsController extends HttpServlet {
    private static final int PAGE_SIZE = 10; // Số bài báo mỗi trang

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        DBConnect db = new DBConnect();
        Connection conn = db.getConnection();
        List<TinTuc> overallComments = new ArrayList<>();
        List<TinTuc> filteredComments = new ArrayList<>();
        Map<Integer, Integer> overallCommentCounts = new HashMap<>();
        Map<Integer, Integer> filteredCommentCounts = new HashMap<>();
        // Thêm danh sách để lưu thống kê bình luận theo ngày
        Map<String, Integer> dailyCommentCounts = new HashMap<>();

        try {
            // Lấy tham số page và sort từ request cho Tổng quát
            String pageStr = request.getParameter("page");
            String sortOrder = request.getParameter("sort");
            int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
            int offset = (page - 1) * PAGE_SIZE;

            // Lấy tổng số bài báo có bình luận để tính số trang cho Tổng quát
            String sqlCount = "SELECT COUNT(DISTINCT t.MaTinTuc) AS total FROM TinTuc t " +
                            "LEFT JOIN Comments c ON t.MaTinTuc = c.MaTinTuc " +
                            "WHERE c.MaBinhLuan IS NOT NULL";
            int totalArticles = 0;
            try (PreparedStatement pstmtCount = conn.prepareStatement(sqlCount)) {
                ResultSet rsCount = pstmtCount.executeQuery();
                if (rsCount.next()) {
                    totalArticles = rsCount.getInt("total");
                }
            }
            int totalPages = (int) Math.ceil((double) totalArticles / PAGE_SIZE);

            // Thống kê tổng quát (tất cả thời gian) với phân trang
            String sqlOverall = "SELECT t.MaTinTuc, t.TieuDeTinTuc, COUNT(c.MaBinhLuan) AS CommentCount " +
                              "FROM TinTuc t " +
                              "LEFT JOIN Comments c ON t.MaTinTuc = c.MaTinTuc " +
                              "WHERE c.MaBinhLuan IS NOT NULL " +
                              "GROUP BY t.MaTinTuc, t.TieuDeTinTuc " +
                              "ORDER BY CommentCount " + (sortOrder != null && sortOrder.equals("desc") ? "DESC" : "ASC") +
                              " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
            try (PreparedStatement pstmt = conn.prepareStatement(sqlOverall)) {
                pstmt.setInt(1, offset);
                pstmt.setInt(2, PAGE_SIZE);
                ResultSet rs = pstmt.executeQuery();
                while (rs.next()) {
                    TinTuc tinTuc = new TinTuc();
                    tinTuc.setMaTinTuc(rs.getInt("MaTinTuc"));
                    tinTuc.setTieuDeTinTuc(rs.getString("TieuDeTinTuc"));
                    overallComments.add(tinTuc);
                    overallCommentCounts.put(tinTuc.getMaTinTuc(), rs.getInt("CommentCount"));
                }
            }

            // Lấy tham số startDate, endDate, filteredPage và sort từ request
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String filteredPageStr = request.getParameter("filteredPage"); // Trang cho phần Theo khoảng thời gian
            int filteredPage = (filteredPageStr != null && !filteredPageStr.isEmpty()) ? Integer.parseInt(filteredPageStr) : 1;
            int filteredOffset = (filteredPage - 1) * PAGE_SIZE;

            // Thiết lập giá trị mặc định cho ngày
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = null;
            Date endDate = null;

            try {
                if (startDateStr != null && !startDateStr.isEmpty()) {
                    startDate = dateFormat.parse(startDateStr);
                } else {
                    startDate = dateFormat.parse("2025-05-01");
                }

                if (endDateStr != null && !endDateStr.isEmpty()) {
                    endDate = dateFormat.parse(endDateStr);
                } else {
                    endDate = new Date(); // Ngày hiện tại: 2025-05-29
                }
            } catch (ParseException e) {
                request.setAttribute("error", "Định dạng ngày không hợp lệ: " + e.getMessage());
                startDate = new Date();
                endDate = new Date();
            }

            // Tính tổng số bài báo có bình luận trong khoảng thời gian để phân trang
            int totalFilteredArticles = 0;
            if (startDateStr != null || endDateStr != null) {
                String sqlFilteredCount = "SELECT COUNT(DISTINCT t.MaTinTuc) AS total FROM TinTuc t " +
                                        "LEFT JOIN Comments c ON t.MaTinTuc = c.MaTinTuc " +
                                        "WHERE c.NgayBinhLuan BETWEEN ? AND ? AND c.MaBinhLuan IS NOT NULL";
                try (PreparedStatement pstmtCount = conn.prepareStatement(sqlFilteredCount)) {
                    pstmtCount.setTimestamp(1, new java.sql.Timestamp(startDate.getTime()));
                    pstmtCount.setTimestamp(2, new java.sql.Timestamp(endDate.getTime()));
                    ResultSet rsCount = pstmtCount.executeQuery();
                    if (rsCount.next()) {
                        totalFilteredArticles = rsCount.getInt("total");
                    }
                }
            }
            int totalFilteredPages = (int) Math.ceil((double) totalFilteredArticles / PAGE_SIZE);

            // Thống kê theo khoảng thời gian với phân trang
            if (startDateStr != null || endDateStr != null) {
                String sqlFiltered = "SELECT t.MaTinTuc, t.TieuDeTinTuc, COUNT(c.MaBinhLuan) AS CommentCount " +
                                   "FROM TinTuc t " +
                                   "LEFT JOIN Comments c ON t.MaTinTuc = c.MaTinTuc " +
                                   "WHERE c.NgayBinhLuan BETWEEN ? AND ? AND c.MaBinhLuan IS NOT NULL " +
                                   "GROUP BY t.MaTinTuc, t.TieuDeTinTuc " +
                                   "ORDER BY CommentCount " + (sortOrder != null && sortOrder.equals("desc") ? "DESC" : "ASC") +
                                   " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
                try (PreparedStatement pstmt = conn.prepareStatement(sqlFiltered)) {
                    pstmt.setTimestamp(1, new java.sql.Timestamp(startDate.getTime()));
                    pstmt.setTimestamp(2, new java.sql.Timestamp(endDate.getTime()));
                    pstmt.setInt(3, filteredOffset);
                    pstmt.setInt(4, PAGE_SIZE);
                    ResultSet rs = pstmt.executeQuery();
                    while (rs.next()) {
                        TinTuc tinTuc = new TinTuc();
                        tinTuc.setMaTinTuc(rs.getInt("MaTinTuc"));
                        tinTuc.setTieuDeTinTuc(rs.getString("TieuDeTinTuc"));
                        filteredComments.add(tinTuc);
                        filteredCommentCounts.put(tinTuc.getMaTinTuc(), rs.getInt("CommentCount"));
                    }
                }

                // Thống kê số lượng bình luận theo ngày
                String sqlDaily = "SELECT CAST(c.NgayBinhLuan AS DATE) AS CommentDate, COUNT(c.MaBinhLuan) AS CommentCount " +
                                "FROM Comments c " +
                                "WHERE c.NgayBinhLuan BETWEEN ? AND ? AND c.MaBinhLuan IS NOT NULL " +
                                "GROUP BY CAST(c.NgayBinhLuan AS DATE) " +
                                "ORDER BY CommentDate ASC";
                try (PreparedStatement pstmt = conn.prepareStatement(sqlDaily)) {
                    pstmt.setTimestamp(1, new java.sql.Timestamp(startDate.getTime()));
                    pstmt.setTimestamp(2, new java.sql.Timestamp(endDate.getTime()));
                    ResultSet rs = pstmt.executeQuery();
                    while (rs.next()) {
                        String commentDate = rs.getString("CommentDate");
                        int commentCount = rs.getInt("CommentCount");
                        dailyCommentCounts.put(commentDate, commentCount);
                    }
                }
            }

            // Chuyển thông tin phân trang và sort đến JSP
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("filteredPage", filteredPage);
            request.setAttribute("totalFilteredPages", totalFilteredPages);
            request.setAttribute("sort", sortOrder);
            request.setAttribute("dailyCommentCounts", dailyCommentCounts);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi lấy thống kê bình luận: " + e.getMessage());
        } finally {
            db.closeConnection();
        }

        // Chuyển dữ liệu đến JSP
        request.setAttribute("overallComments", overallComments);
        request.setAttribute("filteredComments", filteredComments);
        request.setAttribute("overallCommentCounts", overallCommentCounts);
        request.setAttribute("filteredCommentCounts", filteredCommentCounts);
        request.getRequestDispatcher("/manage-comment-stats.jsp").forward(request, response);
    }
}