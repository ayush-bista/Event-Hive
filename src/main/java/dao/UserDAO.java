package dao;

import model.User;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * UserDAO - All database operations for the users table.
 */
public class UserDAO {

    // ── Register new student ──────────────────────────────────────────────────
    public boolean registerUser(User user) throws SQLException {
        String sql = "INSERT INTO users (full_name, email, phone, password, role, date_of_birth, is_approved) " +
                "VALUES (?, ?, ?, ?, 'student', ?, 0)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getPassword());
            ps.setDate(5, user.getDateOfBirth());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                ResultSet keys = ps.getGeneratedKeys();
                if (keys.next()) user.setUserId(keys.getInt(1));
                return true;
            }
        }
        return false;
    }

    // ── Insert student academic details ───────────────────────────────────────
    public void insertStudentDetails(User user) throws SQLException {
        String sql = "INSERT INTO student_details (user_id, course, level, year) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1,    user.getUserId());
            ps.setString(2, user.getCourse());
            ps.setString(3, user.getLevel());
            ps.setInt(4,    user.getYear());
            ps.executeUpdate();
        }
    }

    // ── Find user by email (for login) ────────────────────────────────────────
    public User findByEmail(String email) throws SQLException {
        String sql = "SELECT u.*, sd.course, sd.level, sd.year " +
                "FROM users u " +
                "LEFT JOIN student_details sd ON u.user_id = sd.user_id " +
                "WHERE u.email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        }
        return null;
    }

    // ── Check if email already exists ─────────────────────────────────────────
    public boolean emailExists(String email) throws SQLException {
        String sql = "SELECT 1 FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            return ps.executeQuery().next();
        }
    }

    // ── Check if phone already exists ─────────────────────────────────────────
    public boolean phoneExists(String phone) throws SQLException {
        String sql = "SELECT 1 FROM users WHERE phone = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, phone);
            return ps.executeQuery().next();
        }
    }

    // ── Get user by ID ────────────────────────────────────────────────────────
    public User getUserById(int userId) throws SQLException {
        String sql = "SELECT u.*, sd.course, sd.level, sd.year " +
                "FROM users u " +
                "LEFT JOIN student_details sd ON u.user_id = sd.user_id " +
                "WHERE u.user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        }
        return null;
    }

    // ── Get all students (for admin) ──────────────────────────────────────────
    public List<User> getAllStudents() throws SQLException {
        List<User> list = new ArrayList<>();
        String sql = "SELECT u.*, sd.course, sd.level, sd.year " +
                "FROM users u " +
                "LEFT JOIN student_details sd ON u.user_id = sd.user_id " +
                "WHERE u.role = 'student' ORDER BY u.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    // ── Approve student ───────────────────────────────────────────────────────
    public boolean approveUser(int userId) throws SQLException {
        String sql = "UPDATE users SET is_approved = 1 WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        }
    }

    // ── Delete user ───────────────────────────────────────────────────────────
    public boolean deleteUser(int userId) throws SQLException {
        String sql = "DELETE FROM users WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        }
    }

    // ── Update profile ────────────────────────────────────────────────────────
    public boolean updateProfile(User user) throws SQLException {
        String sql = "UPDATE users SET full_name=?, phone=?, date_of_birth=? WHERE user_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getPhone());
            ps.setDate(3,   user.getDateOfBirth());
            ps.setInt(4,    user.getUserId());
            return ps.executeUpdate() > 0;
        }
    }

    // ── Update password ───────────────────────────────────────────────────────
    public boolean updatePassword(int userId, String newHashedPassword) throws SQLException {
        String sql = "UPDATE users SET password=? WHERE user_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newHashedPassword);
            ps.setInt(2,    userId);
            return ps.executeUpdate() > 0;
        }
    }

    // ── Count pending registrations (for admin dashboard) ────────────────────
    public int countPendingUsers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE role='student' AND is_approved=0";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    // ── Private mapper ────────────────────────────────────────────────────────
    private User mapRow(ResultSet rs) throws SQLException {
        User u = new User();
        u.setUserId(rs.getInt("user_id"));
        u.setFullName(rs.getString("full_name"));
        u.setEmail(rs.getString("email"));
        u.setPhone(rs.getString("phone"));
        u.setPassword(rs.getString("password"));
        u.setRole(rs.getString("role"));
        u.setDateOfBirth(rs.getDate("date_of_birth"));
        u.setProfilePic(rs.getString("profile_pic"));
        u.setIsApproved(rs.getInt("is_approved"));
        u.setCreatedAt(rs.getTimestamp("created_at"));
        // student_details columns (may be null for admin)
        u.setCourse(rs.getString("course"));
        u.setLevel(rs.getString("level"));
        u.setYear(rs.getInt("year"));
        return u;
    }
}