package Controller;

import Dal.TinTucDAO;
import Model.TinTuc;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NewsController extends HttpServlet {

	private TinTucDAO nDB;

	@Override
	public void init() throws ServletException {
		nDB = new TinTucDAO();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String url = request.getServletPath();
		switch (url.toLowerCase()) {
		case "/manage":
			manageNews(request, response);
			break;
		case "/managedelete":
			deleteNews(request, response);
			break;
		case "/manageedit":
			editNews(request, response);
			break;
		case "/manageadd":
			addNews(request, response);
			break;
		}
	}

	protected void manageNews(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int page = 1;
		int pageSize = 5;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}

		if (nDB.getConnection() == null) {
			nDB = new TinTucDAO();
			System.out.println("Reinitialized TinTucDAO due to null connection");
		}

		List<TinTuc> listN = null;
		int maxRetries = 3;
		int attempt = 0;
		while (attempt < maxRetries) {
			try {
				listN = nDB.getTinTucByPage(page, pageSize);
				break;
			} catch (Exception e) {
				attempt++;
				System.err.println("Attempt " + attempt + " to load news failed: " + e.getMessage());
				if (attempt == maxRetries) {
					request.setAttribute("error",
							"Failed to load news after " + maxRetries + " attempts: " + e.getMessage());
					break;
				}
				nDB = new TinTucDAO();
				try {
					Thread.sleep(2000); 
				} catch (InterruptedException ie) {
					System.err.println("Retry interrupted: " + ie.getMessage());
				}
			}
		}

		int totalNews = 0;
		attempt = 0;
		while (attempt < maxRetries) {
			try {
				totalNews = nDB.getTotalNewsCount();
				break;
			} catch (Exception e) {
				attempt++;
				System.err.println("Attempt " + attempt + " to count news failed: " + e.getMessage());
				if (attempt == maxRetries) {
					request.setAttribute("error",
							"Failed to count news after " + maxRetries + " attempts: " + e.getMessage());
					break;
				}
				nDB = new TinTucDAO();
				try {
					Thread.sleep(2000);
				} catch (InterruptedException ie) {
					System.err.println("Retry interrupted: " + ie.getMessage());
				}
			}
		}

		int totalPages = (int) Math.ceil((double) totalNews / pageSize);

		System.out.println("listN size in manageNews: " + (listN != null ? listN.size() : "null"));
		if (listN != null) {
			for (TinTuc news : listN) {
				System.out.println("News ID: " + news.getMaTinTuc() + ", Title: " + news.getTieuDeTinTuc());
			}
		}

		request.setAttribute("listN", listN);
		request.setAttribute("currentPage", page);
		request.setAttribute("totalPages", totalPages);
		request.setAttribute("totalNews", totalNews);
		request.getRequestDispatcher("ManagerNews.jsp").forward(request, response);
	}

	protected void deleteNews(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String nID = request.getParameter("nID");
		nDB.deleteTinTuc(nID);
		response.sendRedirect("manage");
	}

	protected void addNews(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String title = request.getParameter("title");
			String image = request.getParameter("image");
			String excerpt = request.getParameter("excerpt");
			String content = request.getParameter("content");
			String viewsStr = request.getParameter("views");
			String tags = request.getParameter("tags");
			String categoryStr = request.getParameter("category");
			String subcategoryStr = request.getParameter("subcategory");
			String classificationStr = request.getParameter("classification");
			String adminIdStr = request.getParameter("adminId");

			if (title == null || title.trim().isEmpty() || image == null || image.trim().isEmpty() || excerpt == null
					|| excerpt.trim().isEmpty() || content == null || content.trim().isEmpty() || tags == null
					|| tags.trim().isEmpty() || categoryStr == null || categoryStr.trim().isEmpty()) {
				request.setAttribute("error", "All required fields must be filled!");
				manageNews(request, response);
				return;
			}

			int views = viewsStr != null && !viewsStr.isEmpty() ? Integer.parseInt(viewsStr) : 0;
			int category = Integer.parseInt(categoryStr);
			int subcategory = subcategoryStr != null && !subcategoryStr.isEmpty() ? Integer.parseInt(subcategoryStr)
					: 0;
			int classification = classificationStr != null && !classificationStr.isEmpty()
					? Integer.parseInt(classificationStr)
					: 0;
			int adminId = adminIdStr != null && !adminIdStr.isEmpty() ? Integer.parseInt(adminIdStr) : 0;

			TinTuc n = new TinTuc(0, title, image, excerpt, content, null, views, tags, category, subcategory,
					classification, adminId);
			nDB.addTinTuc(n, categoryStr);
			response.sendRedirect("manage");
		} catch (NumberFormatException e) {
			request.setAttribute("error", "Invalid number format in input fields: " + e.getMessage());
			manageNews(request, response);
		} catch (Exception e) {
			request.setAttribute("error", "Error adding news: " + e.getMessage());
			manageNews(request, response);
		}
	}

	protected void editNews(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			int id = Integer.parseInt(request.getParameter("id"));
			String title = request.getParameter("title");
			String image = request.getParameter("image");
			String excerpt = request.getParameter("excerpt");
			String content = request.getParameter("content");
			String viewsStr = request.getParameter("views");
			String tags = request.getParameter("tags");
			String categoryStr = request.getParameter("category");
			String subcategoryStr = request.getParameter("subcategory");
			String classificationStr = request.getParameter("classification");
			String adminIdStr = request.getParameter("adminId");

			if (title == null || title.trim().isEmpty() || image == null || image.trim().isEmpty() || excerpt == null
					|| excerpt.trim().isEmpty() || content == null || content.trim().isEmpty() || tags == null
					|| tags.trim().isEmpty() || categoryStr == null || categoryStr.trim().isEmpty()) {
				request.setAttribute("error", "All required fields must be filled!");
				manageNews(request, response);
				return;
			}

			int views = Integer.parseInt(viewsStr);
			int category = Integer.parseInt(categoryStr);
			int subcategory = Integer.parseInt(subcategoryStr);
			int classification = Integer.parseInt(classificationStr);
			int adminId = Integer.parseInt(adminIdStr);

			TinTuc n = new TinTuc(id, title, image, excerpt, content, null, views, tags, category, subcategory,
					classification, adminId);
			nDB.editTinTuc(n, category);
			response.sendRedirect("manage");
		} catch (NumberFormatException e) {
			request.setAttribute("error", "Invalid number format in input fields: " + e.getMessage());
			manageNews(request, response);
		} catch (Exception e) {
			request.setAttribute("error", "Error updating news: " + e.getMessage());
			manageNews(request, response);
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	@Override
	public String getServletInfo() {
		return "News management servlet";
	}
}