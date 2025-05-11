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

@WebServlet("/cau-lac-bo/*")
public class CauLacBoServlet extends HttpServlet {
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
                id = Integer.parseInt(parts[parts.length - 1]); // Get ID from the last part
            } catch (NumberFormatException | ArrayIndexOutOfBoundsException e) {
                request.setAttribute("error", "ID câu lạc bộ không hợp lệ");
                request.getRequestDispatcher("/CauLacBo.jsp").forward(request, response);
                return;
            }
        } else {
            request.setAttribute("error", "ID câu lạc bộ không được cung cấp");
            request.getRequestDispatcher("/CauLacBo.jsp").forward(request, response);
            return;
        }

        String tenCauLacBo = "";
        String moTaNgan = "";
        String noiDung = "";
        String ngayCapNhat = "";
        String urlAnh = "";

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT TenCauLacBo, MoTaNgan, NoiDung, NgayCapNhat, UrlAnh FROM CauLacBo WHERE MaCauLacBo = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                tenCauLacBo = rs.getString("TenCauLacBo");
                moTaNgan = rs.getString("MoTaNgan");
                noiDung = rs.getString("NoiDung");
                ngayCapNhat = rs.getTimestamp("NgayCapNhat") != null ? rs.getTimestamp("NgayCapNhat").toString() : "";
                urlAnh = rs.getString("UrlAnh");
            } else {
                request.setAttribute("error", "Câu lạc bộ không được tìm thấy");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
        }

        request.setAttribute("tenCauLacBo", tenCauLacBo);
        request.setAttribute("moTaNgan", moTaNgan);
        request.setAttribute("noiDung", noiDung);
        request.setAttribute("ngayCapNhat", ngayCapNhat);
        request.setAttribute("urlAnh", urlAnh);
        request.getRequestDispatcher("/XemCauLacBo.jsp").forward(request, response);
    }
}