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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
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
            display: none; 
        }

        .slideshow-container img.slide.active {
            display: block; /
        }

        /* News Section Header */
        .news-header {
            background-color: white;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .news-header h4 {
            color: #003087;
            font-size: 1.2em;
            margin-bottom: 15px;
        }

        .news-header ul {
            list-style: none;
            padding: 0;
        }

        .news-header ul li {
            margin-bottom: 10px;
        }

        .news-header ul li a {
            color: #333;
            text-decoration: none;
            font-size: 0.95em;
        }

        .news-header ul li a:hover {
            color: #003087;
            text-decoration: underline;
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
            font-size: 1.5em;
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

        .news-header h1 a {
            color: #007bff;
            text-decoration: none;
        }

        .news-header h1 a:hover {
            text-decoration: underline;
        }

        /* Add padding to the container to prevent content from being too close to footer */
        .container {
            padding-bottom: 40px;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="slideshow-container">
        <img class="slide active" src="<%= request.getContextPath() %>/images/ufi2226.jpg" alt="Ảnh 1">
        <img class="slide" src="<%= request.getContextPath() %>/images/ufi2234.jpg" alt="Ảnh 2">
        <img class="slide" src="<%= request.getContextPath() %>/images/ufi2235.jpg" alt="Ảnh 3">
    </div>

    <div class="container">
        <div class="row">
            <!-- PHẦN SICT News (TRÁI) -->
            <div class="col-md-8">
                <div class="news-header">
                    <h1>
                        <a href="TinTuc.jsp" style="text-decoration: none; color: inherit;">SICT News</a>
                    </h1>

                    <%
                        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        try (Connection conn = DatabaseConnection.getConnection()) {
                            if (conn == null) {
                                out.println("<p class='text-danger'>Lỗi: Không thể kết nối đến cơ sở dữ liệu.</p>");
                            } else {
                                String sql = "SELECT TOP 10 MaTinTuc, TieuDeTinTuc, TrichDanTin, NgayCapNhat, UrlAnh FROM TinTuc ORDER BY NgayCapNhat DESC";
                                PreparedStatement stmt = conn.prepareStatement(sql);
                                ResultSet rs = stmt.executeQuery();
                                while (rs.next()) {
                                    int maTinTuc = rs.getInt("MaTinTuc");
                                    String tieuDe = rs.getString("TieuDeTinTuc");
                                    String trichDan = rs.getString("TrichDanTin") != null ? rs.getString("TrichDanTin") : "";
                                    Timestamp ngayCapNhat = rs.getTimestamp("NgayCapNhat");
                                    String urlAnh = rs.getString("UrlAnh");
                                    String slug = tieuDe.toLowerCase().replaceAll("\\s+", "-").replaceAll("[^a-z0-9-]", "");
                    %>
                    <div class="news-item">
                        <% if (urlAnh != null && !urlAnh.isEmpty()) { %>
                            <img src="<%= urlAnh %>" alt="News Image">
                        <% } else { %>
                            <img src="https://via.placeholder.com/200x150" alt="Default Image">
                        <% } %>
                        <div class="content" style="color: #003399;">
                            <h3><a href="XemTinTuc.jsp?matintuc=<%= maTinTuc %>" style="text-decoration: none; color: inherit;">
                                <%= tieuDe %>
                            </a></h3>
                            <div class="text-muted mb-2"><%= dateFormat.format(ngayCapNhat) %></div>
                            <div class="summary"><%= trichDan %></div>
                        </div>
                    </div>
                    <%
                                }
                                rs.close();
                                stmt.close();
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                            out.println("<p class='text-danger'>Lỗi khi tải danh sách tin tức: " + e.getMessage() + "</p>");
                        }
                    %>
                </div>
            </div>

            <!-- PHẦN Thông báo (PHẢI) -->
            <div class="col-md-4">
                <div class="recent-news">
                    <h4>Thông báo</h4>
                    <ul>
                        <%
                            try (Connection conn = DatabaseConnection.getConnection()) {
                                if (conn == null) {
                                    out.println("<p class='text-danger'>Lỗi: Không thể kết nối đến cơ sở dữ liệu.</p>");
                                } else {
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
                                    rs.close();
                                    stmt.close();
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

    <%@ include file="footer.jsp" %>

    <script>
        // Simple slideshow script
        const slides = document.querySelectorAll('.slideshow-container .slide');
        let currentSlide = 0;

        function showSlide(index) {
            slides.forEach((slide, i) => {
                slide.classList.toggle('active', i === index);
            });
        }

        function nextSlide() {
            currentSlide = (currentSlide + 1) % slides.length;
            showSlide(currentSlide);
        }

        showSlide(currentSlide);

        setInterval(nextSlide, 5000);
    </script>
    <script src="<%= request.getContextPath() %>/script.js"></script>
</body>
</html>
