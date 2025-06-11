<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/fonts/themify-icons/themify-icons.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Container để căn giữa */
        .navbar-container {
            max-width: 1200px; /* Giới hạn chiều rộng tối đa */
            margin: 0 auto; /* Căn giữa */
        }

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
            padding: 10px 12px;
            color: white;
            font-weight: bold;
            text-decoration: none;
            white-space: nowrap;
            font-size: 14px;
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
            min-width: 200px;
            display: none;
            padding: 5px 0;
            margin: 0;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.15);
            z-index: 1000;
        }

        .dropdown li a {
            display: block;
            padding: 8px 15px;
            color: #003366;
            text-decoration: none;
            font-weight: bold;
            white-space: nowrap;
            font-size: 14px;
        }

        .dropdown li a:hover {
            background-color: #f0f0f0;
        }

        .submenu {
            position: absolute;
            top: 0;
            left: 100%;
            background-color: white;
            min-width: 200px;
            display: none;
            padding: 5px 0;
            margin: 0;
            list-style: none;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.15);
            z-index: 1000;
        }

        .submenu li a {
            display: block;
            padding: 8px 15px;
            color: #003366;
            text-decoration: none;
            font-weight: bold;
            white-space: nowrap;
            font-size: 14px;
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

        /* Logo and Title */
        .logobar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            background-color: #f5f5f5;
            position: relative;
            min-height: 60px; /* Match logo height */
        }

        .logo-title {
            display: flex;
            align-items: center;
        }

        .logobar img {
            height: 60px;
            margin-right: 10px;
        }

        .logobar h1 {
            margin: 0;
            font-size: 24px;
            color: #003366;
            line-height: 60px; /* Align vertically with logo */
        }

        /* User login/logout */
        .user-menu {
            display: block; /* Hidden by default */
            position: relative;
        }

        .logobar:hover .user-menu {
            display: block; /* Show on hover over logobar */
        }

        .user-menu a, .user-menu .dropdown-toggle {
            color: #003366;
            font-weight: bold;
            text-decoration: none;
            padding: 8px 12px;
            font-size: 14px;
            display: block;
            white-space: nowrap;
        }

        .user-menu .btn-login {
            background-color: #005599;
            color: white;
            border-radius: 4px;
        }

        .user-menu:hover .dropdown-toggle {
            background-color: #e0e0e0;
        }

        .user-menu .dropdown-menu {
            min-width: 150px;
            margin-top: 0;
        }

        .user-menu .dropdown-menu a {
            color: #003366;
            padding: 8px 15px;
        }

        .user-menu .dropdown-menu a:hover {
            background-color: #f0f0f0;
        }
    </style>
