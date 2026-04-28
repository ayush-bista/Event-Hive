package controller.student;

import dao.EnrollmentDAO;
import dao.EventDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Event;
import model.User;

import java.io.IOException;

/**
 * EventBrowseServlet - Student browses and searches events.
 * URL: /student/events
 */
@WebServlet("/student/events")
public class EventBrowseServlet extends HttpServlet {

    private final EventDAO      eventDAO      = new EventDAO();
    private final EnrollmentDAO enrollmentDAO = new EnrollmentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String keyword  = req.getParameter("keyword");
        String category = req.getParameter("category");

        try {
            req.setAttribute("events",   eventDAO.searchEvents(keyword, category));
            req.setAttribute("keyword",  keyword);
            req.setAttribute("category", category);
        } catch (Exception e) {
            req.setAttribute("error", "Could not load events.");
        }
        req.getRequestDispatcher("/WEB-INF/views/student/events.jsp").forward(req, res);
    }
}
