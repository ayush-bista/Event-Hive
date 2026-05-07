package controller;

import dao.ContactDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.ContactMessage;
import util.ValidationUtil;

import java.io.IOException;

/**
 * ContactServlet - Displays contact form (GET) and saves messages (POST).
 * URL: /contact
 */
@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    private final ContactDAO contactDAO = new ContactDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String name    = ValidationUtil.sanitize(req.getParameter("senderName"));
        String email   = ValidationUtil.sanitize(req.getParameter("senderEmail"));
        String subject = ValidationUtil.sanitize(req.getParameter("subject"));
        String message = ValidationUtil.sanitize(req.getParameter("message"));

        // Validation
        if (!ValidationUtil.isValidName(name)) {
            req.setAttribute("error", "Please enter a valid full name (letters only).");
            req.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(req, res);
            return;
        }
        if (!ValidationUtil.isValidEmail(email)) {
            req.setAttribute("error", "Please enter a valid email address.");
            req.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(req, res);
            return;
        }
        if (!ValidationUtil.isNotEmpty(subject)) {
            req.setAttribute("error", "Please enter a subject.");
            req.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(req, res);
            return;
        }
        if (!ValidationUtil.isNotEmpty(message) || message.length() < 10) {
            req.setAttribute("error", "Message must be at least 10 characters.");
            req.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(req, res);
            return;
        }

        try {
            ContactMessage msg = new ContactMessage();
            msg.setSenderName(name);
            msg.setSenderEmail(email);
            msg.setSubject(subject);
            msg.setMessage(message);

            if (contactDAO.saveMessage(msg)) {
                req.setAttribute("success",
                        "Thank you! Your message has been sent. We will get back to you soon.");
            } else {
                req.setAttribute("error", "Could not send message. Please try again.");
            }
        } catch (Exception e) {
            req.setAttribute("error", "A server error occurred. Please try again.");
        }

        req.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(req, res);
    }
}
