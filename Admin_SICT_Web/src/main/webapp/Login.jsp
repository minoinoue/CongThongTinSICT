<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/login.css"/>
</head>
<body>
    <div id="logreg-forms">
        <form class="form-signin" action="signin" method="post">
            <h1 class="text-center">Welcome Back</h1>
            
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
                <input name="user" type="text" id="inputEmail" class="form-control" placeholder="Username" required autofocus value="${username}">
            </div>
            
            <div class="mb-3">
                <input name="pass" type="password" id="inputPassword" class="form-control" placeholder="Password" required value="${password}">
            </div>

            <button class="btn btn-primary w-100 mb-3" type="submit">
                <i class="fas fa-sign-in-alt me-2"></i>Sign in
            </button>
            
            <hr>
            
            <button class="btn btn-outline-primary w-100" type="button" id="btn-signup">
                <i class="fas fa-user-plus me-2"></i>Create Account
            </button>
        </form>

        <form action="signup" method="post" class="form-signup">
            <h1 class="text-center">Create Account</h1>
            
            <c:if test="${resError != null}">
                <div class="alert alert-danger" role="alert">
                    ${resError}
                </div>
            </c:if>

            <div class="mb-3">
                <input name="user" type="text" id="user-name" class="form-control" placeholder="Username" required>
            </div>
            
            <div class="mb-3">
                <input name="name" type="text" id="user-fullname" class="form-control" placeholder="Your name" required>
            </div>
            
            <div class="mb-3">
                <input name="pass" type="password" id="user-pass" class="form-control" placeholder="Password" required>
            </div>
            
            <div class="mb-3">
                <input name="repass" type="password" id="user-repeatpass" class="form-control" placeholder="Confirm Password" required>
            </div>

            <button class="btn btn-primary w-100" type="submit">
                <i class="fas fa-user-plus me-2"></i>Sign Up
            </button>
            
            <a href="#" id="cancel_signup">
                <i class="fas fa-angle-left me-2"></i>Back to login
            </a>
        </form>
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
            $('#logreg-forms #btn-signup').click(toggleSignUp);
            $('#logreg-forms #cancel_signup').click(toggleSignUp);
        });
    </script>
</body>
</html>