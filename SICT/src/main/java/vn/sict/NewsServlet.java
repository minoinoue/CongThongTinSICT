package vn.sict;

import vn.connection.DatabaseConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/tin-tuc/*")
public class NewsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Đặt mã hóa UTF-8 để hỗ trợ tiếng Việt
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        System.out.println("NewsServlet được truy cập với path: " + request.getPathInfo());

        // Trích xuất ID từ path
        String pathInfo = request.getPathInfo();
        int id;
        if (pathInfo != null && !pathInfo.isEmpty()) {
            try {
                String[] parts = pathInfo.split("/");
                id = Integer.parseInt(parts[parts.length - 1]); // Lấy phần cuối làm ID
            } catch (NumberFormatException | ArrayIndexOutOfBoundsException e) {
                request.setAttribute("error", "ID tin tức không hợp lệ");
                request.getRequestDispatcher("/tintuc.jsp").forward(request, response);
                return;
            }
        } else {
            request.setAttribute("error", "ID tin tức không được cung cấp");
            request.getRequestDispatcher("/tintuc.jsp").forward(request, response);
            return;
        }

        String tieuDe = "";
        String trichDanTin = "";
        String noiDungTin = "";
        String ngayCapNhat = "";
        String urlAnh = "";

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT TieuDeTinTuc, TrichDanTin, NoiDungTin, NgayCapNhat, UrlAnh FROM TinTuc WHERE MaTinTuc = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                tieuDe = rs.getString("TieuDeTinTuc");
                trichDanTin = rs.getString("TrichDanTin");
                noiDungTin = rs.getString("NoiDungTin");
                ngayCapNhat = rs.getTimestamp("NgayCapNhat") != null ? rs.getTimestamp("NgayCapNhat").toString() : "";
                urlAnh = rs.getString("UrlAnh");
            } else {
                request.setAttribute("error", "Bài viết không được tìm thấy");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
        }

        request.setAttribute("tieuDe", tieuDe);
        request.setAttribute("trichDanTin", trichDanTin);
        request.setAttribute("noiDungTin", noiDungTin);
        request.setAttribute("ngayCapNhat", ngayCapNhat);
        request.setAttribute("urlAnh", urlAnh);
        request.getRequestDispatcher("/tintuc.jsp").forward(request, response);
    }
}