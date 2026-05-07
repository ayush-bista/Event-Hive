<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
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
            <span class="nav-icon"><svg viewBox="0 0 24 24"><path d="M4 13.5a8 8 0 0 1 16 0V19H4v-5.5Z"/><path d="M12 13.5l4-4"/><path d="M7 16.5h2M15 16.5h2"/></svg></span>
            Dashboard
        </a>

        <div class="nav-section-label">Management</div>

        <a href="<%= ctx %>/admin/events?action=list"
           class="nav-link <%= uri.contains("/admin/events") ? "active" : "" %>">
            <span class="nav-icon"><svg viewBox="0 0 24 24"><path d="M5 7.5h14a2 2 0 0 1 2 2v1.25a2.25 2.25 0 0 0 0 4.5v1.25a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-1.25a2.25 2.25 0 0 0 0-4.5V9.5a2 2 0 0 1 2-2Z"/><path d="M9 7.5v11M13 11h4M13 15h3"/></svg></span>
            Events
        </a>

        <a href="<%= ctx %>/admin/users"
           class="nav-link <%= uri.contains("/admin/users") ? "active" : "" %>">
            <span class="nav-icon"><svg viewBox="0 0 24 24"><path d="M8 11.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7Z"/><path d="M3 20a5 5 0 0 1 10 0"/><path d="M17 10a3 3 0 1 0 0-6"/><path d="M15 15.5a5 5 0 0 1 6 4.5"/></svg></span>
            Students
        </a>

        <div class="nav-section-label">Analytics</div>

        <a href="<%= ctx %>/admin/reports"
           class="nav-link <%= uri.contains("/admin/reports") ? "active" : "" %>">
            <span class="nav-icon"><svg viewBox="0 0 24 24"><path d="M3 3v18h18"/><path d="M7 16l4-4 4 4 4-8"/></svg></span>
            Reports
        </a>

        <a href="<%= ctx %>/admin/messages"
           class="nav-link <%= uri.contains("/admin/messages") ? "active" : "" %>">
            <span class="nav-icon"><svg viewBox="0 0 24 24"><path d="M4 6.5h16v10A2.5 2.5 0 0 1 17.5 19h-11A2.5 2.5 0 0 1 4 16.5v-10Z"/><path d="m4.5 7 7.5 6 7.5-6"/></svg></span>
            Messages
        </a>

        <% } else { %>
        <div class="nav-section-label">Overview</div>

        <a href="<%= ctx %>/student/dashboard"
           class="nav-link <%= uri.contains("/dashboard") ? "active" : "" %>">
            <span class="nav-icon"><svg viewBox="0 0 24 24"><path d="M4 13.5a8 8 0 0 1 16 0V19H4v-5.5Z"/><path d="M12 13.5l4-4"/><path d="M7 16.5h2M15 16.5h2"/></svg></span>
            Dashboard
        </a>

        <div class="nav-section-label">Events</div>

        <a href="<%= ctx %>/student/events"
           class="nav-link <%= uri.contains("/student/events") ? "active" : "" %>">
            <span class="nav-icon"><svg viewBox="0 0 24 24"><rect x="4" y="5" width="16" height="15" rx="2"/><path d="M8 3v4M16 3v4M4 10h16"/><circle cx="15.5" cy="15.5" r="2.5"/><path d="m17.5 17.5 2 2"/></svg></span>
            Browse Events
        </a>

        <a href="<%= ctx %>/student/enrollments"
           class="nav-link <%= uri.contains("/student/enrollments") ? "active" : "" %>">
            <span class="nav-icon"><svg viewBox="0 0 24 24"><path d="M8 4h8l1 2h3v14H4V6h3l1-2Z"/><path d="m8 12 2 2 4-4"/><path d="M8 17h8"/></svg></span>
            My Enrollments
        </a>

        <div class="nav-section-label">Account</div>

        <a href="<%= ctx %>/student/profile"
           class="nav-link <%= uri.contains("/profile") ? "active" : "" %>">
            <span class="nav-icon"><svg viewBox="0 0 24 24"><rect x="4" y="5" width="16" height="14" rx="3"/><circle cx="10" cy="11" r="2.5"/><path d="M7 17a3.5 3.5 0 0 1 6 0"/><path d="M15 10h2M15 14h2"/></svg></span>
            My Profile
        </a>

        <% } %>

        <div class="nav-section-label">Pages</div>
        <a href="<%= ctx %>/about"   class="nav-link"><span class="nav-icon"><svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><path d="M12 8v4M12 16h.01"/></svg></span>About</a>
        <a href="<%= ctx %>/contact" class="nav-link"><span class="nav-icon"><svg viewBox="0 0 24 24"><path d="M4 6.5h16v10A2.5 2.5 0 0 1 17.5 19h-11A2.5 2.5 0 0 1 4 16.5v-10Z"/><path d="m4.5 7 7.5 6 7.5-6"/></svg></span>Contact</a>

    </nav>

    <% if (sidebarUser != null) { %>
    <div class="sidebar-user">
        <div class="user-avatar">
            <% if (sidebarUser.getProfilePic() != null && !sidebarUser.getProfilePic().isBlank()) { %>
            <img src="<%= ctx %>/uploads/profiles/<%= sidebarUser.getProfilePic() %>"
                 alt="<%= sidebarUser.getFullName() %> profile image">
            <% } else if (isAdmin) { %>
            <img alt=""
                 src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 96 96'%3E%3Cdefs%3E%3ClinearGradient id='g' x1='12' y1='8' x2='84' y2='88'%3E%3Cstop stop-color='%2338BDF8'/%3E%3Cstop offset='1' stop-color='%236C4FF6'/%3E%3C/linearGradient%3E%3C/defs%3E%3Crect width='96' height='96' rx='48' fill='url(%23g)'/%3E%3Ccircle cx='48' cy='34' r='16' fill='%23fff'/%3E%3Cpath d='M22 80c3.9-14.5 14-23 26-23s22.1 8.5 26 23' fill='%23fff'/%3E%3C/svg%3E">
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
