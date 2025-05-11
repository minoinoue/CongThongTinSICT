<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vn.connection.DatabaseConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${tenSinhVien != null ? tenSinhVien : 'Chi tiết Gương sáng sinh viên'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        html {
            font-size: 16px;
        }
        .container {
            padding-bottom: 40px;
        }
        .slideshow-container {
            width: 100%;
            max-width: 1200px;
            margin: 20px auto;
            position: relative;
            overflow: hidden;
        }
        .slideshow-container img.slide {
            width: 100%;
            height: auto;
            display: block;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="slideshow-container">
        <img class="slide" src="https://pbs.twimg.com/media/Gqpzy2-WEAA0cHY?format=jpg&name=900x900" alt="Ảnh 1">
    </div>

    <div class="container my-5">
        <%
            String maguongsangParam = request.getParameter("maguongsang");
            if (maguongsangParam != null) {
                try {
                    int maguongsang = Integer.parseInt(maguongsangParam);
                    Connection conn = DatabaseConnection.getConnection();
                    String sql = "SELECT TenSinhVien, MoTaNgan, NoiDung, NgayCapNhat, UrlAnh FROM GuongSangSV WHERE MaGuongSang = ?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, maguongsang);
                    ResultSet rs = stmt.executeQuery();

                    if (rs.next()) {
                        String tenSinhVien = rs.getString("TenSinhVien");
                        String noiDung = rs.getString("NoiDung");
                        String urlAnh = rs.getString("UrlAnh");
                        Timestamp ngayCapNhat = rs.getTimestamp("NgayCapNhat");
                        SimpleDateFormat sdf = new SimpleDateFormat("EEEE, HH:mm dd/MM/yyyy");
        %>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <div class="student-detail">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="<%= request.getContextPath() %>/trang-chu">Trang chủ</a></li>
                                <li class="breadcrumb-item"><a href="<%= request.getContextPath() %>/GuongSangSV.jsp">Gương sáng sinh viên</a></li>
                                <li class="breadcrumb-item active" aria-current="page"><%= tenSinhVien %></li>
                            </ol>
                        </nav>
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger" role="alert">
                                <%= request.getAttribute("error") %>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
        <h2 class="mb-3 text-primary"><%= tenSinhVien %></h2>
        <p class="text-muted mb-3"><%= sdf.format(ngayCapNhat) %></p>
        <% if (urlAnh != null && !urlAnh.isEmpty()) { %>
            <img src="<%= urlAnh %>" alt="Ảnh sinh viên" class="img-fluid mb-4">
        <% } %>
        <div class="mb-4" style="line-height: 1.8;"><%= noiDung %></div>
        <%
                    } else {
        %>
            <div class="alert alert-warning">Không tìm thấy gương sáng sinh viên.</div>
        <%
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
        %>
            <div class="alert alert-danger">Lỗi: <%= e.getMessage() %></div>
        <%
                }
            } else {
        %>
            <div class="alert alert-warning">Thiếu mã gương sáng sinh viên để hiển thị nội dung.</div>
        <%
            }
        %>
    </div>

    <%@ include file="footer.jsp" %>

    <script src="<%= request.getContextPath() %>/script.js"></script>
</body>
</html>