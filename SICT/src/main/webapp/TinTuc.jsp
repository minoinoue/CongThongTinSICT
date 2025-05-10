<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vn.connection.DatabaseConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${tieuDe != null ? tieuDe : 'Tin Tức Chi Tiết'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        html {
            font-size: 16px;
        }
        body {
            background-color: #f5f5f5;
            font-family: 'Roboto', Arial, sans-serif;
            margin: 0;
            padding: 0;
            width: 100%;
        }

        /* Header Styles */
        header {
            background-color: #fff;
            border-bottom: 0.0625rem solid #ddd;
            text-align: center;
        }
        .header-top {
            padding: 0.625rem 0;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .header-top img {
            height: 2.5rem;
            margin-right: 0.625rem;
        }
        .header-top h1 {
            font-size: 1rem;
            color: #003087;
            margin: 0;
            font-weight: 700;
        }
        .navbar {
            list-style: none;
            background-color: #003087;
            padding: 0;
            margin: 0;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            width: 100vw;
        }
        .navbar > li {
            position: relative;
            margin: 0 0.625rem;
        }
        .navbar > li > a {
            display: block;
            padding: 0.75rem 1rem;
            color: white;
            font-weight: bold;
            text-decoration: none;
            white-space: nowrap;
            font-size: 0.875rem;
        }
        .navbar > li:hover {
            background-color: #0055b3;
        }
        .dropdown {
            position: absolute;
            top: 100%;
            left: 0;
            background-color: white;
            list-style: none;
            min-width: 13.75rem;
            display: none;
            padding: 0.625rem 0;
            margin: 0;
            border-radius: 0.375rem;
            box-shadow: 0 0.25rem 0.5rem rgba(0, 0, 0, 0.15);
            z-index: 1000;
        }
        .dropdown li a {
            display: block;
            padding: 0.75rem 1.25rem;
            color: #003087;
            text-decoration: none;
            font-weight: bold;
            white-space: nowrap;
            font-size: 0.8125rem;
        }
        .dropdown li a:hover {
            background-color: #f0f0f0;
        }
        .submenu {
            position: absolute;
            top: 0;
            left: 100%;
            background-color: white;
            min-width: 13.75rem;
            display: none;
            padding: 0.625rem 0;
            margin: 0;
            list-style: none;
            border-radius: 0.375rem;
            box-shadow: 0 0.25rem 0.5rem rgba(0, 0, 0, 0.15);
            z-index: 1000;
        }
        .submenu li a {
            display: block;
            padding: 0.75rem 1.25rem;
            color: #003087;
            text-decoration: none;
            font-weight: bold;
            white-space: nowrap;
            font-size: 0.8125rem;
        }
        .submenu li a:hover {
            background-color: #f0f0f0;
        }
        .navbar > li:hover > .dropdown {
            display: block;
        }
        .dropdown li:hover > .submenu {
            display: block;
        }

        /* News Detail Styles */
        .container-fluid {
            width: 100% !important;
            padding: 0 !important;
            margin: 0 !important;
        }
        .row {
            margin: 0 !important;
            width: 100%;
        }
        .col-md-12 {
            padding: 0 0.9375rem;
            width: 100%;
            box-sizing: border-box;
        }
        .news-detail {
            background-color: white;
            padding: 1.25rem;
            border-radius: 0.5rem;
            box-shadow: 0 0.125rem 0.25rem rgba(0,0,0,0.1);
            margin-bottom: 1.25rem;
        }
        .news-title {
            font-size: 2rem;
            color: #003087;
            margin-bottom: 0.625rem;
        }
        .news-date {
            color: #666;
            font-size: 0.875rem;
            margin-bottom: 0.9375rem;
        }
        .news-image {
            width: 100%;
            max-width: 100%;
            height: auto;
            border-radius: 0.3125rem;
            margin-bottom: 1.25rem;
        }
        .news-summary {
            font-style: italic;
            color: #555;
            margin-bottom: 1.25rem;
            font-size: 1rem;
            border-left: 0.1875rem solid #003087;
            padding-left: 0.9375rem;
        }
        .news-content {
            line-height: 1.6;
            color: #333;
            font-size: 1rem;
        }
        .breadcrumb {
            background-color: transparent;
            padding: 0.625rem 0;
        }
        .breadcrumb a {
            color: #003087;
            text-decoration: none;
        }
        .breadcrumb a:hover {
            text-decoration: underline;
        }
        .back-link {
            display: inline-block;
            margin-top: 1.25rem;
            color: #007bff;
            text-decoration: none;
            font-size: 0.875rem;
        }
        .back-link:hover {
            text-decoration: underline;
        }

        /* Footer Styles */
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
            justify-content: center;
            gap: 0.75rem;
            margin-top: 0.625rem;
        }
        .social-icons a {
            color: inherit;
            text-decoration: none;
        }
        .social-icons i {
            font-size: 1.375rem;
            cursor: pointer;
            transition: transform 0.2s;
        }
        .social-icons a:hover i {
            transform: scale(1.2);
            color: #ccc;
        }
        .back-to-top {
            position: fixed;
            bottom: 1.25rem;
            right: 1.25rem;
            font-size: 2.25rem;
            color: #fff;
            background-color: #007bff;
            border-radius: 50%;
            width: 3rem;
            height: 3rem;
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
            transition: transform 0.2s, background-color 0.2s;
            text-decoration: none !important;
        }
        .back-to-top:hover {
            transform: scale(1.2);
            background-color: #fff;
            color: #007bff;
        }
        .footer-bottom {
            text-align: center;
            margin-top: 1.25rem;
            font-size: 0.75rem;
        }
        .footer-col iframe {
            width: 100%;
            max-width: 15.625rem;
            height: 9.375rem;
        }
    </style>
</head>
<body>
    <header>
        <div class="header-top">
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
                            <li><a href="#">KHOA HỌC MÁY TÍNH</a></li>
                            <li><a href="#">KỸ THUẬT PHẦN MỀM</a></li>
                            <li><a href="#">HỆ THỐNG THÔNG TIN</a></li>
                            <li><a href="#">CÔNG NGHỆ THÔNG TIN</a></li>
                            <li><a href="#">CÔNG NGHỆ ĐA PHƯƠNG TIỆN</a></li>
                            <li><a href="#">AN TOÀN THÔNG TIN</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">SAU ĐẠI HỌC</a>
                        <ul class="submenu">
                            <li><a href="#">HỆ THỐNG THÔNG TIN</a></li>
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
        <img class="slide" src="<%= request.getContextPath() %>/<link href="https://sict.haui.edu.vn/dnn/web/haui/assets/images/favicon.png" rel="shortcut icon" type="image/png">" alt="Ảnh 1">
    </div>
        
    </header>

    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="news-detail">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Tin tức</a></li>
                            <li class="breadcrumb-item active" aria-current="page">${tieuDe}</li>
                        </ol>
                    </nav>
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger" role="alert">
                            <%= request.getAttribute("error") %>
                        </div>
                    <% } else { %>
                        <h1 class="news-title">${tieuDe}</h1>
                        <p class="news-date">${ngayCapNhat}</p>
                        <% if (request.getAttribute("urlAnh") != null && !request.getAttribute("urlAnh").equals("")) { %>
                            <img src="${urlAnh}" alt="Tin tức ảnh" class="news-image">
                        <% } else { %>
                            <p>Không có hình ảnh cho bài viết này.</p>
                        <% } %>
                        <div class="news-summary">${trichDanTin}</div>
                        <div class="news-content">${noiDungTin}</div>
                    <% } %>
                    <a href="${pageContext.request.contextPath}/" class="back-link">Quay lại</a>
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