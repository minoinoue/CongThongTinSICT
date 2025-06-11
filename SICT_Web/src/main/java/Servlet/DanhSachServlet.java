package Servlet;

import connection.TinTucDAO;
import model.TinTuc;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet({"/tin-tuc", "/cau-lac-bo", "/guong-sang-sv", "/tuyen-sinh-dai-hoc", "/tuyen-sinh-sau-dai-hoc"})
public class DanhSachServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        List<TinTuc> itemList = new ArrayList<>();
        String servletPath = request.getServletPath();
        String type;
        int maTheLoai = 0;
        Integer maTheLoaiTin = null;

        // Xác định MaTheLoai, MaTheLoaiTin và type dựa trên servletPath
        switch (servletPath) {
            case "/tuyen-sinh-dai-hoc":
                maTheLoai = 5;
                maTheLoaiTin = 12;
                type = "tuyen-sinh-dai-hoc";
                break;
            case "/tuyen-sinh-sau-dai-hoc":
                maTheLoai = 5;
                maTheLoaiTin = 13;
                type = "tuyen-sinh-sau-dai-hoc";
                break;
            case "/tin-tuc":
                maTheLoai = 10;
                type = "tin-tuc";
                break;
            case "/cau-lac-bo":
                maTheLoai = 15;
                type = "cau-lac-bo";
                break;
            case "/guong-sang-sv":
                maTheLoai = 16;
                type = "guong-sang-sv";
                break;
            default:
                maTheLoai = 10;
                type = "tin-tuc";
        }

        TinTucDAO tinTucDAO = null;
		tinTucDAO = new TinTucDAO();
        itemList = tinTucDAO.getTinTucList(maTheLoai, maTheLoaiTin);

        request.setAttribute("itemList", itemList);
        request.setAttribute("type", type);
        tinTucDAO.closeConnection(); // Đóng kết nối nếu cần

        request.getRequestDispatcher("/DanhSach.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}