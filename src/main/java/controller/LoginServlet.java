package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;
import util.PasswordUtil;
import util.ValidationUtil;

import java.io.IOException;

/**
 * LoginServlet - Handles GET (show form) and POST (process login).
 * URL: /login
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        // If already logged in, redirect to appropriate dashboard
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("loggedInUser") != null) {
            User user = (User) session.getAttribute("loggedInUser");
            redirect(user, req, res);
            return;
        }
        req.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String email    = ValidationUtil.sanitize(req.getParameter("email"));
        String password = req.getParameter("password");

        // Basic input check
        if (!ValidationUtil.isValidEmail(email) || !ValidationUtil.isNotEmpty(password)) {
            req.setAttribute("error", "Please enter a valid email and password.");
            req.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(req, res);
            return;
        }

        try {
            User user = userDAO.findByEmail(email);

            if (user == null || !PasswordUtil.verify(password, user.getPassword())) {
                req.setAttribute("error", "Invalid email or password.");
                req.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(req, res);
                return;
            }

            if (user.isStudent() && !user.isApprovedUser()) {
                req.setAttribute("error", "Your account is pending admin approval.");
                req.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(req, res);
                return;
            }

            // Create session
            HttpSession session = req.getSession(true);
            session.setAttribute("loggedInUser", user);
            session.setMaxInactiveInterval(30 * 60);  // 30 minutes

            // Set remember-me cookie (optional)
            String rememberMe = req.getParameter("rememberMe");
            if ("on".equals(rememberMe)) {
                Cookie cookie = new Cookie("eh_email", email);
                cookie.setMaxAge(7 * 24 * 60 * 60);  // 7 days
                cookie.setPath(req.getContextPath());
                cookie.setHttpOnly(true);
                res.addCookie(cookie);
            }

            redirect(user, req, res);

        } catch (Exception e) {
            req.setAttribute("error", "A server error occurred. Please try again.");
            req.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(req, res);
        }
    }

    private void redirect(User user, HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        String ctx = req.getContextPath();
        if (user.isAdmin())   res.sendRedirect(ctx + "/admin/dashboard");
        else                  res.sendRedirect(ctx + "/student/dashboard");
    }
}
