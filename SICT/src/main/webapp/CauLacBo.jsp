<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vn.connection.DatabaseConnection" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Câu lạc bộ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        html {
            font-size: 16px;
        }
        .club-item {
            display: flex;
            margin-bottom: 20px;
            background-color: white;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .club-item img {
            width: 200px;
            height: 150px;
            object-fit: cover;
            margin-right: 15px;
            border-radius: 5px;
        }
        .club-item .content {
            flex: 1;
        }
        .club-item .content h3 {
            font-size: 1.5em;
            margin: 0 0 10px;
        }
        .club-item .content h3 a {
            color: #003087;
            text-decoration: none;
        }
        .club-item .content h3 a:hover {
            text-decoration: underline;
        }
        .club-item .content .date {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 10px;
        }
        .club-item .content .summary {
            color: #333;
            line-height: 1.6;
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
        <img class="slide" src="https://pbs.twimg.com/media/Gqpzy2-WEAA0cHY?format=jpg&name=900x900" alt="Ảnh 2">
    </div>

    <div class="container my-4">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <div class="club-detail">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="<%= request.getContextPath() %>/trang-chu">Trang chủ</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Câu lạc bộ</li>
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
        <%
            SimpleDateFormat dateFormat = new SimpleDateFormat("EEEE, HH:mm dd/MM/yyyy");
            try (Connection conn = DatabaseConnection.getConnection()) {
                String sql = "SELECT MaCauLacBo, TenCauLacBo, MoTaNgan, NgayCapNhat, UrlAnh FROM CauLacBo ORDER BY NgayCapNhat DESC";
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    int maCauLacBo = rs.getInt("MaCauLacBo");
                    String tenCauLacBo = rs.getString("TenCauLacBo");
                    String moTaNgan = rs.getString("MoTaNgan");
                    Timestamp ngayCapNhat = rs.getTimestamp("NgayCapNhat");
                    String urlAnh = rs.getString("UrlAnh");
        %>
        <div class="row mb-4 p-3 bg-light rounded shadow-sm">
            <% if (urlAnh != null && !urlAnh.isEmpty()) { %>
            <div class="col-md-4">
                <img src="<%= urlAnh %>" alt="Ảnh câu lạc bộ" class="img-fluid rounded">
            </div>
            <% } %>
            <div class="col-md-8 d-flex flex-column justify-content-between">
                <div>
                    <h5 class="fw-bold" style="color: #003399;">
                        <a href="XemCauLacBo.jsp?maclub=<%= maCauLacBo %>" style="text-decoration: none; color: inherit;">
                            <%= tenCauLacBo %>
                        </a>
                    </h5>
                    <p class="text-muted mb-2"><%= dateFormat.format(ngayCapNhat) %></p>
                    <p class="text-body"><%= moTaNgan %></p>
                </div>
                <div>
                    <a href="XemCauLacBo.jsp?maclub=<%= maCauLacBo %>" class="fw-bold text-primary">Xem thêm</a>
                </div>
            </div>
        </div>
        <%
                }
            } catch (SQLException e) {
                out.println("<div class='alert alert-danger'>Lỗi khi tải dữ liệu: " + e.getMessage() + "</div>");
            }
        %>
    </div>

    <%@ include file="footer.jsp" %>

    <script src="<%= request.getContextPath() %>/script.js"></script>
</body>
</html>