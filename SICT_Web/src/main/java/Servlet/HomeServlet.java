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

@WebServlet("/trang-chu")
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        List<TinTuc> newsList = new ArrayList<>();
        List<TinTuc> clubList = new ArrayList<>();
        List<TinTuc> studentList = new ArrayList<>();
        List<TinTuc> notificationList = new ArrayList<>();

        TinTucDAO tinTucDAO = new TinTucDAO();

        // Truy vấn tin tức (MaTheLoai = 10)
        newsList = tinTucDAO.getTopTinTuc(10, 3);
        if (newsList.isEmpty()) {
            request.setAttribute("error", "Không có tin tức nào với MaTheLoai = 10.");
        }

        // Truy vấn câu lạc bộ (MaTheLoai = 15)
        clubList = tinTucDAO.getTopTinTuc(15, 3);
        if (clubList.isEmpty()) {
            request.setAttribute("error", "Không có tin tức nào với MaTheLoai = 15.");
        }

        // Truy vấn gương sáng sinh viên (MaTheLoai = 16)
        studentList = tinTucDAO.getTopTinTuc(16, 3);
        if (studentList.isEmpty()) {
            request.setAttribute("error", "Không có tin tức nào với MaTheLoai = 16.");
        }

        // Truy vấn thông báo (MaTheLoai = 11)
        notificationList = tinTucDAO.getTopTinTuc(11, 3);

        request.setAttribute("newsList", newsList);
        request.setAttribute("clubList", clubList);
        request.setAttribute("studentList", studentList);
        request.setAttribute("notificationList", notificationList);

        tinTucDAO.closeConnection(); // Đóng kết nối nếu cần

        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}