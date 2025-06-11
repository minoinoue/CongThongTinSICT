package Servlet;

import connection.TinTucDAO;
import model.TinTuc;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/tim-kiem")
public class TimKiemTinTucServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String query = request.getParameter("query");
        String type = request.getParameter("type");
        List<TinTuc> searchResults = new ArrayList<>();

        int maTheLoai = 10; // Mặc định cho tin tức
        if ("cau-lac-bo".equals(type)) {
            maTheLoai = 15;
        } else if ("guong-sang-sv".equals(type)) {
            maTheLoai = 16;
        }

        TinTucDAO tinTucDAO = new TinTucDAO();
        searchResults = tinTucDAO.searchTinTuc(query, maTheLoai);

        if (searchResults.isEmpty() && (query != null && !query.trim().isEmpty())) {
            request.setAttribute("error", "Không tìm thấy kết quả nào cho từ khóa: " + query);
        } else if (query == null || query.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập từ khóa tìm kiếm.");
        }

        request.setAttribute("itemList", searchResults);
        request.setAttribute("type", type);
        tinTucDAO.closeConnection(); // Đóng kết nối nếu cần

        request.getRequestDispatcher("/DanhSach.jsp").forward(request, response);
    }
}