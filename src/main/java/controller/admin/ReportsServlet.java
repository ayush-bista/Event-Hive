package controller.admin;

import dao.EnrollmentDAO;
import dao.EventDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * ReportsServlet - Admin analytics and reports page.
 * URL: /admin/reports
 * Shows: popular events, monthly participation, enrollment stats,
 *        total students, and category breakdown.
 */
@WebServlet("/admin/reports")
public class ReportsServlet extends HttpServlet {

    private final EventDAO      eventDAO      = new EventDAO();
    private final EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
    private final UserDAO       userDAO       = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            req.setAttribute("popularEvents",         eventDAO.getPopularEvents(10));
            req.setAttribute("allEvents",             eventDAO.getAllEvents());
            req.setAttribute("totalStudents",         userDAO.getAllStudents().size());
            req.setAttribute("totalEnrollments",      enrollmentDAO.countTotalEnrollments());
            req.setAttribute("upcomingEvents",        eventDAO.countUpcomingEvents());
            req.setAttribute("monthlyParticipation",  enrollmentDAO.getMonthlyParticipationCounts(6));
            req.setAttribute("participatingStudents", enrollmentDAO.countParticipatingStudents());
        } catch (Exception e) {
            req.setAttribute("error", "Could not load report data: " + e.getMessage());
        }
        req.getRequestDispatcher("/WEB-INF/views/admin/reports.jsp").forward(req, res);
    }
}
