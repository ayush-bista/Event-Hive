package model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * User - Model class mapping to the `users` table.
 */
public class User {

    private int userId;
    private String fullName;
    private String email;
    private String phone;
    private String password;
    private String role;          // "admin" or "student"
    private Date dateOfBirth;
    private String profilePic;
    private int isApproved;       // 0=pending, 1=approved
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // ── Student-only extra fields (from student_details join) ──
    private String course;
    private String level;
    private int year;

    public User() {}

    // ── Getters and Setters ──

    public int getUserId()                   { return userId; }
    public void setUserId(int userId)         { this.userId = userId; }

    public String getFullName()              { return fullName; }
    public void setFullName(String fullName)  { this.fullName = fullName; }

    public String getEmail()                 { return email; }
    public void setEmail(String email)        { this.email = email; }

    public String getPhone()                 { return phone; }
    public void setPhone(String phone)        { this.phone = phone; }

    public String getPassword()              { return password; }
    public void setPassword(String password)  { this.password = password; }

    public String getRole()                  { return role; }
    public void setRole(String role)          { this.role = role; }

    public Date getDateOfBirth()             { return dateOfBirth; }
    public void setDateOfBirth(Date dob)      { this.dateOfBirth = dob; }

    public String getProfilePic()            { return profilePic; }
    public void setProfilePic(String pic)     { this.profilePic = pic; }

    public int getIsApproved()               { return isApproved; }
    public void setIsApproved(int isApproved) { this.isApproved = isApproved; }

    public Timestamp getCreatedAt()          { return createdAt; }
    public void setCreatedAt(Timestamp t)     { this.createdAt = t; }

    public Timestamp getUpdatedAt()          { return updatedAt; }
    public void setUpdatedAt(Timestamp t)     { this.updatedAt = t; }

    public String getCourse()                { return course; }
    public void setCourse(String course)      { this.course = course; }

    public String getLevel()                 { return level; }
    public void setLevel(String level)        { this.level = level; }

    public int getYear()                     { return year; }
    public void setYear(int year)             { this.year = year; }

    public boolean isAdmin()   { return "admin".equals(this.role); }
    public boolean isStudent() { return "student".equals(this.role); }
    public boolean isApprovedUser() { return this.isApproved == 1; }
}