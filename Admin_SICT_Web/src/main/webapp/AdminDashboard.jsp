<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Quản Lý Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <style>
        body {
            margin: 0;
            font-family: 'Roboto', sans-serif;
            background-color: #f1f3f5;
        }
        .container-fluid {
            height: 100vh;
            display: flex;
        }
        .sidebar {
            width: 250px;
            background-color: #343a40;
            color: #ffffff;
            padding-top: 20px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        }
        .sidebar-header {
            text-align: center;
            padding: 20px 0;
            border-bottom: 1px solid #495057;
        }
        .sidebar-header h3 {
            margin: 0;
            font-size: 1.5rem;
            color: #ffffff;
        }
        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .sidebar-menu li {
            border-bottom: 1px solid #495057;
        }
        .sidebar-menu li a {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            color: #adb5bd;
            text-decoration: none;
            font-size: 1.1rem;
            transition: background-color 0.3s, color 0.3s;
        }
        .sidebar-menu li a i {
            margin-right: 10px;
        }
        .sidebar-menu li a:hover,
        .sidebar-menu li a.active {
            background-color: #495057;
            color: #ffffff;
        }
        .main-content {
            flex: 1;
            padding: 20px;
            background-color: #ffffff;
            overflow-y: auto;
        }
        .content-frame {
            width: 100%;
            height: 100%;
            border: none;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }
        .sidebar-menu .logout-item a {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            color: #dc3545;
            text-decoration: none;
            font-size: 1.1rem;
            transition: background-color 0.3s, color 0.3s;
        }
        .sidebar-menu .logout-item a i {
            margin-right: 10px;
        }
        .sidebar-menu .logout-item a:hover {
            background-color: #b02a37;
            color: #ffffff;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-header">
                <h3>Quản Lý Admin</h3>
                <c:if test="${not empty ADMIN}">
                    <p>Xin chào, <strong>${ADMIN.fullName}</strong>!</p>
                </c:if>
            </div>
            <ul class="sidebar-menu">
                <li>
                    <a href="manage" target="contentFrame" class="active">
                        <i class="material-icons">article</i> Quản lý Tin tức
                    </a>
                </li>
                <li>
                    <a href="manager-category-tin" target="contentFrame">
                        <i class="material-icons">category</i> Quản lý Thể loại
                    </a>
                </li>
                <li>
                    <a href="manage-comments" target="contentFrame">
                        <i class="material-icons">comment</i> Quản lý Bình luận
                    </a>
                </li>
                <li>
                    <a href="manage-users" target="contentFrame">
                        <i class="material-icons">person</i> Quản lý Người dùng
                    </a>
                </li>
                <li>
                    <a href="manage-comment-stats" target="contentFrame">
                        <i class="material-icons">comment</i> Thống kê Bình luận
                    </a>
                </li>
                <li>
                    <a href="manage-view-stats" target="contentFrame">
                        <i class="material-icons">visibility</i> Thống kê Lượt đọc
                    </a>
                </li>
                <li class="logout-item">
                    <a href="login" target="_top">
                        <i class="material-icons">exit_to_app</i> Đăng xuất
                    </a>
                </li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <iframe name="contentFrame" class="content-frame" src="manage"></iframe>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Highlight active menu item
        document.querySelectorAll('.sidebar-menu a').forEach(link => {
            link.addEventListener('click', function() {
                document.querySelectorAll('.sidebar-menu li a').forEach(a => a.classList.remove('active'));
                this.classList.add('active');
            });
        });
    </script>
</body>
</html>