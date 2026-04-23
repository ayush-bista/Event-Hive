package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * LogoutServlet - Invalidates session and clears cookies.
 * URL: /logout
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session != null) session.invalidate();

        // Remove remember-me cookie
        Cookie cookie = new Cookie("eh_email", "");
        cookie.setMaxAge(0);
        cookie.setPath(req.getContextPath());
        res.addCookie(cookie);

        res.sendRedirect(req.getContextPath() + "/login");
    }
}
