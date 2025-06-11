<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${news != null ? news.tieuDeTinTuc : 'Thông Tin Chung'}"/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        .container { max-width: 1200px; margin: 20px auto; padding: 20px; background-color: white; border-radius: 8px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); }
        h2 { color: #003366; font-weight: bold; margin-bottom: 20px; }
        .content { font-size: 16px; line-height: 1.8; color: #333; }
        .content p { margin-bottom: 1.5rem; }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container my-5">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="<%= request.getContextPath() %>/trang-chu">Trang chủ</a></li>
                <li class="breadcrumb-item active" aria-current="page"><c:out value="${news.tieuDeTinTuc}"/></li>
            </ol>
        </nav>

        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">${error}</div>
        </c:if>

        <c:choose>
            <c:when test="${news != null}">
                <h2 class="mb-3 text-primary"><c:out value="${news.tieuDeTinTuc}"/></h2>
                <p class="text-muted mb-3">
                    <c:catch var="parseException">
                        <fmt:parseDate value="${news.ngayCapNhat}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" />
                        <fmt:formatDate value="${parsedDate}" pattern="EEEE, HH:mm dd/MM/yyyy"/>
                    </c:catch>
                    <c:if test="${not empty parseException}">
                        ${news.ngayCapNhat} <!-- Hiển thị ngày gốc nếu không parse được -->
                    </c:if>
                </p>
                <c:if test="${not empty news.urlAnh}">
                    <img src="${news.urlAnh}" alt="Ảnh thông tin" width="730" height="500">
                </c:if>
                <div class="mb-4 content" style="line-height: 1.8;"><c:out value="${news.noiDungTin}" escapeXml="false"/></div>
                <c:if test="${not empty news.soLanDoc}">
                    <p class="text-muted small">Lượt xem: ${news.soLanDoc}</p>
                </c:if>
                <c:if test="${not empty news.tag}">
                    <p class="text-muted small">Tags: ${news.tag}</p>
                </c:if>
            </c:when>
            <c:otherwise>
                <div class="alert alert-warning">Nội dung đang được cập nhật.</div>
            </c:otherwise>
        </c:choose>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>