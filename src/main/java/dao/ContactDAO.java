package dao;

import model.ContactMessage;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * ContactDAO - All database operations for the contact_messages table.
 */
public class ContactDAO {

    // ── Save a new message from the contact form
    public boolean saveMessage(ContactMessage msg) throws SQLException {
        String sql = "INSERT INTO contact_messages (sender_name, sender_email, subject, message) " +
                "VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, msg.getSenderName());
            ps.setString(2, msg.getSenderEmail());
            ps.setString(3, msg.getSubject());
            ps.setString(4, msg.getMessage());
            return ps.executeUpdate() > 0;
        }
    }

    // ── Get all messages for admin inbox
    public List<ContactMessage> getAllMessages() throws SQLException {
        List<ContactMessage> list = new ArrayList<>();
        String sql = "SELECT * FROM contact_messages ORDER BY sent_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    // ── Count unread messages
    public int countUnread() throws SQLException {
        String sql = "SELECT COUNT(*) FROM contact_messages WHERE is_read = 0";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    // ── Mark message as read
    public boolean markAsRead(int messageId) throws SQLException {
        String sql = "UPDATE contact_messages SET is_read = 1 WHERE message_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, messageId);
            return ps.executeUpdate() > 0;
        }
    }

    // ── Delete a message
    public boolean deleteMessage(int messageId) throws SQLException {
        String sql = "DELETE FROM contact_messages WHERE message_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, messageId);
            return ps.executeUpdate() > 0;
        }
    }

    // ── Private mapper
    private ContactMessage mapRow(ResultSet rs) throws SQLException {
        ContactMessage m = new ContactMessage();
        m.setMessageId(rs.getInt("message_id"));
        m.setSenderName(rs.getString("sender_name"));
        m.setSenderEmail(rs.getString("sender_email"));
        m.setSubject(rs.getString("subject"));
        m.setMessage(rs.getString("message"));
        m.setIsRead(rs.getInt("is_read"));
        m.setSentAt(rs.getTimestamp("sent_at"));
        return m;
    }
}
