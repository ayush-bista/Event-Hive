package controller.admin;

import dao.ContactDAO;
import dao.EnrollmentDAO;
import dao.EventDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * AdminDashboardServlet - Loads all stats for the admin home page.
 * UPDATED for Final Milestone — includes monthly chart data, unread message count,
 * participating students count, and pending student list.
 * URL: /admin/dashboard
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final UserDAO       userDAO       = new UserDAO();
    private final EventDAO      eventDAO      = new EventDAO();
    private final EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
    private final ContactDAO    contactDAO    = new ContactDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            // ── Stat cards ─────────────────────────────────────────────
            req.setAttribute("totalStudents",         userDAO.getAllStudents().size());
            req.setAttribute("pendingUsers",          userDAO.countPendingUsers());
            req.setAttribute("upcomingEvents",        eventDAO.countUpcomingEvents());
            req.setAttribute("totalEnrollments",      enrollmentDAO.countTotalEnrollments());
            req.setAttribute("participatingStudents", enrollmentDAO.countParticipatingStudents());

            // ── Widgets ────────────────────────────────────────────────
            req.setAttribute("popularEvents",         eventDAO.getPopularEvents(5));
            req.setAttribute("pendingEnrollments",    enrollmentDAO.getAllPendingEnrollments());
            req.setAttribute("pendingStudents",       userDAO.getPendingStudents());

            // ── Chart data ─────────────────────────────────────────────
            req.setAttribute("monthlyParticipation",  enrollmentDAO.getMonthlyParticipationCounts(6));

            // ── Messages badge ─────────────────────────────────────────
            req.setAttribute("unreadMessages",        contactDAO.countUnread());

        } catch (Exception e) {
            req.setAttribute("error", "Could not load dashboard data: " + e.getMessage());
        }
        req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, res);
    }
}
