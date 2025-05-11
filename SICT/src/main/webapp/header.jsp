<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
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
</body>
</html>