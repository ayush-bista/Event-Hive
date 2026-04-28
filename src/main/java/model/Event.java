package model;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

/**
 * Event - Model class mapping to the `events` table.
 */
public class Event {

    private int eventId;
    private String title;
    private String description;
    private int categoryId;
    private String categoryName;   // populated via JOIN
    private String venue;
    private Date eventDate;
    private Time eventTime;
    private Date deadline;
    private int capacity;
    private String bannerImage;
    private String status;
    private int createdBy;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Extra: enrollment count (populated via aggregate query)
    private int enrollmentCount;

    public Event() {}

    public int getEventId()                   { return eventId; }
    public void setEventId(int eventId)        { this.eventId = eventId; }

    public String getTitle()                  { return title; }
    public void setTitle(String title)         { this.title = title; }

    public String getDescription()            { return description; }
    public void setDescription(String desc)    { this.description = desc; }

    public int getCategoryId()                { return categoryId; }
    public void setCategoryId(int id)          { this.categoryId = id; }

    public String getCategoryName()           { return categoryName; }
    public void setCategoryName(String name)   { this.categoryName = name; }

    public String getVenue()                  { return venue; }
    public void setVenue(String venue)         { this.venue = venue; }

    public Date getEventDate()                { return eventDate; }
    public void setEventDate(Date d)           { this.eventDate = d; }

    public Time getEventTime()                { return eventTime; }
    public void setEventTime(Time t)           { this.eventTime = t; }

    public Date getDeadline()                 { return deadline; }
    public void setDeadline(Date d)            { this.deadline = d; }

    public int getCapacity()                  { return capacity; }
    public void setCapacity(int capacity)      { this.capacity = capacity; }

    public String getBannerImage()            { return bannerImage; }
    public void setBannerImage(String img)     { this.bannerImage = img; }

    public String getStatus()                 { return status; }
    public void setStatus(String status)       { this.status = status; }

    public int getCreatedBy()                 { return createdBy; }
    public void setCreatedBy(int id)           { this.createdBy = id; }

    public Timestamp getCreatedAt()           { return createdAt; }
    public void setCreatedAt(Timestamp t)      { this.createdAt = t; }

    public Timestamp getUpdatedAt()           { return updatedAt; }
    public void setUpdatedAt(Timestamp t)      { this.updatedAt = t; }

    public int getEnrollmentCount()           { return enrollmentCount; }
    public void setEnrollmentCount(int count)  { this.enrollmentCount = count; }

    /** Returns true if there are still seats available (or capacity is unlimited). */
    public boolean hasAvailableSeats() {
        return capacity == 0 || enrollmentCount < capacity;
    }
}