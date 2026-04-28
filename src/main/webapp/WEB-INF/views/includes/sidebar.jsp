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
            Dashboard
        </a>

        <div class="nav-section-label">Management</div>

        <a href="<%= ctx %>/admin/events?action=list"
           class="nav-link <%= uri.contains("/admin/events") ? "active" : "" %>">
            Events
        </a>

        <a href="<%= ctx %>/admin/users"
           class="nav-link <%= uri.contains("/admin/users") ? "active" : "" %>">
            Students
        </a>

        <% } else { %>
        <div class="nav-section-label">Overview</div>

        <a href="<%= ctx %>/student/dashboard"
           class="nav-link <%= uri.contains("/dashboard") ? "active" : "" %>">
            Dashboard
        </a>

        <div class="nav-section-label">Events</div>

        <a href="<%= ctx %>/student/events"
           class="nav-link <%= uri.contains("/student/events") ? "active" : "" %>">
            Browse Events
        </a>

        <div class="nav-section-label">Account</div>

        <a href="<%= ctx %>/student/profile"
           class="nav-link <%= uri.contains("/profile") ? "active" : "" %>">
            My Profile
        </a>

        <% } %>

        <div class="nav-section-label">Pages</div>
        <a href="<%= ctx %>/about"   class="nav-link">About</a>
        <a href="<%= ctx %>/contact" class="nav-link">Contact</a>

    </nav>

    <% if (sidebarUser != null) { %>
    <div class="sidebar-user">
        <div class="user-avatar">
            <%= sidebarUser.getFullName().substring(0, 1).toUpperCase() %>
        </div>
        <div class="user-info">
            <div class="user-name"><%= sidebarUser.getFullName() %></div>
            <div class="user-role"><%= isAdmin ? "Administrator" : "Student" %></div>
        </div>
    </div>
    <% } %>

</aside>
