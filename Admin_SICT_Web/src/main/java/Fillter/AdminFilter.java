package Fillter;

import Model.Admin1;
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AdminFilter implements Filter {

    private static final boolean debug = true;
    private FilterConfig filterConfig = null;

    public AdminFilter() {
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AdminFilter:DoBeforeProcessing");
        }
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AdminFilter:DoAfterProcessing");
        }
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        if (debug) {
            log("AdminFilter:doFilter()");
        }

        doBeforeProcessing(request, response);
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession();
        if (session.getAttribute("ADMIN") == null) {
            System.out.println("No ADMIN session, redirecting to login. Requested URL: " + req.getRequestURI());
            res.sendRedirect(req.getContextPath() + "/login"); // Sử dụng context path để tránh lỗi 404
        } else {
            chain.doFilter(request, response);
        }

        doAfterProcessing(request, response);
    }

    public FilterConfig getFilterConfig() {
        return this.filterConfig;
    }

    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    public void destroy() {
    }

    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("AdminFilter:Initializing filter");
            }
        }
    }

    @Override
    public String toString() {
        if (filterConfig == null) {
            return "AdminFilter()";
        }
        StringBuffer sb = new StringBuffer("AdminFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return sb.toString();
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);
        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                java.io.PrintStream ps = new java.io.PrintStream(response.getOutputStream());
                java.io.PrintWriter pw = new java.io.PrintWriter(ps);
                pw.print("\n\n\n\n\n");
                pw.print("The resource did not process correctly\n\n");
                pw.print(stackTrace);
                pw.print("\n");
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                java.io.PrintStream ps = new java.io.PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            java.io.StringWriter sw = new java.io.StringWriter();
            java.io.PrintWriter pw = new java.io.PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }
}