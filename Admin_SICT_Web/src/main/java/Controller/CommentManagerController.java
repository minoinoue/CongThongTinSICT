package Controller;

import Dal.BinhLuanDAO;
import Model.BinhLuan;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CommentManagerController extends HttpServlet {

    private BinhLuanDAO commentDB;

    @Override
    public void init() throws ServletException {
        commentDB = new BinhLuanDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String url = request.getServletPath();
        switch (url.toLowerCase()) {
            case "/manage-comments":
                manageComments(request, response);
                break;
            case "/delete-comment":
                deleteComment(request, response);
                break;
        }
    }

    protected void manageComments(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1;
        int pageSize = 5;
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid page number: " + e.getMessage());
                page = 1;
            }
        }

        if (commentDB.getConnection() == null) {
            commentDB = new BinhLuanDAO();
            System.out.println("Reinitialized BinhLuanDAO due to null connection");
        }

        List<BinhLuan> comments = null;
        int maxRetries = 3;
        int attempt = 0;
        while (attempt < maxRetries) {
            try {
                comments = commentDB.getCommentsByPage(page, pageSize);
                break;
            } catch (Exception e) {
                attempt++;
                System.err.println("Attempt " + attempt + " to load comments failed: " + e.getMessage());
                if (attempt == maxRetries) {
                    request.setAttribute("error",
                            "Failed to load comments after " + maxRetries + " attempts: " + e.getMessage());
                    break;
                }
                commentDB = new BinhLuanDAO();
                try {
                    Thread.sleep(2000);
                } catch (InterruptedException ie) {
                    System.err.println("Retry interrupted: " + ie.getMessage());
                }
            }
        }

        int totalComments = 0;
        attempt = 0;
        while (attempt < maxRetries) {
            try {
                totalComments = commentDB.getTotalCommentCount();
                break;
            } catch (Exception e) {
                attempt++;
                System.err.println("Attempt " + attempt + " to count comments failed: " + e.getMessage());
                if (attempt == maxRetries) {
                    request.setAttribute("error",
                            "Failed to count comments after " + maxRetries + " attempts: " + e.getMessage());
                    break;
                }
                commentDB = new BinhLuanDAO();
                try {
                    Thread.sleep(2000);
                } catch (InterruptedException ie) {
                    System.err.println("Retry interrupted: " + ie.getMessage());
                }
            }
        }

        int totalPages = (int) Math.ceil((double) totalComments / pageSize);

        request.setAttribute("comments", comments);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalComments", totalComments);
        request.getRequestDispatcher("ManageComments.jsp").forward(request, response);
    }

    protected void deleteComment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int commentId = Integer.parseInt(request.getParameter("commentId"));
            if (commentDB == null || commentDB.getConnection() == null) {
                commentDB = new BinhLuanDAO();
            }
            commentDB.deleteComment(commentId);
            response.sendRedirect("manage-comments?page=1"); // Chuyển hướng về trang 1 sau khi xóa
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid comment ID: " + e.getMessage());
            manageComments(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Failed to delete comment: " + e.getMessage());
            manageComments(request, response);
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
        return "Comment management servlet";
    }
}