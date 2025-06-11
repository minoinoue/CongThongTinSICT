package Servlet;

import connection.TinTucDAO;
import model.TinTuc;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/dao_tao")
public class XemDaoTaoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        TinTuc news = null;
        String category = request.getParameter("cat");
        int maTheLoaiTin = 25; // Default to "KHOA HỌC MÁY TÍNH"
        String categoryName = "Khoa học Máy tính";

        // Map category parameter to MaTheLoaiTin and category name
        if ("khoa_hoc_may_tinh".equals(category)) {
            maTheLoaiTin = 25;
            categoryName = "Khoa học Máy tính";
        } else if ("ky_thuat_phan_mem".equals(category)) {
            maTheLoaiTin = 26;
            categoryName = "Kỹ thuật Phần mềm";
        } else if ("he_thong_thong_tin".equals(category)) {
            maTheLoaiTin = 27;
            categoryName = "Hệ thống Thông tin";
        } else if ("cong_nghe_thong_tin".equals(category)) {
            maTheLoaiTin = 28;
            categoryName = "Công nghệ Thông tin";
        } else if ("cong_nghe_da_phuong_tien".equals(category)) {
            maTheLoaiTin = 29;
            categoryName = "Công nghệ Đa phương tiện";
        } else if ("an_toan_thong_tin".equals(category)) {
            maTheLoaiTin = 30;
            categoryName = "An toàn Thông tin";
        } else if ("sau_he_thong_thong_tin".equals(category)) {
            maTheLoaiTin = 31;
            categoryName = "Hệ thống Thông tin - Sau Đại học";
        } else if ("quy_che_bieu_mau".equals(category)) {
            maTheLoaiTin = 11;
            categoryName = "Quy chế và Biểu mẫu";
        }

        TinTucDAO tinTucDAO = new TinTucDAO();
        // Không cần MaTinTuc vì đây là lấy theo MaTheLoaiTin và MaTheLoai
        tinTucDAO.updateViewCount(0, 4, maTheLoaiTin); // MaTinTuc = 0 (không sử dụng), MaTheLoai = 4 cho "ĐÀO TẠO"
        news = tinTucDAO.getTinTucById(0, 4, maTheLoaiTin); // MaTinTuc = 0 (không sử dụng)

        if (news == null) {
            request.setAttribute("error", "Không tìm thấy thông tin cho: " + categoryName);
        }

        request.setAttribute("news", news);
        request.setAttribute("categoryName", categoryName);
        tinTucDAO.closeConnection(); // Đóng kết nối nếu cần

        request.getRequestDispatcher("/dao_tao.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}