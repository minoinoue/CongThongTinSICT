package vn.sict;

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

import vn.connection.DatabaseConnection;

@WebServlet("/tin-tuc/*")
public class TinTucServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String pathInfo = request.getPathInfo();
        int id;
        if (pathInfo != null && !pathInfo.isEmpty()) {
            try {
                String[] parts = pathInfo.split("/");
                id = Integer.parseInt(parts[parts.length - 1]); // Lấy ID từ phần cuối
            } catch (NumberFormatException | ArrayIndexOutOfBoundsException e) {
                request.setAttribute("error", "ID tin tức không hợp lệ");
                request.getRequestDispatcher("/tintuc.jsp").forward(request, response);
                return;
            }
        } else {
            request.setAttribute("error", "ID tin tức không được cung cấp");
            request.getRequestDispatcher("/TinTuc.jsp").forward(request, response);
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
        request.getRequestDispatcher("/TinTuc.jsp").forward(request, response);
    }
}