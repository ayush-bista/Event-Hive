package model;

import java.sql.Timestamp;

/**
 * ContactMessage - Maps to the contact_messages table.
 * Used by the public Contact Us page and admin message viewer.
 */
public class ContactMessage {

    private int messageId;
    private String senderName;
    private String senderEmail;
    private String subject;
    private String message;
    private int isRead;           // 0 = unread, 1 = read
    private Timestamp sentAt;

    public ContactMessage() {}

    public int getMessageId()                     { return messageId; }
    public void setMessageId(int messageId)        { this.messageId = messageId; }

    public String getSenderName()                 { return senderName; }
    public void setSenderName(String senderName)   { this.senderName = senderName; }

    public String getSenderEmail()                { return senderEmail; }
    public void setSenderEmail(String email)       { this.senderEmail = email; }

    public String getSubject()                    { return subject; }
    public void setSubject(String subject)         { this.subject = subject; }

    public String getMessage()                    { return message; }
    public void setMessage(String message)         { this.message = message; }

    public int getIsRead()                        { return isRead; }
    public void setIsRead(int isRead)              { this.isRead = isRead; }

    public Timestamp getSentAt()                  { return sentAt; }
    public void setSentAt(Timestamp sentAt)        { this.sentAt = sentAt; }

    public boolean isUnread() { return this.isRead == 0; }
}
