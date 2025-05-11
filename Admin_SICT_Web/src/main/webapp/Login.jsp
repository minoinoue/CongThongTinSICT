<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang đăng nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/login.css"/>
</head>
<body>
    <div id="logreg-forms">
        <form class="form-signin" action="signin" method="post">
            <h1 class="text-center">Đăng nhập</h1>

            <c:if test="${resSuccess != null}">
                <div class="alert alert-success" role="alert">
                    ${resSuccess}
                </div>
            </c:if>
            <c:if test="${loginError != null}">
                <div class="alert alert-danger" role="alert">
                    ${loginError}
                </div>
            </c:if>

            <div class="mb-3">
                <input name="user" type="text" class="form-control" placeholder="Tên đăng nhập" required autofocus value="${username}">
            </div>

            <div class="mb-3">
                <input name="pass" type="password" class="form-control" placeholder="Mật khẩu" required value="${password}">
            </div>

            <button class="btn btn-primary w-100 mb-3" type="submit">
                <i class="fas fa-sign-in-alt me-2"></i>Xác nhận
            </button>

            <hr>
    </div>
    
    <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
    <div id="loginSuccessToast" class="toast align-items-center text-bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
                Đăng nhập thành công!
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>
    

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function toggleSignUp(e) {
            e.preventDefault();
            $('#logreg-forms .form-signin').toggle();
            $('#logreg-forms .form-signup').toggle();
        }

        $(() => {
            $('#btn-signup').click(toggleSignUp);
            $('#cancel_signup').click(toggleSignUp);
        });
    </script>
</body>
</html>
