package controller.student;

import dao.EnrollmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;
@WebServlet("/student/enrollments")
public class MyEnrollmentsServlet extends HttpServlet {
private final EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            User user = (User) req.getSession().getAttribute("loggedInUser");
            req.setAttribute("myEnrollments", enrollmentDAO.getEnrollmentsByUser(user.getUserId()));
        } catch (Exception e) {
            req.setAttribute("error", "Could not load enrollments.");
        }
        req.getRequestDispatcher("/WEB-INF/views/student/enrollments.jsp").forward(req, res);
    }
}
