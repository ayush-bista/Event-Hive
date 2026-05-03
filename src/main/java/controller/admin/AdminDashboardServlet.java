package controller.admin;

import dao.EnrollmentDAO;
import dao.EventDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.Year;
import java.util.Collections;
import java.util.Map;
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
private final UserDAO       userDAO       = new UserDAO();
private final EventDAO      eventDAO      = new EventDAO();
private final EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            int totalStudents = userDAO.getAllStudents().size();
            int participatingStudents = enrollmentDAO.countParticipatingStudents();
            int participationRate = totalStudents == 0 ? 0 : (participatingStudents * 100) / totalStudents;
            Map<String, Integer> monthlyParticipation = enrollmentDAO.getMonthlyParticipationCounts(6);
            int maxMonthlyParticipation = Math.max(1, Collections.max(monthlyParticipation.values()));

            req.setAttribute("totalStudents",     totalStudents);
            req.setAttribute("pendingUsers",      userDAO.countPendingUsers());
            req.setAttribute("upcomingEvents",    eventDAO.countUpcomingEvents());
            req.setAttribute("totalEnrollments",  enrollmentDAO.countTotalEnrollments());
            req.setAttribute("monthlyParticipation", monthlyParticipation);
            req.setAttribute("maxMonthlyParticipation", maxMonthlyParticipation);
            req.setAttribute("currentYear", Year.now().getValue());
            req.setAttribute("participatingStudents", participatingStudents);
            req.setAttribute("participationRate", participationRate);
            req.setAttribute("pendingEnrollments", enrollmentDAO.getAllPendingEnrollments());
            req.setAttribute("studentRequests",   userDAO.getPendingStudents());
        } catch (Exception e) {
            req.setAttribute("error", "Could not load dashboard data.");
        }
        req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, res);
    }
}
