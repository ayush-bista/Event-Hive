package controller.student;

import dao.EnrollmentDAO;
import dao.EventDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Event;
import model.User;

import java.io.IOException;
@WebServlet("/student/enroll")
public class EnrollServlet extends HttpServlet {
private final EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
private final EventDAO      eventDAO      = new EventDAO();
@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        User   user    = (User) req.getSession().getAttribute("loggedInUser");
        String action  = req.getParameter("action");
        int    eventId = Integer.parseInt(req.getParameter("eventId"));

        try {
            if ("enroll".equals(action)) {
                // Check deadline and capacity
                Event event = eventDAO.getEventById(eventId);
                if (event == null) {
                    req.getSession().setAttribute("flashError", "Event not found.");
                } else if (!event.hasAvailableSeats()) {
                    req.getSession().setAttribute("flashError", "This event is fully booked.");
                } else if (enrollmentDAO.isEnrolled(user.getUserId(), eventId)) {
                    req.getSession().setAttribute("flashError", "You are already enrolled in this event.");
                } else {
                    enrollmentDAO.enroll(user.getUserId(), eventId);
                    req.getSession().setAttribute("flashSuccess",
                            "Enrollment request submitted! Awaiting admin approval.");
                }
            } else if ("cancel".equals(action)) {
                enrollmentDAO.cancelEnrollment(user.getUserId(), eventId);
                req.getSession().setAttribute("flashSuccess", "Enrollment cancelled.");
            }
        } catch (Exception e) {
            req.getSession().setAttribute("flashError", "Operation failed. Please try again.");
        }

        res.sendRedirect(req.getContextPath() + "/student/events");
    }
}
