package Servlet;

import connection.TinTucDAO;
import model.TinTuc;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/phong_trungtam")
public class XemPhongTrungTamServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        TinTuc news = null;
        String category = request.getParameter("cat");
        int maTheLoaiTin = 18; // Default to "Phòng Tổng hợp"
        String categoryName = "Phòng Tổng hợp";

        // Map category parameter to MaTheLoaiTin and category name
        if ("tong_hop".equals(category)) {
            maTheLoaiTin = 18;
            categoryName = "Phòng Tổng hợp";
        } else if ("hop_tac_phat_trien".equals(category)) {
            maTheLoaiTin = 19;
            categoryName = "Trung tâm Hợp tác Phát triển";
        } else if ("nghien_cuu_ict".equals(category)) {
            maTheLoaiTin = 20;
            categoryName = "Trung tâm Nghiên cứu Công nghệ Tiên tiến ICT";
        }

        TinTucDAO tinTucDAO = new TinTucDAO();
        // Không cần MaTinTuc vì đây là lấy theo MaTheLoaiTin và MaTheLoai
        tinTucDAO.updateViewCount(0, 7, maTheLoaiTin); // MaTinTuc = 0 (không sử dụng), MaTheLoai = 7 cho "PHÒNG/TRUNG TÂM"
        news = tinTucDAO.getTinTucById(0, 7, maTheLoaiTin); // MaTinTuc = 0 (không sử dụng)

        if (news == null) {
            request.setAttribute("error", "Không tìm thấy thông tin cho: " + categoryName);
        }

        request.setAttribute("news", news);
        request.setAttribute("categoryName", categoryName);
        tinTucDAO.closeConnection(); // Đóng kết nối nếu cần

        request.getRequestDispatcher("/phong_trungtam.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}