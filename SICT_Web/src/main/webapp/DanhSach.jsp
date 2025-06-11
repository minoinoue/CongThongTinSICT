<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>
        <c:choose>
            <c:when test="${type == 'tuyen-sinh-dai-hoc'}">Tuyển Sinh Đại Học</c:when>
            <c:when test="${type == 'tuyen-sinh-sau-dai-hoc'}">Tuyển Sinh Sau Đại Học</c:when>
            <c:when test="${type == 'tin-tuc'}">Tin tức</c:when>
            <c:when test="${type == 'cau-lac-bo'}">Câu lạc bộ</c:when>
            <c:when test="${type == 'guong-sang-sv'}">Gương sáng sinh viên</c:when>
            <c:otherwise>Danh sách</c:otherwise>
        </c:choose>
    </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        html { font-size: 16px; }
        .item {
            display: flex;
            margin-bottom: 20px;
            background-color: white;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .item img {
            width: 200px;
            height: 150px;
            object-fit: cover;
            margin-right: 15px;
            border-radius: 5px;
        }
        .item .content { flex: 1; }
        .item .content h5 {
            font-size: 1.5em;
            margin: 0 0 10px;
        }
        .item .content h5 a {
            color: #003087;
            text-decoration: none;
        }
        .item .content h5 a:hover {
            text-decoration: underline;
        }
        .item .content .date {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 10px;
        }
        .item .content .summary {
            color: #333;
            line-height: 1.6;
        }
        .container { padding-bottom: 40px; }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container my-4">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <div class="detail">
                        <div class="d-flex justify-content-between align-items-center">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="<%= request.getContextPath() %>/trang-chu">Trang chủ</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">
                                        <c:choose>
                                            <c:when test="${type == 'tuyen-sinh-dai-hoc'}">Tuyển Sinh Đại Học</c:when>
                                            <c:when test="${type == 'tuyen-sinh-sau-dai-hoc'}">Tuyển Sinh Sau Đại Học</c:when>
                                            <c:when test="${type == 'tin-tuc'}">Tin tức</c:when>
                                            <c:when test="${type == 'cau-lac-bo'}">Câu lạc bộ</c:when>
                                            <c:when test="${type == 'guong-sang-sv'}">Gương sáng sinh viên</c:when>
                                            <c:otherwise>Danh sách</c:otherwise>
                                        </c:choose>
                                    </li>
                                </ol>
                            </nav>
                            <!-- Tìm kiếm (ẩn cho tuyển sinh nếu không cần) -->
                            <c:if test="${type != 'tuyen-sinh-dai-hoc' && type != 'tuyen-sinh-sau-dai-hoc'}">
                                <form class="d-flex" action="tim-kiem" method="get">
                                    <input type="hidden" name="type" value="${type}">
                                    <input class="form-control me-2" type="search" placeholder="Tìm kiếm..." aria-label="Search" name="query">
                                    <button class="btn btn-outline-primary" type="submit">Tìm</button>
                                </form>
                            </c:if>
                        </div>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                ${error}
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <c:forEach var="item" items="${itemList}">
            <div class="row mb-4 p-3 bg-light rounded shadow-sm">
                <div class="col-md-4">
                    <c:choose>
                        <c:when test="${not empty item.urlAnh}">
                            <img src="<%= request.getContextPath() %>${item.urlAnh}" alt="Ảnh" class="img-fluid rounded">
                        </c:when>
                        <c:otherwise>
                            <img src="https://via.placeholder.com/200x150" alt="Ảnh mặc định" class="img-fluid rounded">
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="col-md-8 d-flex flex-column justify-content-between">
                    <div>
                        <h5 class="fw-bold" style="color: #003399;">
                            <a href="xem-chi-tiet?matintuc=${item.maTinTuc}&type=${type}" style="text-decoration: none; color: inherit;">
                                ${item.tieuDeTinTuc}
                            </a>
                        </h5>
                        <p class="text-muted mb-2">
                            <fmt:parseDate value="${item.ngayCapNhat}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" />
                            <fmt:formatDate value="${parsedDate}" pattern="EEEE, HH:mm dd/MM/yyyy"/>
                        </p>
                        <p class="text-body"><c:out value="${item.trichDanTin}" escapeXml="false"/></p>
                        <c:if test="${not empty item.soLanDoc}">
                            <p class="text-muted small">Lượt xem: ${item.soLanDoc}</p>
                        </c:if>
                        <c:if test="${not empty item.tag}">
                            <p class="text-muted small">Tags: ${item.tag}</p>
                        </c:if>
                    </div>
                    <div>
                        <a href="xem-chi-tiet?matintuc=${item.maTinTuc}&type=${type}" class="fw-bold text-primary">Xem thêm</a>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty itemList}">
            <p>Không có ${type == 'tuyen-sinh-dai-hoc' ? 'tin tức tuyển sinh đại học' : type == 'tuyen-sinh-sau-dai-hoc' ? 'tin tức tuyển sinh sau đại học' : type == 'tin-tuc' ? 'tin tức' : type == 'cau-lac-bo' ? 'câu lạc bộ' : 'gương sáng sinh viên'} nào để hiển thị.</p>
        </c:if>
    </div>

    <%@ include file="footer.jsp" %>
    <script src="<%= request.getContextPath() %>/script.js"></script>
</body>
</html>