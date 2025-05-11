/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dal.Admin1DAO;
import Model.Admin1;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Lenovo
 */
public class LoginController extends HttpServlet {

	Admin1DAO uDB = new Admin1DAO();

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		String url = request.getServletPath();
		switch (url.toLowerCase()) {
		case "/login":
			login(request, response);
			break;
		case "/logout":
			logout(request, response);
			break;
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url = request.getServletPath();
		switch (url.toLowerCase()) {
		case "/login":
			login(request, response);
			break;
		case "/logout":
			logout(request, response);
			break;
		}
	}

	protected void login(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("Login.jsp").forward(request, response);
	}

	protected void logout(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		if (session.getAttribute("USER") != null) {
			session.removeAttribute("USER");
			response.sendRedirect("Login.jsp");
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url = request.getServletPath();
		switch (url.toLowerCase()) {
		case "/signin":
			postLogin(request, response);
			break;
		}
	}

	protected void postLogin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("user");
		String password = request.getParameter("pass");

		Admin1DAO adminDAO = new Admin1DAO();
		Admin1 admin = adminDAO.login(username, password);
		if (admin != null) {
			HttpSession session = request.getSession();
			session.setAttribute("ADMIN", admin);
			session.setMaxInactiveInterval(900);
			response.sendRedirect("manage");
		} else {
			request.setAttribute("username", username);
			request.setAttribute("loginError", "Tài khoản không đúng yêu cầu nhập lại");
			request.getRequestDispatcher("Login.jsp").forward(request, response);
		}
	}

	@Override
	public String getServletInfo() {
		return "Short description";
	}// </editor-fold>

}