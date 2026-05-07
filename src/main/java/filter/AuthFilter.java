package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;

/**
 * AuthFilter - Application-wide security filter.
 * UPDATED for Final Milestone — added /about, /contact, /admin/reports, /admin/messages routes.
 *
 * Rules:
 *   1. Public URLs → always pass through (no login needed)
 *   2. /admin/* URLs → require admin role session
 *   3. /student/* URLs → require approved student session
 *   4. No session → redirect to /login
 */
@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  request  = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String uri = request.getRequestURI();
        String ctx = request.getContextPath();

        // ── Rule 1: Public resources — always allow ────────────────────
        if (isPublicResource(uri, ctx)) {
            chain.doFilter(req, res);
            return;
        }

        // ── Check session ──────────────────────────────────────────────
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        // ── Rule 2: Not logged in → redirect to login ──────────────────
        if (user == null) {
            response.sendRedirect(ctx + "/login");
            return;
        }

        // ── Rule 3: Admin-only area ────────────────────────────────────
        if (uri.startsWith(ctx + "/admin")) {
            if (!user.isAdmin()) {
                response.sendRedirect(ctx + "/error?code=403");
                return;
            }
        }

        // ── Rule 4: Student-only area ──────────────────────────────────
        if (uri.startsWith(ctx + "/student")) {
            if (!user.isStudent()) {
                response.sendRedirect(ctx + "/error?code=403");
                return;
            }
            // Student must be approved
            if (!user.isApprovedUser()) {
                request.setAttribute("message",
                        "Your account is pending admin approval.");
                request.getRequestDispatcher("/WEB-INF/views/pending.jsp")
                        .forward(request, response);
                return;
            }
        }

        chain.doFilter(req, res);
    }

    /**
     * Returns true for URLs that do not require authentication.
     * About and Contact pages are public — anyone can visit them.
     */
    private boolean isPublicResource(String uri, String ctx) {
        return uri.equals(ctx + "/")
                || uri.equals(ctx + "/index.jsp")
                || uri.startsWith(ctx + "/login")
                || uri.startsWith(ctx + "/register")
                || uri.startsWith(ctx + "/about")
                || uri.startsWith(ctx + "/contact")
                || uri.startsWith(ctx + "/error")
                || uri.startsWith(ctx + "/assets/")
                || uri.startsWith(ctx + "/css/")
                || uri.startsWith(ctx + "/js/")
                || uri.startsWith(ctx + "/images/")
                || uri.startsWith(ctx + "/uploads/");
    }
}
