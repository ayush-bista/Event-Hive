<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    model.User sidebarUser = (model.User) session.getAttribute("loggedInUser");
    boolean isAdmin = sidebarUser != null && sidebarUser.isAdmin();
    String ctx = request.getContextPath();
    String uri = request.getRequestURI();
%>

<!-- ── Mobile Top Bar (visible only on small screens) ──────── -->
<div class="mobile-topbar">
    <span class="mobile-topbar-logo">⚡ Event Hive</span>
    <button class="hamburger-btn" id="hamburgerBtn" aria-label="Toggle menu" aria-expanded="false">
        <span></span>
        <span></span>
        <span></span>
    </button>
</div>

<!-- ── Overlay (mobile) ──────────────────────────────────────── -->
<div class="sidebar-overlay" id="sidebarOverlay"></div>

<!-- ── Sidebar ───────────────────────────────────────────────── -->
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
            <span class="nav-icon"><svg viewBox="0 0 24 24"><rect x="3" y="3" width="7" height="7" rx="1"/><rect x="3" y="14" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/></svg></span>
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
            <span class="nav-icon"><svg viewBox="0 0 24 24"><rect x="3" y="3" width="7" height="7" rx="1"/><rect x="3" y="14" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/></svg></span>
            Dashboard
        </a>

        <div class="nav-section-label">Events</div>

        <a href="<%= ctx %>/student/events"
           class="nav-link <%= uri.contains("/student/events") ? "active" : "" %>">
            <span class="nav-icon"><svg viewBox="0 0 24 24"><rect x="4" y="5" width="16" height="15" rx="2"/><path d="M8 3v4M16 3v4M4 10h16"/></svg></span>
            Browse Events
        </a>

        <a href="<%= ctx %>/student/enrollments"
           class="nav-link <%= uri.contains("/student/enrollments") ? "active" : "" %>">
            <span class="nav-icon"><svg viewBox="0 0 24 24"><path d="M9 11l3 3L22 4"/><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"/></svg></span>
            My Enrollments
        </a>

        <div class="nav-section-label">Account</div>

        <a href="<%= ctx %>/student/profile"
           class="nav-link <%= uri.contains("/profile") ? "active" : "" %>">
            <span class="nav-icon"><svg viewBox="0 0 24 24"><circle cx="12" cy="8" r="4"/><path d="M4 20c0-4 3.6-7 8-7s8 3 8 7"/></svg></span>
            My Profile
        </a>

        <% } %>

        <div class="nav-section-label">Pages</div>
        <a href="<%= ctx %>/about" class="nav-link">
            <span class="nav-icon"><svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><path d="M12 8v4M12 16h.01"/></svg></span>
            About
        </a>
        <a href="<%= ctx %>/contact" class="nav-link">
            <span class="nav-icon"><svg viewBox="0 0 24 24"><path d="M4 6.5h16v10A2.5 2.5 0 0 1 17.5 19h-11A2.5 2.5 0 0 1 4 16.5v-10Z"/><path d="m4.5 7 7.5 6 7.5-6"/></svg></span>
            Contact
        </a>

        <!-- Logout at bottom of nav -->
        <div style="margin-top:12px; padding-top:12px; border-top:1px solid var(--border);">
            <a href="<%= ctx %>/logout" class="nav-link" style="color:#F43F5E;">
                <span class="nav-icon"><svg viewBox="0 0 24 24"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg></span>
                Sign Out
            </a>
        </div>

    </nav>

    <% if (sidebarUser != null) { %>
    <div class="sidebar-user">
        <div class="user-avatar">
            <% if (sidebarUser.getProfilePic() != null
                    && !sidebarUser.getProfilePic().isBlank()
                    && !"default.png".equals(sidebarUser.getProfilePic())) { %>
            <img src="<%= ctx %>/uploads/profiles/<%= sidebarUser.getProfilePic() %>"
                 alt="<%= sidebarUser.getFullName() %>">
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

<!-- ── Sidebar Toggle Script ──────────────────────────────────── -->
<script>
    (function() {
        var btn     = document.getElementById('hamburgerBtn');
        var sidebar = document.getElementById('sidebar');
        var overlay = document.getElementById('sidebarOverlay');

        function openSidebar() {
            sidebar.classList.add('open');
            overlay.classList.add('active');
            btn.classList.add('open');
            btn.setAttribute('aria-expanded', 'true');
            document.body.style.overflow = 'hidden';   // prevent background scroll
        }

        function closeSidebar() {
            sidebar.classList.remove('open');
            overlay.classList.remove('active');
            btn.classList.remove('open');
            btn.setAttribute('aria-expanded', 'false');
            document.body.style.overflow = '';
        }

        btn.addEventListener('click', function() {
            if (sidebar.classList.contains('open')) {
                closeSidebar();
            } else {
                openSidebar();
            }
        });

        // Close when clicking the overlay
        overlay.addEventListener('click', closeSidebar);

        // Close when a nav link is clicked (auto navigation)
        var links = sidebar.querySelectorAll('.nav-link');
        links.forEach(function(link) {
            link.addEventListener('click', function() {
                if (window.innerWidth <= 900) closeSidebar();
            });
        });

        // Close on resize if screen becomes desktop size
        window.addEventListener('resize', function() {
            if (window.innerWidth > 900) closeSidebar();
        });
    })();
</script>
