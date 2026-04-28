package controller.admin;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * UserManagementServlet - Admin approves / deletes student accounts.
 * URL: /admin/users
 */
@WebServlet("/admin/users")
public class UserManagementServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            req.setAttribute("students", userDAO.getAllStudents());
            req.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(req, res);
        } catch (Exception e) {
            req.setAttribute("error", "Could not load users.");
            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        String userIdParam = req.getParameter("userId");

        if (action == null || userIdParam == null || userIdParam.trim().isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/admin/users");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdParam);
            switch (action) {
                case "approve": userDAO.approveUser(userId); break;
                case "delete":  userDAO.deleteUser(userId);  break;
                default: break;
            }
        } catch (Exception e) {
            // log and continue
        }
        res.sendRedirect(req.getContextPath() + "/admin/users");
    }
}
