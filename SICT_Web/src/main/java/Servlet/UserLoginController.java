package Servlet;

import connection.UserDAO;
import model.Users;
import java.io.IOException;
import java.sql.Timestamp;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet({"/user/login", "/user/signin", "/user/signup", "/user/logout"})
public class UserLoginController extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = request.getServletPath();
        switch (url.toLowerCase()) {
            case "/user/login":
            case "/user/signup":
                showForm(request, response);
                break;
            case "/user/logout":
                logout(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String url = request.getServletPath();
        switch (url.toLowerCase()) {
            case "/user/signin":
                postLogin(request, response);
                break;
            case "/user/signup":
                postRegister(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/UserLogin.jsp").forward(request, response);
    }

    private void logout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("USER");
        response.sendRedirect("/SICT_Web/trang-chu");
    }

    private void postLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("user");
        String password = request.getParameter("pass");

        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("loginError", "Vui lòng nhập tên đăng nhập và mật khẩu.");
            request.getRequestDispatcher("/UserLogin.jsp").forward(request, response);
            return;
        }

        Users user = userDAO.login(username, password);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("USER", user);
            session.setMaxInactiveInterval(1800); // 30 minutes
            response.sendRedirect(request.getContextPath() + "/trang-chu");
        } else {
            request.setAttribute("username", username);
            request.setAttribute("loginError", "Tên đăng nhập hoặc mật khẩu không đúng.");
            request.getRequestDispatcher("/UserLogin.jsp").forward(request, response);
        }
    }

    private void postRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("user");
        String password = request.getParameter("pass");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");

        if (username == null || password == null || fullName == null || email == null ||
            username.trim().isEmpty() || password.trim().isEmpty() || fullName.trim().isEmpty() || email.trim().isEmpty()) {
            request.setAttribute("registerError", "Vui lòng điền đầy đủ thông tin.");
            request.getRequestDispatcher("/UserLogin.jsp").forward(request, response);
            return;
        }

        if (userDAO.isUsernameTaken(username)) {
            request.setAttribute("registerError", "Tên đăng nhập đã tồn tại.");
            request.getRequestDispatcher("/UserLogin.jsp").forward(request, response);
            return;
        }
        if (userDAO.isEmailTaken(email)) {
            request.setAttribute("registerError", "Email đã được sử dụng.");
            request.getRequestDispatcher("/UserLogin.jsp").forward(request, response);
            return;
        }

        Users user = new Users();
        user.setUsername(username);
        user.setPasswordHash(password); // Note: Hash in production
        user.setFullName(fullName);
        user.setEmail(email);
        user.setNgayDangKy(new Timestamp(System.currentTimeMillis()));

        boolean success = userDAO.register(user);
        if (success) {
            request.setAttribute("resSuccess", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("/UserLogin.jsp").forward(request, response);
        } else {
            request.setAttribute("registerError", "Đăng ký thất bại. Vui lòng thử lại.");
            request.getRequestDispatcher("/UserLogin.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles user login, registration, and logout";
    }
}