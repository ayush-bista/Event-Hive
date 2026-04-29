<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    // Determine if admin or student for nav links
    model.User sidebarUser = (model.User) session.getAttribute("loggedInUser");
    boolean isAdmin = sidebarUser != null && sidebarUser.isAdmin();
    String ctx = request.getContextPath();
    String uri = request.getRequestURI();
%>

<aside class="sidebar" id="sidebar">

    <div class="sidebar-logo">
        <div class="logo-text">Event Hive</div>
        <div class="logo-sub">IIC Event Management</div>
    </div>

    <nav class="sidebar-nav <%= isAdmin ? "admin-nav" : "student-nav" %>">

        <% if (isAdmin) { %>
        <div class="nav-section-label">Overview</div>

        <a href="<%= ctx %>/admin/dashboard"
           class="nav-link <%= uri.contains("/dashboard") ? "active" : "" %>">
            <span class="nav-icon"><svg viewBox="0 0 24 24"><rect x="4" y="4" width="6" height="6"/><rect x="14" y="4" width="6" height="6"/><rect x="4" y="14" width="6" height="6"/><rect x="14" y="14" width="6" height="6"/></svg></span>
            Dashboard
        </a>

        <div class="nav-section-label">Management</div>

        <a href="<%= ctx %>/admin/events?action=list"
           class="nav-link <%= uri.contains("/admin/events") ? "active" : "" %>">
            <span class="nav-icon"><svg viewBox="0 0 24 24"><rect x="4" y="5" width="16" height="15" rx="2"/><path d="M8 3v4M16 3v4M4 10h16"/></svg></span>
            Events
        </a>

        <a href="<%= ctx %>/admin/users"
           class="nav-link <%= uri.contains("/admin/users") ? "active" : "" %>">
            <span class="nav-icon"><svg viewBox="0 0 24 24"><path d="M16 21v-2a4 4 0 0 0-4-4H7a4 4 0 0 0-4 4v2"/><circle cx="9.5" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.87M16 3.13a4 4 0 0 1 0 7.75"/></svg></span>
            Students
        </a>

        <% } else { %>
        <div class="nav-section-label">Overview</div>

        <a href="<%= ctx %>/student/dashboard"
           class="nav-link <%= uri.contains("/dashboard") ? "active" : "" %>">
            <span class="nav-icon"><svg viewBox="0 0 24 24"><rect x="4" y="4" width="6" height="6"/><rect x="14" y="4" width="6" height="6"/><rect x="4" y="14" width="6" height="6"/><rect x="14" y="14" width="6" height="6"/></svg></span>
            Dashboard
        </a>

        <div class="nav-section-label">Events</div>

        <a href="<%= ctx %>/student/events"
           class="nav-link <%= uri.contains("/student/events") ? "active" : "" %>">
            <span class="nav-icon"><svg viewBox="0 0 24 24"><rect x="4" y="5" width="16" height="15" rx="2"/><path d="M8 3v4M16 3v4M4 10h16"/><path d="M9 15h1M14 15h1"/></svg></span>
            Browse Events
        </a>

        <a href="<%= ctx %>/student/enrollments"
           class="nav-link <%= uri.contains("/student/enrollments") ? "active" : "" %>">
            <span class="nav-icon"><svg viewBox="0 0 24 24"><path d="M9 3h6l1 2h3v16H5V5h3l1-2Z"/><path d="M9 11h6M9 15h4"/></svg></span>
            My Enrollments
        </a>

        <div class="nav-section-label">Account</div>

        <a href="<%= ctx %>/student/profile"
           class="nav-link <%= uri.contains("/profile") ? "active" : "" %>">
            <span class="nav-icon"><svg viewBox="0 0 24 24"><circle cx="12" cy="8" r="4"/><path d="M4 21a8 8 0 0 1 16 0"/></svg></span>
            My Profile
        </a>

        <% } %>

        <div class="nav-section-label">Pages</div>
        <a href="<%= ctx %>/about"   class="nav-link"><span class="nav-icon"><svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><path d="M12 10v6M12 7h.01"/></svg></span>About</a>
        <a href="<%= ctx %>/contact" class="nav-link"><span class="nav-icon"><svg viewBox="0 0 24 24"><rect x="3" y="5" width="18" height="14" rx="2"/><path d="m3 7 9 6 9-6"/></svg></span>Contact</a>

    </nav>

    <% if (sidebarUser != null) { %>
    <div class="sidebar-user">
        <div class="user-avatar">
            <% if (sidebarUser.getProfilePic() != null && !sidebarUser.getProfilePic().isBlank()) { %>
                <img src="<%= ctx %>/uploads/profiles/<%= sidebarUser.getProfilePic() %>"
                     alt="<%= sidebarUser.getFullName() %> profile image">
            <% } else { %>
                <%= sidebarUser.getFullName().substring(0, 1).toUpperCase() %>
            <% } %>
        </div>
        <div class="user-info">
            <div class="user-name"><%= sidebarUser.getFullName() %></div>
            <div class="user-role"><%= isAdmin ? "Administrator" : "Student" %></div>
        </div>
    </div>
    <% } %>

</aside>
