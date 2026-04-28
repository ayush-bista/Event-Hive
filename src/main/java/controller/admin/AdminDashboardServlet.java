package controller.admin;

import dao.EnrollmentDAO;
import dao.EventDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * AdminDashboardServlet - Loads stats for the admin home page.
 * URL: /admin/dashboard
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final UserDAO       userDAO       = new UserDAO();
    private final EventDAO      eventDAO      = new EventDAO();
    private final EnrollmentDAO enrollmentDAO = new EnrollmentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            req.setAttribute("totalStudents",     userDAO.getAllStudents().size());
            req.setAttribute("pendingUsers",      userDAO.countPendingUsers());
            req.setAttribute("upcomingEvents",    eventDAO.countUpcomingEvents());
            req.setAttribute("totalEnrollments",  enrollmentDAO.countTotalEnrollments());
            req.setAttribute("popularEvents",     eventDAO.getPopularEvents(5));
            req.setAttribute("pendingEnrollments", enrollmentDAO.getAllPendingEnrollments());
        } catch (Exception e) {
            req.setAttribute("error", "Could not load dashboard data.");
        }
        req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, res);
    }
}