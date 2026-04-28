package controller;

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
 * RegisterServlet - Handles student registration.
 * URL: /register
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String fullName  = ValidationUtil.sanitize(req.getParameter("fullName"));
        String email     = ValidationUtil.sanitize(req.getParameter("email"));
        String phone     = ValidationUtil.sanitize(req.getParameter("phone"));
        String password  = req.getParameter("password");
        String confirm   = req.getParameter("confirmPassword");
        String dob       = req.getParameter("dateOfBirth");
        String course    = ValidationUtil.sanitize(req.getParameter("course"));
        String level     = ValidationUtil.sanitize(req.getParameter("level"));
        String yearStr   = req.getParameter("year");

        // ── Validation ────────────────────────────────────────────────────
        if (!ValidationUtil.isValidName(fullName)) {
            setErrorAndForward(req, res, "Full name must contain letters only (2–100 chars).");
            return;
        }
        if (!ValidationUtil.isValidEmail(email)) {
            setErrorAndForward(req, res, "Please enter a valid email address.");
            return;
        }
        if (!ValidationUtil.isValidPhone(phone)) {
            setErrorAndForward(req, res, "Phone number must be exactly 10 digits.");
            return;
        }
        if (!ValidationUtil.isValidPassword(password)) {
            setErrorAndForward(req, res,
                    "Password must be at least 8 characters, with one uppercase letter, " +
                            "one number, and one special character (@$!%*?&).");
            return;
        }
        if (!password.equals(confirm)) {
            setErrorAndForward(req, res, "Passwords do not match.");
            return;
        }

        try {
            // ── Uniqueness checks ──────────────────────────────────────────
            if (userDAO.emailExists(email)) {
                setErrorAndForward(req, res, "An account with this email already exists.");
                return;
            }
            if (userDAO.phoneExists(phone)) {
                setErrorAndForward(req, res, "An account with this phone number already exists.");
                return;
            }

            // ── Build User object ──────────────────────────────────────────
            User user = new User();
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone(phone);
            user.setPassword(PasswordUtil.hash(password));
            user.setDateOfBirth(Date.valueOf(dob));
            user.setCourse(course);
            user.setLevel(level);
            user.setYear(yearStr != null && !yearStr.isEmpty() ? Integer.parseInt(yearStr) : 0);

            // ── Persist ────────────────────────────────────────────────────
            if (userDAO.registerUser(user)) {
                userDAO.insertStudentDetails(user);
                req.setAttribute("success",
                        "Registration successful! Please wait for admin approval before logging in.");
                req.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(req, res);
            } else {
                setErrorAndForward(req, res, "Registration failed. Please try again.");
            }

        } catch (Exception e) {
            setErrorAndForward(req, res, "A server error occurred. Please try again.");
        }
    }

    private void setErrorAndForward(HttpServletRequest req, HttpServletResponse res, String msg)
            throws ServletException, IOException {
        req.setAttribute("error", msg);
        req.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(req, res);
    }
}
