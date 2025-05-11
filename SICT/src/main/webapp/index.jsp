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
        /* Existing styles remain unchanged */
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
            display: block;
        }
        .news-header, .club-header, .outstanding-student-header, .recent-news {
            background-color: white;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .news-header h4, .club-header h4, .outstanding-student-header h4, .recent-news h4 {
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
        .news-item, .club-item, .outstanding-student-item {
            display: flex;
            margin-bottom: 20px;
            background-color: white;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .news-item img, .club-item img, .outstanding-student-item img {
            width: 200px;
            height: 150px;
            object-fit: cover;
            margin-right: 15px;
            border-radius: 5px;
        }
        .news-item .content, .club-item .content, .outstanding-student-item .content {
            flex: 1;
        }
        .news-item .content h3, .club-item .content h3, .outstanding-student-item .content h3 {
            font-size: 1.5em;
            margin: 0 0 10px;
        }
        .news-item .content h3 a, .club-item .content h3 a, .outstanding-student-item .content h3 a {
            color: #003087;
            text-decoration: none;
        }
        .news-item .content h3 a:hover, .club-item .content h3 a:hover, .outstanding-student-item .content h3 a:hover {
            text-decoration: underline;
        }
        .news-item .content .date, .club-item .content .date, .outstanding-student-item .content .date {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 10px;
        }
        .news-item .content .summary, .club-item .content .summary, .outstanding-student-item .content .summary {
            color: #333;
            line-height: 1.6;
        }
        .news-header h1 a, .club-header h1 a, .outstanding-student-header h1 a {
            color: #007bff;
            text-decoration: none;
        }
        .news-header h1 a:hover, .club-header h1 a:hover, .outstanding-student-header h1 a:hover {
            text-decoration: underline;
        }
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
            <!-- PHẦN SICT News, Câu lạc bộ và Gương sáng sinh viên (TRÁI) -->
            <div class="col-md-8">
                <!-- SICT News -->
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

                <!-- Câu lạc bộ -->
                <div class="club-header mt-4">
                    <h1>
                        <a href="CauLacBo.jsp" style="text-decoration: none; color: inherit;">Câu lạc bộ</a>
                    </h1>
                    <%
                        try (Connection conn = DatabaseConnection.getConnection()) {
                            if (conn == null) {
                                out.println("<p class='text-danger'>Lỗi: Không thể kết nối đến cơ sở dữ liệu.</p>");
                            } else {
                                String sql = "SELECT TOP 5 MaCauLacBo, TenCauLacBo, MoTaNgan, NgayCapNhat, UrlAnh FROM CauLacBo ORDER BY NgayCapNhat DESC";
                                PreparedStatement stmt = conn.prepareStatement(sql);
                                ResultSet rs = stmt.executeQuery();
                                while (rs.next()) {
                                    int maCauLacBo = rs.getInt("MaCauLacBo");
                                    String tenCauLacBo = rs.getString("TenCauLacBo");
                                    String moTaNgan = rs.getString("MoTaNgan") != null ? rs.getString("MoTaNgan") : "";
                                    Timestamp ngayCapNhat = rs.getTimestamp("NgayCapNhat");
                                    String urlAnh = rs.getString("UrlAnh");
                                    String slug = tenCauLacBo.toLowerCase().replaceAll("\\s+", "-").replaceAll("[^a-z0-9-]", "");
                    %>
                    <div class="club-item">
                        <% if (urlAnh != null && !urlAnh.isEmpty()) { %>
                            <img src="<%= urlAnh %>" alt="Club Image">
                        <% } else { %>
                            <img src="https://via.placeholder.com/200x150" alt="Default Image">
                        <% } %>
                        <div class="content" style="color: #003399;">
                            <h3><a href="XemCauLacBo.jsp?maclub=<%= maCauLacBo %>" style="text-decoration: none; color: inherit;">
                                <%= tenCauLacBo %>
                            </a></h3>
                            <div class="text-muted mb-2"><%= dateFormat.format(ngayCapNhat) %></div>
                            <div class="summary"><%= moTaNgan %></div>
                        </div>
                    </div>
                    <%
                                }
                                rs.close();
                                stmt.close();
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                            out.println("<p class='text-danger'>Lỗi khi tải danh sách câu lạc bộ: " + e.getMessage() + "</p>");
                        }
                    %>
                </div>

                <!-- Gương sáng sinh viên -->
                <div class="outstanding-student-header mt-4">
                    <h1>
                        <a href="GuongSangSV.jsp" style="text-decoration: none; color: inherit;">Gương sáng sinh viên</a>
                    </h1>
                    <%
                        try (Connection conn = DatabaseConnection.getConnection()) {
                            if (conn == null) {
                                out.println("<p class='text-danger'>Lỗi: Không thể kết nối đến cơ sở dữ liệu.</p>");
                            } else {
                                String sql = "SELECT TOP 5 MaGuongSang, TenSinhVien, MoTaNgan, NgayCapNhat, UrlAnh FROM GuongSangSV ORDER BY NgayCapNhat DESC";
                                PreparedStatement stmt = conn.prepareStatement(sql);
                                ResultSet rs = stmt.executeQuery();
                                while (rs.next()) {
                                    int maGuongSang = rs.getInt("MaGuongSang");
                                    String tenSinhVien = rs.getString("TenSinhVien");
                                    String moTaNgan = rs.getString("MoTaNgan") != null ? rs.getString("MoTaNgan") : "";
                                    Timestamp ngayCapNhat = rs.getTimestamp("NgayCapNhat");
                                    String urlAnh = rs.getString("UrlAnh");
                                    String slug = tenSinhVien.toLowerCase().replaceAll("\\s+", "-").replaceAll("[^a-z0-9-]", "");
                    %>
                    <div class="outstanding-student-item">
                        <% if (urlAnh != null && !urlAnh.isEmpty()) { %>
                            <img src="<%= urlAnh %>" alt="Outstanding Student Image">
                        <% } else { %>
                            <img src="https://via.placeholder.com/200x150" alt="Default Image">
                        <% } %>
                        <div class="content" style="color: #003399;">
                            <h3><a href="XemGuongSangSV.jsp?maguongsang=<%= maGuongSang %>" style="text-decoration: none; color: inherit;">
                                <%= tenSinhVien %>
                            </a></h3>
                            <div class="text-muted mb-2"><%= dateFormat.format(ngayCapNhat) %></div>
                            <div class="summary"><%= moTaNgan %></div>
                        </div>
                    </div>
                    <%
                                }
                                rs.close();
                                stmt.close();
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                            out.println("<p class='text-danger'>Lỗi khi tải danh sách gương sáng sinh viên: " + e.getMessage() + "</p>");
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