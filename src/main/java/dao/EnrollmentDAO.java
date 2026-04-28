package dao;

import model.Enrollment;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * EnrollmentDAO - All database operations for the enrollments table.
 */
public class EnrollmentDAO {

    // ── Enroll student in event ───────────────────────────────────────────────
    public boolean enroll(int userId, int eventId) throws SQLException {
        String sql = "INSERT INTO enrollments (user_id, event_id, status) VALUES (?, ?, 'pending')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, eventId);
            return ps.executeUpdate() > 0;
        }
    }

    // ── Check if student is already enrolled ──────────────────────────────────
    public boolean isEnrolled(int userId, int eventId) throws SQLException {
        String sql = "SELECT 1 FROM enrollments WHERE user_id=? AND event_id=? AND status != 'cancelled'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, eventId);
            return ps.executeQuery().next();
        }
    }

    // ── Get all enrollments for a student ─────────────────────────────────────
    public List<Enrollment> getEnrollmentsByUser(int userId) throws SQLException {
        List<Enrollment> list = new ArrayList<>();
        String sql = "SELECT en.*, e.title AS event_title, e.event_date " +
                "FROM enrollments en " +
                "JOIN events e ON en.event_id = e.event_id " +
                "WHERE en.user_id = ? ORDER BY en.enrolled_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    // ── Get all enrollments for an event (admin view) ────────────────────────
    public List<Enrollment> getEnrollmentsByEvent(int eventId) throws SQLException {
        List<Enrollment> list = new ArrayList<>();
        String sql = "SELECT en.*, u.full_name AS student_name, e.title AS event_title, e.event_date " +
                "FROM enrollments en " +
                "JOIN users u  ON en.user_id  = u.user_id " +
                "JOIN events e ON en.event_id = e.event_id " +
                "WHERE en.event_id = ? ORDER BY en.enrolled_at";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    // ── Get all pending enrollments (admin) ────────────────────────────────
    public List<Enrollment> getAllPendingEnrollments() throws SQLException {
        List<Enrollment> list = new ArrayList<>();
        String sql = "SELECT en.*, u.full_name AS student_name, e.title AS event_title, e.event_date " +
                "FROM enrollments en " +
                "JOIN users u  ON en.user_id  = u.user_id " +
                "JOIN events e ON en.event_id = e.event_id " +
                "WHERE en.status='pending' ORDER BY en.enrolled_at";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    // ── Update enrollment status ──────────────────────────────────────────────
    public boolean updateStatus(int enrollmentId, String status) throws SQLException {
        String sql = "UPDATE enrollments SET status=? WHERE enrollment_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, enrollmentId);
            return ps.executeUpdate() > 0;
        }
    }

    // ── Cancel enrollment (student cancels own) ────────────────────────────
    public boolean cancelEnrollment(int userId, int eventId) throws SQLException {
        String sql = "UPDATE enrollments SET status='cancelled' WHERE user_id=? AND event_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, eventId);
            return ps.executeUpdate() > 0;
        }
    }

    // ── Total enrollment count (admin dashboard) ────────────────────────────
    public int countTotalEnrollments() throws SQLException {
        String sql = "SELECT COUNT(*) FROM enrollments WHERE status='approved'";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    // ── Private mapper ────────────────────────────────────────────────────────
    private Enrollment mapRow(ResultSet rs) throws SQLException {
        Enrollment en = new Enrollment();
        en.setEnrollmentId(rs.getInt("enrollment_id"));
        en.setUserId(rs.getInt("user_id"));
        en.setEventId(rs.getInt("event_id"));
        en.setEnrolledAt(rs.getTimestamp("enrolled_at"));
        en.setStatus(rs.getString("status"));
        try { en.setStudentName(rs.getString("student_name")); } catch (SQLException ignored) {}
        try { en.setEventTitle(rs.getString("event_title")); }  catch (SQLException ignored) {}
        try { en.setEventDate(String.valueOf(rs.getDate("event_date"))); } catch (SQLException ignored) {}
        return en;
    }
}