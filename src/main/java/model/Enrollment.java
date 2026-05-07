package model;

import java.sql.Timestamp;

/**
 * Enrollment - Model class mapping to the enrollments table.
 * UPDATED for Final Milestone — added eventStatus field.
 */
public class Enrollment {

    private int enrollmentId;
    private int userId;
    private int eventId;
    private Timestamp enrolledAt;
    private String status;          // pending, approved, rejected, cancelled

    // Populated via JOINs in EnrollmentDAO
    private String studentName;     // from users.full_name
    private String eventTitle;      // from events.title
    private String eventDate;       // from events.event_date
    private String eventStatus;     // from events.status (upcoming/ongoing/completed/cancelled)

    public Enrollment() {}

    public int getEnrollmentId()                   { return enrollmentId; }
    public void setEnrollmentId(int id)             { this.enrollmentId = id; }

    public int getUserId()                         { return userId; }
    public void setUserId(int userId)               { this.userId = userId; }

    public int getEventId()                        { return eventId; }
    public void setEventId(int eventId)             { this.eventId = eventId; }

    public Timestamp getEnrolledAt()               { return enrolledAt; }
    public void setEnrolledAt(Timestamp t)          { this.enrolledAt = t; }

    public String getStatus()                      { return status; }
    public void setStatus(String status)            { this.status = status; }

    public String getStudentName()                 { return studentName; }
    public void setStudentName(String name)         { this.studentName = name; }

    public String getEventTitle()                  { return eventTitle; }
    public void setEventTitle(String title)         { this.eventTitle = title; }

    public String getEventDate()                   { return eventDate; }
    public void setEventDate(String date)           { this.eventDate = date; }

    public String getEventStatus()                 { return eventStatus; }
    public void setEventStatus(String eventStatus)  { this.eventStatus = eventStatus; }
}
