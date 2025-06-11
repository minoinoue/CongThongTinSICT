package Servlet;

import connection.CommentDAO;
import model.Users;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/comment")
public class CommentController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("USER");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }

        String maTinTucStr = request.getParameter("maTinTuc");
        String noiDung = request.getParameter("noiDung");

        if (maTinTucStr == null || noiDung == null || noiDung.trim().isEmpty()) {
            request.setAttribute("commentError", "Nội dung bình luận không hợp lệ.");
            request.getRequestDispatcher("/xem-chi-tiet?matintuc=" + maTinTucStr).forward(request, response);
            return;
        }

        try {
            int maTinTuc = Integer.parseInt(maTinTucStr);
            CommentDAO commentDAO = new CommentDAO();
            boolean success = commentDAO.addComment(maTinTuc, user.getUserID(), noiDung);
            if (success) {
                request.setAttribute("commentSuccess", "Bình luận đã được đăng thành công!");
            } else {
                request.setAttribute("commentError", "Không thể đăng bình luận. Vui lòng thử lại.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("commentError", "Mã tin tức không hợp lệ.");
        }

        request.getRequestDispatcher("/xem-chi-tiet?matintuc=" + maTinTucStr).forward(request, response);
    }
}