</head>
<body>
    <div class="logobar">
        <div class="logo-title">
            <img src="<%= request.getContextPath() %>/images/logo.png" alt="Logo HaUI">
            <h1>TRƯỜNG CÔNG NGHỆ THÔNG TIN</h1>
        </div>

        <!-- User Login/Logout -->
        <div class="user-menu">
            <c:choose>
                <c:when test="${not empty sessionScope.USER}">
                    <a href="#" class="dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-person-circle me-1"></i><c:out value="${sessionScope.USER.fullName}"/>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="<%= request.getContextPath() %>/user/logout">Đăng xuất</a></li>
                    </ul>
                </c:when>
                <c:otherwise>
                    <a href="<%= request.getContextPath() %>/user/login" class="btn btn-sm btn-login">
                        <i class="bi bi-box-arrow-in-right me-1"></i>Đăng nhập
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="navbar-container">
        <ul class="navbar">
            <li><a href="https://www.haui.edu.vn/vn">TRANG HAUI</a></li>
            <li>
                <a href="#">GIỚI THIỆU <i class="bi bi-chevron-down ms-auto"></i></a>
                <ul class="dropdown">
                    <li><a href="<%= request.getContextPath() %>/gioi_thieu">THÔNG TIN CHUNG</a></li>
                    <li><a href="<%= request.getContextPath() %>/gioi_thieu?cat=co_cau_to_chuc">CƠ CẤU TỔ CHỨC</a></li>
                    <li><a href="<%= request.getContextPath() %>/gioi_thieu?cat=chien_luoc_phat_trien">CHIẾN LƯỢC PHÁT TRIỂN</a></li>
                    <li><a href="<%= request.getContextPath() %>/gioi_thieu?cat=can_bo_giang_vien">CÁN BỘ GIẢNG VIÊN</a></li>
                    <li><a href="<%= request.getContextPath() %>/gioi_thieu?cat=co_so_vat_chat">CƠ SỞ VẬT CHẤT</a></li>
                    <li><a href="<%= request.getContextPath() %>/gioi_thieu?cat=lien_he">LIÊN HỆ</a></li>
                </ul>
            </li>
            <li>
                <a href="#">ĐÀO TẠO <i class="bi bi-chevron-down ms-auto"></i></a>
                <ul class="dropdown">
                    <li>
                        <a href="#">ĐẠI HỌC</a>
                        <ul class="submenu">
                            <li class="submenu-item"><a href="<%= request.getContextPath() %>/dao_tao?cat=khoa_hoc_may_tinh">KHOA HỌC MÁY TÍNH</a></li>
                            <li class="submenu-item"><a href="<%= request.getContextPath() %>/dao_tao?cat=ky_thuat_phan_mem">KỸ THUẬT PHẦN MỀM</a></li>
                            <li class="submenu-item"><a href="<%= request.getContextPath() %>/dao_tao?cat=he_thong_thong_tin">HỆ THỐNG THÔNG TIN</a></li>
                            <li class="submenu-item"><a href="<%= request.getContextPath() %>/dao_tao?cat=cong_nghe_thong_tin">CÔNG NGHỆ THÔNG TIN</a></li>
                            <li class="submenu-item"><a href="<%= request.getContextPath() %>/dao_tao?cat=cong_nghe_da_phuong_tien">CÔNG NGHỆ ĐA PHƯƠNG TIỆN</a></li>
                            <li class="submenu-item"><a href="<%= request.getContextPath() %>/dao_tao?cat=an_toan_thong_tin">AN TOÀN THÔNG TIN</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">SAU ĐẠI HỌC</a>
                        <ul class="submenu">
                            <li class="submenu-item"><a href="<%= request.getContextPath() %>/dao_tao?cat=sau_he_thong_thong_tin">HỆ THỐNG THÔNG TIN</a></li>
                        </ul>
                    </li>
                    <li><a href="<%= request.getContextPath() %>/dao_tao?cat=quy_che_bieu_mau">QUY CHẾ, BIỂU MẪU</a></li>
                </ul>
            </li>
            <li>
                <a href="#">TUYỂN SINH <i class="bi bi-chevron-down ms-auto"></i></a>
                <ul class="dropdown">
                    <li><a href="<%= request.getContextPath() %>/tuyen-sinh-dai-hoc">ĐẠI HỌC</a></li>
                    <li><a href="<%= request.getContextPath() %>/tuyen-sinh-sau-dai-hoc">SAU ĐẠI HỌC</a></li>
                </ul>
            </li>
            <li>
                <a href="#">KHOA <i class="bi bi-chevron-down ms-auto"></i></a>
                <ul class="dropdown">
                    <li><a href="<%= request.getContextPath() %>/khoa?cat=cong_nghe_thong_tin">KHOA CÔNG NGHỆ THÔNG TIN</a></li>
                    <li><a href="<%= request.getContextPath() %>/khoa?cat=cong_nghe_phan_mem">KHOA CÔNG NGHỆ PHẦN MỀM</a></li>
                    <li><a href="<%= request.getContextPath() %>/khoa?cat=khoa_hoc_may_tinh">KHOA KHOA HỌC MÁY TÍNH</a></li>
                    <li><a href="<%= request.getContextPath() %>/khoa?cat=mang_may_tinh">KHOA MẠNG MÁY TÍNH VÀ TRUYỀN THÔNG</a></li>
                </ul>
            </li>
            <li>
                <a href="#">PHÒNG/TRUNG TÂM <i class="bi bi-chevron-down ms-auto"></i></a>
                <ul class="dropdown">
                    <li><a href="<%= request.getContextPath() %>/phong_trungtam?cat=tong_hop">PHÒNG TỔNG HỢP</a></li>
                    <li><a href="<%= request.getContextPath() %>/phong_trungtam?cat=hop_tac_phat_trien">TRUNG TÂM HỢP TÁC PHÁT TRIỂN</a></li>
                    <li><a href="<%= request.getContextPath() %>/phong_trungtam?cat=nghien_cuu_ict">TRUNG TÂM NGHIÊN CỨU CÔNG NGHỆ TIÊN TIẾN ICT</a></li>
                </ul>
            </li>
        </ul>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>