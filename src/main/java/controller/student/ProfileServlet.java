package controller.student;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;
import util.PasswordUtil;
import util.ValidationUtil;

import java.io.IOException;
import java.sql.Date;

/**
 * ProfileServlet - View and update student profile.
 * URL: /student/profile
 */
@WebServlet("/student/profile")
public class ProfileServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/student/profile.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        User   user   = (User) req.getSession().getAttribute("loggedInUser");

        try {
            if ("updateProfile".equals(action)) {
                String fullName = ValidationUtil.sanitize(req.getParameter("fullName"));
                String phone    = ValidationUtil.sanitize(req.getParameter("phone"));
                String dob      = req.getParameter("dateOfBirth");

                if (!ValidationUtil.isValidName(fullName)) {
                    req.setAttribute("error", "Name must contain letters only.");
                    req.getRequestDispatcher("/WEB-INF/views/student/profile.jsp").forward(req, res);
                    return;
                }
                if (!ValidationUtil.isValidPhone(phone)) {
                    req.setAttribute("error", "Phone must be 10 digits.");
                    req.getRequestDispatcher("/WEB-INF/views/student/profile.jsp").forward(req, res);
                    return;
                }

                user.setFullName(fullName);
                user.setPhone(phone);
                user.setDateOfBirth(Date.valueOf(dob));
                userDAO.updateProfile(user);

                // Update session object
                req.getSession().setAttribute("loggedInUser", userDAO.getUserById(user.getUserId()));
                req.setAttribute("success", "Profile updated successfully.");

            } else if ("changePassword".equals(action)) {
                String current = req.getParameter("currentPassword");
                String newPass = req.getParameter("newPassword");
                String confirm = req.getParameter("confirmPassword");

                if (!PasswordUtil.verify(current, user.getPassword())) {
                    req.setAttribute("error", "Current password is incorrect.");
                    req.getRequestDispatcher("/WEB-INF/views/student/profile.jsp").forward(req, res);
                    return;
                }
                if (!ValidationUtil.isValidPassword(newPass)) {
                    req.setAttribute("error",
                            "New password must be 8+ chars with uppercase, number, and special character.");
                    req.getRequestDispatcher("/WEB-INF/views/student/profile.jsp").forward(req, res);
                    return;
                }
                if (!newPass.equals(confirm)) {
                    req.setAttribute("error", "Passwords do not match.");
                    req.getRequestDispatcher("/WEB-INF/views/student/profile.jsp").forward(req, res);
                    return;
                }
                userDAO.updatePassword(user.getUserId(), PasswordUtil.hash(newPass));
                req.setAttribute("success", "Password changed successfully.");
            }
        } catch (Exception e) {
            req.setAttribute("error", "Update failed. Please try again.");
        }

        req.getRequestDispatcher("/WEB-INF/views/student/profile.jsp").forward(req, res);
    }
}
