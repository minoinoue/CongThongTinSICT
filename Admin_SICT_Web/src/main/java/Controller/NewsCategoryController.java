package Controller;

import Dal.TheLoaiTinDAO;
import Model.TheLoaiTin;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class NewsCategoryController extends HttpServlet {

    private final TheLoaiTinDAO dao = new TheLoaiTinDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/manager-category-tin":
                showCategoryList(request, response);
                break;
            case "/edit-category-tin":
                showEditForm(request, response);
                break;
            default:
                response.sendRedirect("manager-category-tin");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/add-category-tin":
                handleAdd(request, response);
                break;
            case "/update-category-tin":
                handleUpdate(request, response);
                break;
            case "/delete-category-tin":
                handleDelete(request, response);
                break;
            default:
                response.sendRedirect("manager-category-tin");
                break;
        }
    }

    private void showCategoryList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<TheLoaiTin> list = dao.getAll();
            request.setAttribute("listTheLoaiTin", list);
            request.getRequestDispatcher("ManagerCategory.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể lấy danh sách thể loại tin: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi lấy danh sách thể loại tin.");
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = parseInt(request.getParameter("id"));
        try {
            TheLoaiTin tlt = dao.getById(id);
            if (tlt != null) {
                request.setAttribute("edit", tlt);
                showCategoryList(request, response);
            } else {
                response.sendRedirect("manager-category-tin?error=notfound");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manager-category-tin?error=true");
        }
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response) throws IOException {
        TheLoaiTin tlt = new TheLoaiTin();
        tlt.setTenTheLoaiTin(request.getParameter("tenTheLoaiTin"));
        tlt.setUrl(request.getParameter("url"));
        tlt.setTarget(request.getParameter("target"));
        tlt.setSapXep(parseInt(request.getParameter("sapXep")));
        tlt.setMaTheLoai(parseInt(request.getParameter("maTheLoai")));
        tlt.setVisibleTheLoaiTin("1".equals(request.getParameter("visibleTheLoaiTin")));
        tlt.setVisibleTheLoaiTin1("1".equals(request.getParameter("visibleTheLoaiTin1")));
        tlt.setLinkNgoai("1".equals(request.getParameter("linkNgoai")));
        try {
            dao.insert(tlt);
            response.sendRedirect("manager-category-tin?success=added");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manager-category-tin?error=add_failed");
        }
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        TheLoaiTin tlt = new TheLoaiTin();
        tlt.setMaTheLoaiTin(parseInt(request.getParameter("maTheLoaiTin")));
        tlt.setTenTheLoaiTin(request.getParameter("tenTheLoaiTin"));
        tlt.setUrl(request.getParameter("url"));
        tlt.setTarget(request.getParameter("target"));
        tlt.setSapXep(parseInt(request.getParameter("sapXep")));
        tlt.setMaTheLoai(parseInt(request.getParameter("maTheLoai")));
        tlt.setVisibleTheLoaiTin("1".equals(request.getParameter("visibleTheLoaiTin")));
        tlt.setVisibleTheLoaiTin1("1".equals(request.getParameter("visibleTheLoaiTin1")));
        tlt.setLinkNgoai("1".equals(request.getParameter("linkNgoai")));
        try {
            dao.update(tlt);
            response.sendRedirect("manager-category-tin?success=updated");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manager-category-tin?error=update_failed");
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = parseInt(request.getParameter("id"));
        try {
            dao.delete(id);
            response.sendRedirect("manager-category-tin?success=deleted");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manager-category-tin?error=delete_failed");
        }
    }

    private int parseInt(String str) {
        if (str == null || str.trim().isEmpty()) {
            return 0;
        }
        try {
            return Integer.parseInt(str);
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}