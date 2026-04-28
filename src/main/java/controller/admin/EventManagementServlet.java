package controller.admin;

import dao.EventDAO;
import dao.EnrollmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Event;
import model.User;
import util.ValidationUtil;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Locale;
import java.util.UUID;

/**
 * EventManagementServlet - Admin CRUD for events.
 * URL pattern: /admin/events
 *   GET  ?action=list      → list all events
 *   GET  ?action=add       → show add form
 *   GET  ?action=edit&id=X → show edit form
 *   GET  ?action=delete&id=X → delete event
 *   GET  ?action=participants&id=X → view enrollments
 *   POST ?action=save      → create / update event
 *   POST ?action=updateEnrollment → approve/reject enrollment
 */
@WebServlet("/admin/events")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 6 * 1024 * 1024
)
public class EventManagementServlet extends HttpServlet {

    private final EventDAO      eventDAO      = new EventDAO();
    private final EnrollmentDAO enrollmentDAO = new EnrollmentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "add":
                    req.getRequestDispatcher("/WEB-INF/views/admin/event_form.jsp").forward(req, res);
                    break;

                case "edit":
                    int editId = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("event", eventDAO.getEventById(editId));
                    req.getRequestDispatcher("/WEB-INF/views/admin/event_form.jsp").forward(req, res);
                    break;

                case "delete":
                    int delId = Integer.parseInt(req.getParameter("id"));
                    eventDAO.deleteEvent(delId);
                    res.sendRedirect(req.getContextPath() + "/admin/events?action=list&msg=deleted");
                    break;

                case "participants":
                    int evId = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("event",       eventDAO.getEventById(evId));
                    req.setAttribute("enrollments", enrollmentDAO.getEnrollmentsByEvent(evId));
                    req.getRequestDispatcher("/WEB-INF/views/admin/participants.jsp").forward(req, res);
                    break;

                default:  // "list"
                    req.setAttribute("events", eventDAO.getAllEvents());
                    req.getRequestDispatcher("/WEB-INF/views/admin/events.jsp").forward(req, res);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Operation failed: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        // ── Approve / reject enrollment ────────────────────────────────────
        if ("updateEnrollment".equals(action)) {
            try {
                int    enId   = Integer.parseInt(req.getParameter("enrollmentId"));
                String status = req.getParameter("status");
                enrollmentDAO.updateStatus(enId, status);
                res.sendRedirect(req.getContextPath() +
                        "/admin/events?action=participants&id=" + req.getParameter("eventId"));
            } catch (Exception e) {
                res.sendRedirect(req.getContextPath() + "/admin/events?error=update_failed");
            }
            return;
        }

        // ── Create / update event ──────────────────────────────────────────
        String idStr = req.getParameter("eventId");
        boolean isEdit = (idStr != null && !idStr.isEmpty());

        String title    = ValidationUtil.sanitize(req.getParameter("title"));
        String desc     = ValidationUtil.sanitize(req.getParameter("description"));
        String venue    = ValidationUtil.sanitize(req.getParameter("venue"));
        String catIdStr = req.getParameter("categoryId");
        String dateStr  = req.getParameter("eventDate");
        String timeStr  = req.getParameter("eventTime");
        String deadStr  = req.getParameter("deadline");
        String capStr   = req.getParameter("capacity");
        String status   = req.getParameter("status");
        String existingBanner = ValidationUtil.sanitize(req.getParameter("existingBannerImage"));

        if (!ValidationUtil.isNotEmpty(title) || !ValidationUtil.isNotEmpty(venue)) {
            req.setAttribute("error", "Title and venue are required.");
            req.getRequestDispatcher("/WEB-INF/views/admin/event_form.jsp").forward(req, res);
            return;
        }

