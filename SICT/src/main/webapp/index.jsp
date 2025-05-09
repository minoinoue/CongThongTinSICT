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
    <title>BTL_Java_Nhóm3</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/fonts/themify-icons/themify-icons.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Thanh điều hướng */
        .navbar {
            list-style: none;
            background-color: #003366;
            padding: 0;
            margin: 0;
            display: flex;
            flex-wrap: wrap;
        }

        .navbar > li {
            position: relative;
        }

        .navbar > li > a {
            display: block;
            padding: 14px 18px;
            color: white;
            font-weight: bold;
            text-decoration: none;
            white-space: nowrap;
        }

        .navbar > li:hover {
            background-color: #005599;
        }

        /* Dropdown menu */
        .dropdown {
            position: absolute;
            top: 100%;
            left: 0;
            background-color: white;
            list-style: none;
            min-width: 220px;
            display: none;
            padding: 10px 0;
            margin: 0;
            border-radius: 6px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            z-index: 1000;
        }

        .dropdown li a {
            display: block;
            padding: 12px 20px;
            color: #003366;
            text-decoration: none;
            font-weight: bold;
            white-space: nowrap;
        }

        .dropdown li a:hover {
            background-color: #f0f0f0;
        }

        .submenu {
            position: absolute;
            top: 0;
            left: 100%;
            background-color: white;
            min-width: 220px;
            display: none;
            padding: 10px 0;
            margin: 0;
            list-style: none;
            border-radius: 6px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            z-index: 1000;
        }

        .submenu li a {
            display: block;
            padding: 12px 20px;
            color: #003366;
            text-decoration: none;
            font-weight: bold;
            white-space: nowrap;
        }

        .submenu li a:hover {
            background-color: #f0f0f0;
        }

        /* Hiện dropdown khi hover */
        .navbar > li:hover > .dropdown {
            display: block;
        }

        /* Hiện submenu của "ĐẠI HỌC" khi hover vào mục "ĐẠI HỌC" trong dropdown "ĐÀO TẠO" */
        .navbar > li:nth-child(3) > .dropdown > li:first-child:hover > .submenu {
            display: block;
        }

        /* Hiện submenu của "SAU ĐẠI HỌC" khi hover vào mục "SAU ĐẠI HỌC" trong dropdown "ĐÀO TẠO" */
        .navbar > li:nth-child(3) > .dropdown > li:nth-child(2):hover > .submenu {
            display: block;
        }

        /* Logo */
        .logobar {
            display: flex;
            align-items: center;
            padding: 10px 20px;
            background-color: #f5f5f5;
        }

        .logobar img {
            height: 60px;
            margin-right: 15px;
        }

        /* Slideshow */
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

        /* News Section Header */
        .news-header {
            text-align: center;
            padding: 20px 0;
            background-color: #003366;
            color: white;
            margin: 30px auto;
            max-width: 1200px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .news-header h1 {
            font-size: 2.5em;
            margin: 0;
            font-weight: bold;
        }

        .news-item {
            display: flex;
            margin-bottom: 20px;
            background-color: white;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .news-item img {
            width: 200px;
            height: 150px;
            object-fit: cover;
            margin-right: 15px;
            border-radius: 5px;
        }

        .news-item .content {
            flex: 1;
        }

        .news-item .content h3 {
            font-size: 1.5em;
            margin: 0 0 10px;
        }

        .news-item .content h3 a {
            color: #003087;
            text-decoration: none;
        }

        .news-item .content h3 a:hover {
            text-decoration: underline;
        }

        .news-item .content .date {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 10px;
        }

        .news-item .content .summary {
            color: #333;
            line-height: 1.6;
        }

        .recent-news {
            background-color: white;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .recent-news h4 {
            color: #003087;
            font-size: 1.2em;
            margin-bottom: 15px;
        }

        .recent-news ul {
            list-style: none;
            padding: 0;
        }

        .recent-news ul li {
            margin-bottom: 10px;
        }

        .recent-news ul li a {
            color: #333;
            text-decoration: none;
            font-size: 0.95em;
        }

        .recent-news ul li a:hover {
            color: #003087;
            text-decoration: underline;
        }

        /* Footer */
        .footer {
            background-color: #004080;
            color: white;
            font-family: Arial, sans-serif;
            padding: 20px;
            position: relative;
            width: 100%;
            box-sizing: border-box;
            z-index: 1000;
        }

        .footer-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 30px;
            max-width: 1200px;
            margin: auto;
        }

        .footer-col {
            flex: 1;
            min-width: 250px;
        }

        .footer-col a {
            color: white;
            text-decoration: none;
        }

        .footer-col a:hover {
            color: #ccc;
            text-decoration: underline;
        }

        .footer-logo {
            width: 180px;
            margin-bottom: 15px;
        }

        .footer-col h4 {
            margin-top: 15px;
            margin-bottom: 10px;
            font-weight: bold;
        }

        .footer-col p {
            margin: 6px 0;
            font-size: 14px;
        }

        .social-icons {
            display: flex;
            gap: 12px;
            margin-top: 10px;
        }

        .social-icons a {
            color: inherit;
            text-decoration: none;
        }

        .social-icons i {
            font-size: 22px;
            cursor: pointer;
            transition: transform 0.2s;
        }

        .social-icons a:hover i {
            transform: scale(1.2);
            color: #ccc;
        }

        .back-to-top {
            position: fixed;
            bottom: 20px;
            right: 20px;
            font-size: 36px;
            color: #fff;
            background-color: #007bff;
            border-radius: 50%;
            width: 48px;
            height: 48px;
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
            transition: transform 0.2s, background-color 0.2s, border-color 0.2s;
            text-decoration: none !important;
        }

        .back-to-top:hover {
            transform: scale(1.2);
            background-color: #fff;
            color: #007bff;
        }

        /* Add padding to the container to prevent content from being too close to footer */
        .container {
            padding-bottom: 40px;
        }
    </style>
</head>
<body>

    <div class="logobar">
        <img src="<%= request.getContextPath() %>/images/logo.png" alt="Logo HaUI">
        <h1>KHOA CÔNG NGHỆ THÔNG TIN</h1>
    </div>

    <ul class="navbar">
        <li><a href="https://www.haui.edu.vn/vn">TRANG HAUI</a></li>
        <li>
            <a href="#">GIỚI THIỆU <i class="bi bi-chevron-down ms-auto"></i></a>
            <ul class="dropdown">
                <li><a href="#">THÔNG TIN CHUNG</a></li>
                <li><a href="#">CƠ CẤU TỔ CHỨC</a></li>
                <li><a href="#">CHIẾN LƯỢC PHÁT TRIỂN</a></li>
                <li><a href="#">CÁN BỘ GIẢNG VIÊN</a></li>
                <li><a href="#">CƠ SỞ VẬT CHẤT</a></li>
                <li><a href="#">LIÊN HỆ</a></li>
            </ul>
        </li>
        <li>
            <a href="#">ĐÀO TẠO <i class="bi bi-chevron-down ms-auto"></i></a>
            <ul class="dropdown">
                <li>
                    <a href="#">ĐẠI HỌC</a>
                    <ul class="submenu">
                        <li class="submenu-item"><a href="#">KHOA HỌC MÁY TÍNH</a></li>
                        <li class="submenu-item"><a href="#">KỸ THUẬT PHẦN MỀM</a></li>
                        <li class="submenu-item"><a href="#">HỆ THỐNG THÔNG TIN</a></li>
                        <li class="submenu-item"><a href="#">CÔNG NGHỆ THÔNG TIN</a></li>
                        <li class="submenu-item"><a href="#">CÔNG NGHỆ ĐA PHƯƠNG TIỆN</a></li>
                        <li class="submenu-item"><a href="#">AN TOÀN THÔNG TIN</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">SAU ĐẠI HỌC</a>
                    <ul class="submenu">
                        <li class="submenu-item"><a href="#">HỆ THỐNG THÔNG TIN</a></li>
                    </ul>
                </li>
                <li><a href="#">KẾ HOẠCH</a></li>
                <li><a href="#">TIẾN ĐỘ</a></li>
                <li><a href="#">QUY CHẾ, BIỂU MẪU</a></li>
            </ul>
        </li>
        <li>
            <a href="#">TUYỂN SINH <i class="bi bi-chevron-down ms-auto"></i></a>
            <ul class="dropdown">
                <li><a href="#">ĐẠI HỌC</a></li>
                <li><a href="#">SAU ĐẠI HỌC</a></li>
            </ul>
        </li>
        <li>
            <a href="#">KHOA <i class="bi bi-chevron-down ms-auto"></i></a>
            <ul class="dropdown">
                <li><a href="#">KHOA CÔNG NGHỆ THÔNG TIN</a></li>
                <li><a href="#">KHOA CÔNG NGHỆ PHẦN MỀM</a></li>
                <li><a href="#">KHOA KHOA HỌC MÁY TÍNH</a></li>
                <li><a href="#">KHOA MẠNG MÁY TÍNH VÀ TRUYỀN THÔNG</a></li>
            </ul>
        </li>
        <li>
            <a href="#">PHÒNG/TRUNG TÂM <i class="bi bi-chevron-down ms-auto"></i></a>
            <ul class="dropdown">
                <li><a href="#">PHÒNG TỔNG HỢP</a></li>
                <li><a href="#">TRUNG TÂM HỢP TÁC PHÁT TRIỂN</a></li>
                <li><a href="#">TRUNG TÂM NGHIÊN CỨU CÔNG NGHỆ TIÊN TIẾN ICT</a></li>
            </ul>
        </li>
        <li>
            <a href="#">KHOA HỌC - CÔNG NGHỆ <i class="bi bi-chevron-down ms-auto"></i></a>
            <ul class="dropdown">
                <li><a href="#">CÔNG TRÌNH CÔNG BỐ</a></li>
                <li><a href="#">ĐỀ TÀI DỰ ÁN</a></li>
                <li><a href="#">SINH VIÊN NCKH</a></li>
                <li><a href="#">TIN KHCN</a></li>
            </ul>
        </li>
        <li><a href="#">THƯ VIỆN ẢNH</a></li>
    </ul>

    <div class="slideshow-container">
        <img class="slide" src="<%= request.getContextPath() %>/images/ufi2226.jpg" alt="Ảnh 1">
        <img class="slide" src="<%= request.getContextPath() %>/images/ufi2234.jpg" alt="Ảnh 2">
        <img class="slide" src="<%= request.getContextPath() %>/images/ufi2235.jpg" alt="Ảnh 3">
    </div>

    <div class="news-header">
        <h1>SICT News</h1>
    </div>
    <div class="container">
        <div class="row">
            <!-- Main News List -->
            <div class="col-md-8">
                <%
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    try (Connection conn = DatabaseConnection.getConnection()) {
                        String sql = "SELECT TOP 10 MaTinTuc, TieuDeTinTuc, TrichDanTin, NgayCapNhat, UrlAnh FROM TinTuc ORDER BY NgayCapNhat DESC";
                        PreparedStatement stmt = conn.prepareStatement(sql);
                        ResultSet rs = stmt.executeQuery();
                        while (rs.next()) {
                            int maTinTuc = rs.getInt("MaTinTuc");
                            String tieuDe = rs.getString("TieuDeTinTuc");
                            String trichDan = rs.getString("TrichDanTin");
                            Timestamp ngayCapNhatTimestamp = rs.getTimestamp("NgayCapNhat");
                            String ngayCapNhat = ngayCapNhatTimestamp != null ? dateFormat.format(ngayCapNhatTimestamp) : "";
                            String urlAnh = rs.getString("UrlAnh");
                            String slug = tieuDe.toLowerCase().replaceAll("\\s+", "-").replaceAll("[^a-z0-9-]", "");
                %>
                <div class="news-item">
                    <% if (urlAnh != null && !urlAnh.isEmpty()) { %>
                        <img src="<%= urlAnh %>" alt="News Image">
                    <% } else { %>
                        <img src="https://via.placeholder.com/200x150" alt="Default Image">
                    <% } %>
                    <div class="content">
                        <h3><a href="tin-tuc/<%= slug %>/<%= maTinTuc %>"><%= tieuDe %></a></h3>
                        <div class="date"><%= ngayCapNhat %></div>
                        <div class="summary"><%= trichDan %></div>
                    </div>
                </div>
                <%
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("<p class='text-danger'>Lỗi khi tải danh sách tin tức: " + e.getMessage() + "</p>");
                    }
                %>
            </div>
            <!-- Recent News Sidebar -->
            <div class="col-md-4">
                <div class="recent-news">
                    <h4>Tin Tức Gần Đây</h4>
                    <ul>
                        <%
                            try (Connection conn = DatabaseConnection.getConnection()) {
                                String sql = "SELECT TOP 5 MaTinTuc, TieuDeTinTuc FROM TinTuc ORDER BY NgayCapNhat DESC";
                                PreparedStatement stmt = conn.prepareStatement(sql);
                                ResultSet rs = stmt.executeQuery();
                                while (rs.next()) {
                                    int maTinTuc = rs.getInt("MaTinTuc");
                                    String tieuDe = rs.getString("TieuDeTinTuc");
                                    String slug = tieuDe.toLowerCase().replaceAll("\\s+", "-").replaceAll("[^a-z0-9-]", "");
                        %>
                        <li><a href="tin-tuc/<%= slug %>/<%= maTinTuc %>"><%= tieuDe %></a></li>
                        <%
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                                out.println("<p class='text-danger'>Lỗi khi tải tin tức gần đây: " + e.getMessage() + "</p>");
                            }
                        %>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <footer class="footer">
        <div class="footer-container">
            <div class="footer-col">
                <img src="<%= request.getContextPath() %>/images/logo.png" alt="HaUI Logo" class="footer-logo">
                <h4>THÔNG TIN LIÊN HỆ</h4>
                <p><i class="bi bi-geo-alt-fill"></i> Tầng 12, Nhà A1</p>
                <p><i class="bi bi-geo-alt"></i> Số 298 đường Cầu Diễn, quận Bắc Từ Liêm, Hà Nội</p>
                <p><i class="bi bi-envelope"></i> Email: sict@haui.edu.vn</p>
            </div>
            <div class="footer-col">
                <h4>THÔNG TIN</h4>
                <p><a href="">> Liên hệ</a></p>
                <p><a href="">> Sơ đồ trường</a></p>
                <h4>MẠNG XÃ HỘI</h4>
                <div class="social-icons">
                    <a href="https://web.facebook.com/DHCNHNofficial" target="_blank"><i class="bi bi-facebook"></i></a>
                    <a href="https://www.youtube.com/@HaUITV" target="_blank"><i class="bi bi-youtube"></i></a>
                    <a href="https://web.facebook.com/messages/t/200315546493808" target="_blank"><i class="bi bi-messenger"></i></a>
                    <a href="https://www.tiktok.com/@fitmedia.haui" target="_blank"><i class="bi bi-tiktok"></i></a>
                </div>
            </div>
            <div class="footer-col">
                <h4>BẢN ĐỒ CHỈ DẪN</h4>
                <iframe
                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.607123306446!2d105.7296514750296!3d21.01101108063321!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135ab45780ff4cf%3A0x385fda93d8b3ecb3!2zSOG6o2kgxJDDtG5nIE5naGnhu4dwIEjDoCBO4buZaQ!5e0!3m2!1svi!2s!4v1715071600000!5m2!1svi!2s"
                    width="250" height="150" style="border:0;" allowfullscreen="" loading="lazy">
                </iframe>
            </div>
        </div>
        <div class="footer-bottom text-center">
            <p>Copyright © 2025 School Of Information And Communications Technology</p>
        </div>
        <a href="#" class="back-to-top">
            <i class="bi bi-arrow-up-circle-fill"></i>
        </a>
    </footer>

    <script src="<%= request.getContextPath() %>/script.js"></script>
</body>
</html>