package controller.admin;

import dao.ContactDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * AdminMessagesServlet - Admin inbox for contact form messages.
 * URL: /admin/messages
 *   GET  → list all messages
 *   POST action=markRead&id=X → mark as read
 *   POST action=delete&id=X   → delete message
 */
@WebServlet("/admin/messages")
public class AdminMessagesServlet extends HttpServlet {

    private final ContactDAO contactDAO = new ContactDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            req.setAttribute("messages", contactDAO.getAllMessages());
            req.setAttribute("unreadCount", contactDAO.countUnread());
        } catch (Exception e) {
            req.setAttribute("error", "Could not load messages.");
        }
        req.getRequestDispatcher("/WEB-INF/views/admin/messages.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        String idStr  = req.getParameter("id");

        if (action != null && idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                if ("markRead".equals(action))  contactDAO.markAsRead(id);
                if ("delete".equals(action))    contactDAO.deleteMessage(id);
            } catch (Exception ignored) {}
        }
        res.sendRedirect(req.getContextPath() + "/admin/messages");
    }
}