        try {
            Event event = new Event();
            if (isEdit) event.setEventId(Integer.parseInt(idStr));
            event.setTitle(title);
            event.setDescription(desc);
            event.setCategoryId(Integer.parseInt(catIdStr));
            event.setVenue(venue);
            Date eventDate = parseDateFlexible(dateStr);
            if (eventDate == null) {
                throw new IllegalArgumentException("Event date is required.");
            }
            event.setEventDate(eventDate);
            event.setEventTime(parseTimeFlexible(timeStr));
            event.setDeadline(parseDateFlexible(deadStr));
            event.setCapacity(capStr != null && !capStr.isEmpty() ? Integer.parseInt(capStr) : 0);
            String bannerImage = saveBannerImage(req);
            event.setBannerImage(ValidationUtil.isNotEmpty(bannerImage)
                    ? bannerImage
                    : (ValidationUtil.isNotEmpty(existingBanner) ? existingBanner : "default_event.png"));
            event.setStatus(status != null ? status : "upcoming");

            if (isEdit) {
                eventDAO.updateEvent(event);
            } else {
                User admin = (User) req.getSession().getAttribute("loggedInUser");
                event.setCreatedBy(admin.getUserId());
                eventDAO.createEvent(event);
            }
            res.sendRedirect(req.getContextPath() + "/admin/events?action=list&msg=saved");

        } catch (Exception e) {
            req.setAttribute("error", "Could not save event: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/admin/event_form.jsp").forward(req, res);
        }
    }

    private String saveBannerImage(HttpServletRequest req) throws IOException, ServletException {
        Part filePart = req.getPart("bannerImage");
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        String submittedName = Path.of(filePart.getSubmittedFileName()).getFileName().toString();
        String lowerName = submittedName.toLowerCase(Locale.ENGLISH);
        String extension;
        if (lowerName.endsWith(".jpg") || lowerName.endsWith(".jpeg")) {
            extension = ".jpg";
        } else if (lowerName.endsWith(".png")) {
            extension = ".png";
        } else if (lowerName.endsWith(".webp")) {
            extension = ".webp";
        } else {
            throw new IllegalArgumentException("Cover image must be JPG, PNG, or WEBP.");
        }

        String uploadDirPath = getServletContext().getRealPath("/uploads/events");
        if (uploadDirPath == null) {
            throw new IOException("Upload directory is not available.");
        }

        Path uploadDir = Path.of(uploadDirPath);
        Files.createDirectories(uploadDir);

        String fileName = UUID.randomUUID() + extension;
        filePart.write(uploadDir.resolve(fileName).toString());
        return fileName;
    }

    private Date parseDateFlexible(String raw) {
        if (raw == null || raw.trim().isEmpty()) {
            return null;
        }
        String value = raw.trim();

        try {
            return Date.valueOf(value);
        } catch (IllegalArgumentException ignored) {
            // Try common browser/locale display formats used in manual input.
        }

        DateTimeFormatter[] formats = new DateTimeFormatter[] {
                DateTimeFormatter.ofPattern("M/d/yyyy", Locale.ENGLISH),
                DateTimeFormatter.ofPattern("MM/dd/yyyy", Locale.ENGLISH)
        };

        for (DateTimeFormatter format : formats) {
            try {
                return Date.valueOf(LocalDate.parse(value, format));
            } catch (DateTimeParseException ignored) {
                // Keep trying accepted formats.
            }
        }

        throw new IllegalArgumentException("Invalid date format: " + value);
    }

    private Time parseTimeFlexible(String raw) {
        if (raw == null || raw.trim().isEmpty()) {
            return null;
        }
        String value = raw.trim();

        try {
            return Time.valueOf(value.length() == 5 ? value + ":00" : value);
        } catch (IllegalArgumentException ignored) {
            // Try 12-hour inputs like "08:00 PM".
        }

        String normalized = value.toUpperCase(Locale.ENGLISH);
        DateTimeFormatter[] formats = new DateTimeFormatter[] {
                DateTimeFormatter.ofPattern("h:mm a", Locale.ENGLISH),
                DateTimeFormatter.ofPattern("hh:mm a", Locale.ENGLISH),
                DateTimeFormatter.ofPattern("h:mm:ss a", Locale.ENGLISH)
        };

        for (DateTimeFormatter format : formats) {
            try {
                return Time.valueOf(LocalTime.parse(normalized, format));
            } catch (DateTimeParseException ignored) {
                // Keep trying accepted formats.
            }
        }

        throw new IllegalArgumentException("Invalid event time format: " + value);
    }
}
