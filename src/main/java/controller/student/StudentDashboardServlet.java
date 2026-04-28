package controller.student;

import dao.EnrollmentDAO;
import dao.EventDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;

/**
 * StudentDashboardServlet - Student home page.
 * URL: /student/dashboard
 */
@WebServlet("/student/dashboard")
public class StudentDashboardServlet extends HttpServlet {

    private final EventDAO      eventDAO      = new EventDAO();
    private final EnrollmentDAO enrollmentDAO = new EnrollmentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            User user = (User) req.getSession().getAttribute("loggedInUser");
            req.setAttribute("upcomingEvents",  eventDAO.getAllEvents());
            req.setAttribute("myEnrollments",   enrollmentDAO.getEnrollmentsByUser(user.getUserId()));
            req.setAttribute("popularEvents",   eventDAO.getPopularEvents(3));
        } catch (Exception e) {
            req.setAttribute("error", "Could not load dashboard.");
        }
        req.getRequestDispatcher("/WEB-INF/views/student/dashboard.jsp").forward(req, res);
    }
}
