package Servlet;

import connection.TinTucDAO;
import model.TinTuc;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/gioi_thieu")
public class XemGioiThieuServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        TinTuc news = null;
        String category = request.getParameter("cat");
        int maTheLoaiTin = 1; // Default to "THÔNG TIN CHUNG"
        String categoryName = "Thông tin chung";

        // Map category parameter to MaTheLoaiTin and category name
        if ("co_cau_to_chuc".equals(category)) {
            maTheLoaiTin = 2;
            categoryName = "Cơ cấu tổ chức";
        } else if ("chien_luoc_phat_trien".equals(category)) {
            maTheLoaiTin = 3;
            categoryName = "Chiến lược phát triển";
        } else if ("can_bo_giang_vien".equals(category)) {
            maTheLoaiTin = 4;
            categoryName = "Cán bộ giảng viên";
        } else if ("co_so_vat_chat".equals(category)) {
            maTheLoaiTin = 5;
            categoryName = "Cơ sở vật chất";
        } else if ("lien_he".equals(category)) {
            maTheLoaiTin = 6;
            categoryName = "Liên hệ";
        }

        TinTucDAO tinTucDAO = new TinTucDAO();
        // Không cần MaTinTuc vì đây là lấy theo MaTheLoaiTin và MaTheLoai
        tinTucDAO.updateViewCount(0, 3, maTheLoaiTin); // MaTinTuc = 0 (không sử dụng), MaTheLoai = 3 cho "GIỚI THIỆU"
        news = tinTucDAO.getTinTucById(0, 3, maTheLoaiTin); // MaTinTuc = 0 (không sử dụng)

        if (news == null) {
            request.setAttribute("error", "Không tìm thấy thông tin cho: " + categoryName);
        }

        request.setAttribute("news", news);
        request.setAttribute("categoryName", categoryName);
        tinTucDAO.closeConnection(); // Đóng kết nối nếu cần

        request.getRequestDispatcher("/gioithieu.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}