<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
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
    </style>
</head>
<body>
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
</body>
</html>