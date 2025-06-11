package Servlet;

import connection.CommentDAO;
import connection.TinTucDAO;
import model.Comments;
import model.TinTuc;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/xem-chi-tiet")
public class XemChiTietServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        TinTuc item = null;
        String maTinTuc = request.getParameter("matintuc");
        String type = request.getParameter("type"); // tin-tuc, cau-lac-bo, guong-sang-sv, tuyen-sinh-dai-hoc, tuyen-sinh-sau-dai-hoc
        String jspPage = "/XemChiTiet.jsp";
        String itemType = "tin tức";

        if (maTinTuc == null || maTinTuc.trim().isEmpty()) {
            request.setAttribute("error", "Mã tin tức không hợp lệ.");
        } else {
            int maTheLoai = 0;
            Integer maTheLoaiTin = null;

            switch (type != null ? type.toLowerCase() : "") {
                case "cau-lac-bo":
                    maTheLoai = 15;
                    itemType = "câu lạc bộ";
                    break;
                case "guong-sang-sv":
                    maTheLoai = 16;
                    itemType = "gương sáng sinh viên";
                    break;
                case "tuyen-sinh-dai-hoc":
                    maTheLoai = 5;
                    maTheLoaiTin = 12;
                    itemType = "tuyển sinh đại học";
                    break;
                case "tuyen-sinh-sau-dai-hoc":
                    maTheLoai = 5;
                    maTheLoaiTin = 13;
                    itemType = "tuyển sinh sau đại học";
                    break;
                default:
                    type = "tin-tuc";
                    maTheLoai = 10;
                    itemType = "tin tức";
                    break;
            }

            TinTucDAO tinTucDAO = null;
			tinTucDAO = new TinTucDAO();
            tinTucDAO.updateViewCount(Integer.parseInt(maTinTuc), maTheLoai, maTheLoaiTin);
            item = tinTucDAO.getTinTucById(Integer.parseInt(maTinTuc), maTheLoai, maTheLoaiTin);

            if (item == null) {
                request.setAttribute("error", "Không tìm thấy " + itemType + " với mã: " + maTinTuc);
            }

            CommentDAO commentDAO = new CommentDAO();
            List<Comments> comments = commentDAO.getCommentsByNewsID(Integer.parseInt(maTinTuc));
            request.setAttribute("comments", comments);

            tinTucDAO.closeConnection(); // Đóng kết nối nếu cần
        }

        request.setAttribute("item", item);
        request.setAttribute("type", type);
        request.getRequestDispatcher(jspPage).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}