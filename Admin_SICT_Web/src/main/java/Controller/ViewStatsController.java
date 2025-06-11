package Controller;

import Dal.ViewStatsDAO;
import Model.TinTuc;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ViewStatsController extends HttpServlet {
    private static final int PAGE_SIZE = 10; // Số bài báo mỗi trang
    private ViewStatsDAO viewStatsDAO;

    @Override
    public void init() throws ServletException {
        viewStatsDAO = new ViewStatsDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Lấy tham số từ request
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String filteredPageStr = request.getParameter("filteredPage");
        String sortOrder = request.getParameter("sort");
        String filterAction = request.getParameter("filterAction"); // "filter" hoặc "all"
        int filteredPage = (filteredPageStr != null && !filteredPageStr.isEmpty()) ? Integer.parseInt(filteredPageStr) : 1;
        int filteredOffset = (filteredPage - 1) * PAGE_SIZE;

        // Thiết lập giá trị mặc định: 1 tuần gần nhất
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date endDate = new Date(); // Ngày hiện tại (2025-06-05)
        Date startDate = new Date(endDate.getTime() - 7 * 24 * 60 * 60 * 1000); // Lùi 7 ngày (2025-05-29)

        java.sql.Timestamp startTs = null;
        java.sql.Timestamp endTs = null;

        // Xử lý hành động lọc
        if ("all".equals(filterAction)) {
            startTs = null;
            endTs = null;
        } else if ("filter".equals(filterAction) && startDateStr != null && !startDateStr.isEmpty() && endDateStr != null && !endDateStr.isEmpty()) {
            try {
                startDate = dateFormat.parse(startDateStr);
                endDate = dateFormat.parse(endDateStr);
                startTs = new java.sql.Timestamp(startDate.getTime());
                endTs = new java.sql.Timestamp(endDate.getTime());
            } catch (Exception e) {
                request.setAttribute("error", "Định dạng ngày không hợp lệ: " + e.getMessage());
                startTs = new java.sql.Timestamp(startDate.getTime());
                endTs = new java.sql.Timestamp(endDate.getTime());
            }
        } else {
            startTs = new java.sql.Timestamp(startDate.getTime());
            endTs = new java.sql.Timestamp(endDate.getTime());
        }

        // Lấy dữ liệu từ DAO
        int totalFilteredArticles = viewStatsDAO.getTotalFilteredArticles(startTs, endTs);
        int totalFilteredPages = (int) Math.ceil((double) totalFilteredArticles / PAGE_SIZE);
        List<TinTuc> filteredViews = viewStatsDAO.getFilteredViews(startTs, endTs, filteredOffset, PAGE_SIZE, sortOrder);
        Map<Integer, Integer> filteredViewCounts = viewStatsDAO.getFilteredViewCounts();
        Map<String, Integer> dailyViewCounts = viewStatsDAO.getDailyViewCounts(startTs, endTs);

        // Chuyển thông tin đến JSP
        request.setAttribute("filteredPage", filteredPage);
        request.setAttribute("totalFilteredPages", totalFilteredPages);
        request.setAttribute("sort", sortOrder);
        request.setAttribute("dailyViewCounts", dailyViewCounts);
        request.setAttribute("filteredViews", filteredViews);
        request.setAttribute("filteredViewCounts", filteredViewCounts);
        request.setAttribute("startDate", startDate != null ? dateFormat.format(startDate) : "");
        request.setAttribute("endDate", endDate != null ? dateFormat.format(endDate) : "");

        request.getRequestDispatcher("/manage-view-stats.jsp").forward(request, response);
    }
}