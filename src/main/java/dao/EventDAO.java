package dao;

import model.Event;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * EventDAO - All database operations for the events table.
 */
public class EventDAO {

    // ── Create event ──────────────────────────────────────────────────────────
    public boolean createEvent(Event event) throws SQLException {
        String sql = "INSERT INTO events (title, description, category_id, venue, event_date, " +
                "event_time, deadline, capacity, banner_image, status, created_by) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, event.getTitle());
            ps.setString(2, event.getDescription());
            ps.setInt(3,    event.getCategoryId());
            ps.setString(4, event.getVenue());
            ps.setDate(5,   event.getEventDate());
            ps.setTime(6,   event.getEventTime());
            ps.setDate(7,   event.getDeadline());
            ps.setInt(8,    event.getCapacity());
            ps.setString(9, event.getBannerImage());
            ps.setString(10, event.getStatus());
            ps.setInt(11,   event.getCreatedBy());
            return ps.executeUpdate() > 0;
        }
    }

    // ── Get all events with category name and enrollment count ────────────────
    public List<Event> getAllEvents() throws SQLException {
        List<Event> list = new ArrayList<>();
        String sql = "SELECT e.*, ec.category_name, " +
                "COUNT(en.enrollment_id) AS enrollment_count " +
                "FROM events e " +
                "LEFT JOIN event_categories ec ON e.category_id = ec.category_id " +
                "LEFT JOIN enrollments en ON e.event_id = en.event_id AND en.status != 'cancelled' " +
                "GROUP BY e.event_id ORDER BY e.event_date ASC";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    // ── Get event by ID ───────────────────────────────────────────────────────
    public Event getEventById(int eventId) throws SQLException {
        String sql = "SELECT e.*, ec.category_name, " +
                "COUNT(en.enrollment_id) AS enrollment_count " +
                "FROM events e " +
                "LEFT JOIN event_categories ec ON e.category_id = ec.category_id " +
                "LEFT JOIN enrollments en ON e.event_id = en.event_id AND en.status != 'cancelled' " +
                "WHERE e.event_id = ? GROUP BY e.event_id";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        }
        return null;
    }

    // ── Search events by title or category ────────────────────────────────────
    public List<Event> searchEvents(String keyword, String category) throws SQLException {
        List<Event> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT e.*, ec.category_name, COUNT(en.enrollment_id) AS enrollment_count " +
                        "FROM events e " +
                        "LEFT JOIN event_categories ec ON e.category_id = ec.category_id " +
                        "LEFT JOIN enrollments en ON e.event_id = en.event_id AND en.status != 'cancelled' " +
                        "WHERE 1=1");
        if (keyword != null && !keyword.isEmpty())
            sql.append(" AND (e.title LIKE ? OR e.description LIKE ?)");
        if (category != null && !category.isEmpty())
            sql.append(" AND ec.category_name = ?");
        sql.append(" GROUP BY e.event_id ORDER BY e.event_date ASC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int idx = 1;
            if (keyword != null && !keyword.isEmpty()) {
                ps.setString(idx++, "%" + keyword + "%");
                ps.setString(idx++, "%" + keyword + "%");
            }
            if (category != null && !category.isEmpty())
                ps.setString(idx, category);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    // ── Update event ──────────────────────────────────────────────────────────
    public boolean updateEvent(Event event) throws SQLException {
        String sql = "UPDATE events SET title=?, description=?, category_id=?, venue=?, " +
                "event_date=?, event_time=?, deadline=?, capacity=?, status=? WHERE event_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, event.getTitle());
            ps.setString(2, event.getDescription());
            ps.setInt(3,    event.getCategoryId());
            ps.setString(4, event.getVenue());
            ps.setDate(5,   event.getEventDate());
            ps.setTime(6,   event.getEventTime());
            ps.setDate(7,   event.getDeadline());
            ps.setInt(8,    event.getCapacity());
            ps.setString(9, event.getStatus());
            ps.setInt(10,   event.getEventId());
            return ps.executeUpdate() > 0;
        }
    }

    // ── Delete event ──────────────────────────────────────────────────────────
    public boolean deleteEvent(int eventId) throws SQLException {
        String sql = "DELETE FROM events WHERE event_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            return ps.executeUpdate() > 0;
        }
    }

    // ── Count upcoming events (for admin dashboard) ────────────────────────
    public int countUpcomingEvents() throws SQLException {
        String sql = "SELECT COUNT(*) FROM events WHERE status='upcoming'";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    // ── Get most popular events by enrollment count ────────────────────────
    public List<Event> getPopularEvents(int limit) throws SQLException {
        List<Event> list = new ArrayList<>();
        String sql = "SELECT e.*, ec.category_name, COUNT(en.enrollment_id) AS enrollment_count " +
                "FROM events e " +
                "LEFT JOIN event_categories ec ON e.category_id = ec.category_id " +
                "LEFT JOIN enrollments en ON e.event_id = en.event_id AND en.status='approved' " +
                "GROUP BY e.event_id ORDER BY enrollment_count DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    public List<Event> getLatestEvents(int limit) throws SQLException {
        List<Event> list = new ArrayList<>();
        String sql = "SELECT e.*, ec.category_name, COUNT(en.enrollment_id) AS enrollment_count " +
                "FROM events e " +
                "LEFT JOIN event_categories ec ON e.category_id = ec.category_id " +
                "LEFT JOIN enrollments en ON e.event_id = en.event_id AND en.status != 'cancelled' " +
                "GROUP BY e.event_id ORDER BY e.created_at DESC, e.event_id DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    // ── Private mapper ────────────────────────────────────────────────────────
    private Event mapRow(ResultSet rs) throws SQLException {
        Event e = new Event();
        e.setEventId(rs.getInt("event_id"));
        e.setTitle(rs.getString("title"));
        e.setDescription(rs.getString("description"));
        e.setCategoryId(rs.getInt("category_id"));
        e.setCategoryName(rs.getString("category_name"));
        e.setVenue(rs.getString("venue"));
        e.setEventDate(rs.getDate("event_date"));
        e.setEventTime(rs.getTime("event_time"));
        e.setDeadline(rs.getDate("deadline"));
        e.setCapacity(rs.getInt("capacity"));
        e.setBannerImage(rs.getString("banner_image"));
        e.setStatus(rs.getString("status"));
        e.setCreatedBy(rs.getInt("created_by"));
        e.setCreatedAt(rs.getTimestamp("created_at"));
        e.setEnrollmentCount(rs.getInt("enrollment_count"));
        return e;
    }
}
