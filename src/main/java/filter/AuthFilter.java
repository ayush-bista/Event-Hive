package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;

/**
 * AuthFilter - Intercepts every request.
 * ● Public URLs (/login, /register, /index.jsp, static assets) pass through.
 * ● /admin/* URLs require an admin session.
 * ● /student/* URLs require an approved student session.
 * ● All other protected URLs require any authenticated session.
 */
@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  request  = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String uri = request.getRequestURI();
        String ctx = request.getContextPath();   // e.g. "/eventhive"

        // ── Public resources — always allow ────────────────────────────────
        if (isPublicResource(uri, ctx)) {
            chain.doFilter(req, res);
            return;
        }

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        // ── Not logged in → redirect to login ─────────────────────────────
        if (user == null) {
            response.sendRedirect(ctx + "/login");
            return;
        }

        // ── Admin area ─────────────────────────────────────────────────────
        if (uri.startsWith(ctx + "/admin")) {
            if (!user.isAdmin()) {
                response.sendRedirect(ctx + "/error?code=403");
                return;
            }
        }

        // ── Student area ───────────────────────────────────────────────────
        if (uri.startsWith(ctx + "/student")) {
            if (!user.isStudent()) {
                response.sendRedirect(ctx + "/error?code=403");
                return;
            }
            if (!user.isApprovedUser()) {
                request.setAttribute("message", "Your account is pending admin approval.");
                request.getRequestDispatcher("/WEB-INF/views/pending.jsp").forward(request, response);
                return;
            }
        }

        chain.doFilter(req, res);
    }

    private boolean isPublicResource(String uri, String ctx) {
        return uri.equals(ctx)
                || uri.equals(ctx + "/")
                || uri.equals(ctx + "/index.jsp")
                || uri.startsWith(ctx + "/login")
                || uri.startsWith(ctx + "/register")
                || uri.startsWith(ctx + "/about")
                || uri.startsWith(ctx + "/contact")
                || uri.startsWith(ctx + "/assets/")
                || uri.startsWith(ctx + "/css/")
                || uri.startsWith(ctx + "/js/")
                || uri.startsWith(ctx + "/images/")
                || uri.startsWith(ctx + "/error");
    }
}
