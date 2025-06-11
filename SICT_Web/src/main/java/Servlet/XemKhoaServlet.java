package Servlet;

import connection.TinTucDAO;
import model.TinTuc;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/khoa")
public class XemKhoaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        TinTuc news = null;
        String category = request.getParameter("cat");
        int maTheLoaiTin = 1; // Default to "Khoa Công nghệ Thông tin"
        String categoryName = "Khoa Công nghệ Thông tin";

        // Map category parameter to MaTheLoaiTin and category name
        if ("cong_nghe_thong_tin".equals(category)) {
            maTheLoaiTin = 1;
            categoryName = "Khoa Công nghệ Thông tin";
        } else if ("cong_nghe_phan_mem".equals(category)) {
            maTheLoaiTin = 2;
            categoryName = "Khoa Công nghệ Phần mềm";
        } else if ("khoa_hoc_may_tinh".equals(category)) {
            maTheLoaiTin = 3;
            categoryName = "Khoa Khoa học Máy tính";
        } else if ("mang_may_tinh".equals(category)) {
            maTheLoaiTin = 4;
            categoryName = "Khoa Mạng Máy tính và Truyền thông";
        }

        TinTucDAO tinTucDAO = new TinTucDAO();
        // Không cần MaTinTuc vì đây là lấy theo MaTheLoaiTin và MaTheLoai
        tinTucDAO.updateViewCount(0, 4, maTheLoaiTin); // MaTinTuc = 0 (không sử dụng), MaTheLoai = 4 cho "KHOA"
        news = tinTucDAO.getTinTucById(0, 4, maTheLoaiTin); // MaTinTuc = 0 (không sử dụng)

        if (news == null) {
            request.setAttribute("error", "Không tìm thấy thông tin cho: " + categoryName);
        }

        request.setAttribute("news", news);
        request.setAttribute("categoryName", categoryName);
        tinTucDAO.closeConnection(); // Đóng kết nối nếu cần

        request.getRequestDispatcher("/khoa.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}