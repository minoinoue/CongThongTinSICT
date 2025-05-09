<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${tieuDe != null ? tieuDe : 'Tin Tức'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../styles.css">
    <style>
        body {
            background-color: #f5f5f5;
        }
        .header {
            background-color: #003087;
            color: white;
            padding: 15px 0;
            text-align: center;
            margin-bottom: 20px;
        }
        .news-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .breadcrumb {
            background-color: transparent;
            padding: 10px 0;
        }
        .breadcrumb a {
            color: #003087;
            text-decoration: none;
        }
        .breadcrumb a:hover {
            text-decoration: underline;
        }
        .news-title {
            font-size: 2.5em;
            color: #003087;
            margin-bottom: 10px;
        }
        .news-date {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 20px;
        }
        .news-image {
            width: 100%;
            height: auto;
            margin-bottom: 20px;
            border-radius: 5px;
        }
        .news-summary {
            font-style: italic;
            color: #555;
            margin-bottom: 20px;
            font-size: 1.1em;
            border-left: 3px solid #003087;
            padding-left: 15px;
        }
        .news-content {
            line-height: 1.8;
            color: #333;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>SICT News</h1>
    </div>
    <div class="news-container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index">Tin tức</a></li>
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
        <a href="${pageContext.request.contextPath}/index" class="back-link">Quay lại</a>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>