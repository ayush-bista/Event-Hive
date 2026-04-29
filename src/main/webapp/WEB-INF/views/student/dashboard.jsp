<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/favicon.png">
    <title>My Dashboard - Event Hive</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body.student-dashboard-page { background:#f5f7fb; color:#111827; }
        .student-dashboard-page .page-body { background:#f5f7fb; }
        .student-dashboard-page .student-dashboard-overview {
            display:grid;
            grid-template-columns:minmax(0,1.58fr) minmax(340px,.92fr);
            gap:28px;
            margin-bottom:32px;
        }
        .student-dashboard-page .student-dashboard-main { min-width:0; }
        .student-dashboard-page .student-profile-banner {
            min-height:170px;
            border-radius:18px;
            padding:30px 34px;
            display:grid;
            grid-template-columns:auto minmax(0,1fr) auto;
            align-items:start;
            gap:20px;
            color:#fff;
            background:
                    radial-gradient(circle at 18% 0%, rgba(255,255,255,.22) 0, rgba(255,255,255,0) 28%),
                    linear-gradient(135deg,#6d28d9 0%,#8b2ee6 48%,#4f46e5 100%);
            box-shadow:0 18px 36px rgba(79,70,229,.16);
            overflow:hidden;
            position:relative;
        }
        .student-dashboard-page .student-profile-banner::after {
            content:'';
            position:absolute;
            inset:0;
            background:
                    linear-gradient(90deg, rgba(255,255,255,.1), transparent 42%),
                    radial-gradient(circle at 85% 18%, rgba(255,255,255,.16), transparent 18%);
            opacity:.9;
            pointer-events:none;
        }
        .student-dashboard-page .student-profile-avatar,
        .student-dashboard-page .student-profile-copy,
        .student-dashboard-page .student-profile-action { position:relative; z-index:1; }
        .student-dashboard-page .student-profile-avatar {
            width:82px;
            height:82px;
            border-radius:50%;
            display:flex;
            align-items:center;
            justify-content:center;
            background:#fff;
            color:#8a20e6;
            font-family:Manrope, Inter, sans-serif;
            font-size:2.2rem;
            font-weight:800;
            line-height:1;
            text-transform:uppercase;
            box-shadow:0 10px 24px rgba(74,20,140,.2);
            overflow:hidden;
        }
        .student-dashboard-page .student-profile-avatar img {
            width:100%;
            height:100%;
            object-fit:cover;
        }
        .student-dashboard-page .student-profile-name {
            font-family:Manrope, Inter, sans-serif;
            font-size:1.65rem;
            font-weight:800;
            line-height:1.1;
            margin-bottom:4px;
        }
        .student-dashboard-page .student-profile-meta { font-size:.85rem; opacity:.9; margin-bottom:12px; }
        .student-dashboard-page .student-profile-copy p {
            max-width:470px;
            font-size:.95rem;
            line-height:1.5;
            color:rgba(255,255,255,.82);
            margin:0;
        }
        .student-dashboard-page .student-profile-action {
            min-height:48px;
            padding:0 20px;
            border:1px solid rgba(255,255,255,.72);
            border-radius:8px;
            display:inline-flex;
            align-items:center;
            justify-content:center;
            color:#fff;
            background:rgba(255,255,255,.08);
            font-weight:600;
            white-space:nowrap;
        }
        .student-dashboard-page .student-profile-action:hover { background:rgba(255,255,255,.18); color:#fff; }
        .student-dashboard-page .student-metric-grid {
            display:grid;
            grid-template-columns:repeat(3,minmax(0,1fr));
            gap:22px;
            margin-top:26px;
        }
        .student-dashboard-page .student-metric-card,
        .student-dashboard-page .student-attendance-card {
            background:#fff;
            border:1px solid #eef0f4;
            border-radius:12px;
            box-shadow:0 16px 34px rgba(15,23,42,.07);
        }
        .student-dashboard-page .student-metric-card {
            min-height:190px;
            padding:22px;
            display:flex;
            flex-direction:column;
        }
        .student-dashboard-page .student-metric-top {
            display:flex;
            align-items:center;
            gap:14px;
            margin-bottom:22px;
        }
        .student-dashboard-page .student-metric-icon {
            width:50px;
            height:50px;
            border-radius:8px;
            display:flex;
            align-items:center;
            justify-content:center;
            font-size:1.35rem;
            font-weight:800;
            flex:0 0 auto;
        }
        .student-dashboard-page .metric-violet .student-metric-icon { background:rgba(162,59,220,.1); color:#9d22d8; }
        .student-dashboard-page .metric-green .student-metric-icon { background:rgba(39,214,128,.1); color:#25c875; }
        .student-dashboard-page .metric-cyan .student-metric-icon { background:rgba(67,183,233,.11); color:#35aee4; }
        .student-dashboard-page .student-metric-icon {
            font-size:0;
        }
        .student-dashboard-page .student-metric-icon::before {
            content:'';
            width:24px;
            height:24px;
            display:block;
            background:currentColor;
            -webkit-mask:var(--metric-icon) center / contain no-repeat;
            mask:var(--metric-icon) center / contain no-repeat;
        }
        .student-dashboard-page .metric-violet .student-metric-icon {
            --metric-icon:url("data:image/svg+xml,%3Csvg viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' stroke='black' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Crect x='4' y='5' width='16' height='15' rx='2'/%3E%3Cpath d='M8 3v4M16 3v4M4 10h16M9 15h1M14 15h1'/%3E%3C/g%3E%3C/svg%3E");
        }
        .student-dashboard-page .metric-green .student-metric-icon {
            --metric-icon:url("data:image/svg+xml,%3Csvg viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' stroke='black' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='M9 3h6l1 2h3v16H5V5h3l1-2Z'/%3E%3Cpath d='m8 13 2.5 2.5L16 10'/%3E%3C/g%3E%3C/svg%3E");
        }
        .student-dashboard-page .metric-cyan .student-metric-icon {
            --metric-icon:url("data:image/svg+xml,%3Csvg viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' stroke='black' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='M7 11v10H4V11h3Z'/%3E%3Cpath d='M7 11l4-8 1.5 1.5c.4.4.6.9.5 1.5l-.5 3H18a3 3 0 0 1 2.9 3.7l-1.2 5A4 4 0 0 1 15.8 21H7V11Z'/%3E%3C/g%3E%3C/svg%3E");
        }
        .student-dashboard-page .student-metric-icon svg {
            width:24px;
            height:24px;
            fill:none;
            stroke:currentColor;
            stroke-width:1.9;
            stroke-linecap:round;
            stroke-linejoin:round;
        }
        .student-dashboard-page .student-metric-top strong {
            display:block;
            font-family:Manrope, Inter, sans-serif;
            font-size:1.95rem;
            line-height:1;
            color:#111827;
        }
        .student-dashboard-page .student-metric-top span {
            display:block;
            margin-top:4px;
            font-size:.78rem;
            color:#8a8f9c;
            line-height:1.2;
        }
        .student-dashboard-page .student-metric-title {
            font-family:Manrope, Inter, sans-serif;
            font-size:1.1rem;
            font-weight:750;
            margin-bottom:8px;
        }
        .student-dashboard-page .student-metric-text {
            color:#737986;
            font-size:.88rem;
            line-height:1.48;
            margin-top:auto;
        }
        .student-dashboard-page .student-attendance-card { min-height:388px; padding:26px 30px; }
        .student-dashboard-page .student-panel-header {
            display:flex;
            align-items:center;
            justify-content:space-between;
            font-family:Manrope, Inter, sans-serif;
            font-size:1.25rem;
            font-weight:800;
            margin-bottom:6px;
        }
        .student-dashboard-page .student-panel-header span {
            width:28px;
            height:28px;
            border-radius:6px;
            display:inline-flex;
            align-items:center;
            justify-content:center;
            background:#f7f7f9;
            color:#111827;
            line-height:1;
        }
        .student-dashboard-page .student-panel-header svg {
            width:18px;
            height:18px;
            fill:none;
            stroke:currentColor;
            stroke-width:2;
            stroke-linecap:round;
            stroke-linejoin:round;
        }
        .student-dashboard-page .student-panel-subtitle {
            color:#7a808c;
            font-size:.86rem;
            line-height:1.45;
            margin-bottom:24px;
        }
        .student-dashboard-page .student-donut-wrap { display:flex; align-items:center; justify-content:center; padding:2px 0 24px; }
        .student-dashboard-page .student-donut {
            width:210px;
            height:210px;
            border-radius:50%;
            background:conic-gradient(#9c21e6 0 calc(var(--approval-rate) * 1%), #ffb52e 0 100%);
            display:flex;
            align-items:center;
            justify-content:center;
        }
        .student-dashboard-page .student-donut-center {
            width:118px;
            height:118px;
            border-radius:50%;
            background:#fff;
            display:flex;
            flex-direction:column;
            align-items:center;
            justify-content:center;
            box-shadow:inset 0 0 0 1px rgba(15,23,42,.03);
        }
        .student-dashboard-page .student-donut-center strong {
            font-family:Manrope, Inter, sans-serif;
            font-size:1.7rem;
            line-height:1;
        }
        .student-dashboard-page .student-donut-center span { color:#777d89; font-size:.86rem; margin-top:4px; }
        .student-dashboard-page .student-donut-legend {
            display:flex;
            justify-content:center;
            gap:28px;
            color:#6b7280;
            font-size:.92rem;
        }
        .student-dashboard-page .student-donut-legend div { display:inline-flex; align-items:center; gap:10px; }
        .student-dashboard-page .student-donut-legend strong { color:#111827; margin-left:4px; }
        .student-dashboard-page .legend-dot { width:14px; height:14px; border-radius:50%; display:inline-block; }
        .student-dashboard-page .legend-dot.present { background:#a83eea; }
        .student-dashboard-page .legend-dot.absent { background:#ff8b13; }
        @media (max-width:1200px) {
            .student-dashboard-page .student-dashboard-overview { grid-template-columns:1fr; }
            .student-dashboard-page .student-attendance-card { min-height:auto; }
        }
        @media (max-width:900px) {
            .student-dashboard-page .student-profile-banner { grid-template-columns:auto minmax(0,1fr); }
            .student-dashboard-page .student-profile-action { grid-column:1 / -1; justify-self:start; }
            .student-dashboard-page .student-metric-grid { grid-template-columns:1fr; }
        }
        @media (max-width:600px) {
            .student-dashboard-page .student-profile-banner { padding:24px; grid-template-columns:1fr; }
            .student-dashboard-page .student-profile-avatar { width:70px; height:70px; font-size:1.9rem; }
            .student-dashboard-page .student-profile-name { font-size:1.35rem; }
            .student-dashboard-page .student-attendance-card { padding:22px 18px; }
            .student-dashboard-page .student-donut { width:180px; height:180px; }
            .student-dashboard-page .student-donut-center { width:104px; height:104px; }
            .student-dashboard-page .student-donut-legend { flex-direction:column; align-items:center; gap:10px; }
        }
    </style>
</head>
<body class="student-dashboard-page">
<div class="page-wrapper">
    <%@ include file="../includes/sidebar.jsp" %>
    <div class="main-content">

        <div class="top-bar">
            <div class="top-bar-title">Welcome, ${sessionScope.loggedInUser.fullName}</div>
            <div class="top-bar-actions">
                <a href="${pageContext.request.contextPath}/student/events" class="btn btn-primary btn-sm">Browse Events</a>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline btn-sm">Sign Out</a>
            </div>
        </div>

        <div class="page-body">

            <!-- Flash messages from session -->
            <% String flashOk  = (String) session.getAttribute("flashSuccess");
                String flashErr = (String) session.getAttribute("flashError");
                if (flashOk  != null) { session.removeAttribute("flashSuccess"); }
                if (flashErr != null) { session.removeAttribute("flashError"); } %>
            <% if (flashOk  != null) { %><div class="alert alert-success mb-16">OK <%= flashOk %></div><% } %>
            <% if (flashErr != null) { %><div class="alert alert-error mb-16">! <%= flashErr %></div><% } %>

            <c:set var="approvedCount" value="0"/>
            <c:set var="futureCount" value="0"/>
            <c:set var="historyCount" value="0"/>
            <c:forEach var="en" items="${myEnrollments}">
                <c:if test="${en.status == 'approved'}">
                    <c:set var="approvedCount" value="${approvedCount + 1}"/>
                </c:if>
                <c:choose>
                    <c:when test="${en.eventStatus == 'upcoming' || en.eventStatus == 'ongoing'}">
                        <c:set var="futureCount" value="${futureCount + 1}"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="historyCount" value="${historyCount + 1}"/>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:set var="approvalRate" value="${myEnrollments.size() == 0 ? 0 : (approvedCount * 100) / myEnrollments.size()}"/>
            <c:set var="futureRate" value="${myEnrollments.size() == 0 ? 0 : (futureCount * 100) / myEnrollments.size()}"/>

            <!-- Student overview -->
            <div class="student-dashboard-overview">
                <div class="student-dashboard-main">
                    <div class="student-profile-banner">
                        <div class="student-profile-avatar">
                            <c:choose>
                                <c:when test="${not empty sessionScope.loggedInUser.profilePic}">
                                    <img src="${pageContext.request.contextPath}/uploads/profiles/${sessionScope.loggedInUser.profilePic}"
                                         alt="${sessionScope.loggedInUser.fullName} profile image">
                                </c:when>
                                <c:otherwise>
                                    <c:out value="${fn:substring(sessionScope.loggedInUser.fullName, 0, 1)}"/>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="student-profile-copy">
                            <div class="student-profile-name">${sessionScope.loggedInUser.fullName}</div>
                            <div class="student-profile-meta">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.loggedInUser.course}">
                                        ${sessionScope.loggedInUser.course}<c:if test="${not empty sessionScope.loggedInUser.level}">, ${sessionScope.loggedInUser.level}</c:if>
                                    </c:when>
                                    <c:otherwise>Student Account</c:otherwise>
                                </c:choose>
                            </div>
                            <p>Track upcoming events, previous enrollments, and approval status from one place.</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/student/profile" class="student-profile-action">View Full Profile</a>
                    </div>

                    <div class="student-metric-grid">
                        <div class="student-metric-card metric-violet">
                            <div class="student-metric-top">
                                <div class="student-metric-icon">📅</div>
                                <div><strong>${upcomingEvents.size()}</strong><span>Available</span></div>
                            </div>
                            <div class="student-metric-title">Events</div>
                            <div class="student-metric-text">Explore open events and enroll from the event browser.</div>
                        </div>
                        <div class="student-metric-card metric-green">
                            <div class="student-metric-top">
                                <div class="student-metric-icon">✅</div>
                                <div><strong>${myEnrollments.size()}</strong><span>Total</span></div>
                            </div>
                            <div class="student-metric-title">Enrollments</div>
                            <div class="student-metric-text">Your registered events are tracked in the table below.</div>
                        </div>
                        <div class="student-metric-card metric-cyan">
                            <div class="student-metric-top">
                                <div class="student-metric-icon">👍</div>
                                <div><strong>${approvalRate}%</strong><span>Approved</span></div>
                            </div>
                            <div class="student-metric-title">Approval Rate</div>
                            <div class="student-metric-text">${approvedCount} approved out of ${myEnrollments.size()} enrollment requests.</div>
                        </div>
                    </div>
                </div>

                <div class="student-attendance-card">
                    <div class="student-panel-header">
                        <div>Enrollment Status</div>
                        <span aria-hidden="true"><svg viewBox="0 0 24 24"><circle cx="12" cy="5" r="1.5"/><circle cx="12" cy="12" r="1.5"/><circle cx="12" cy="19" r="1.5"/></svg></span>
                    </div>
                    <div class="student-panel-subtitle">Approved enrollments compared with other enrollment requests.</div>
                    <div class="student-donut-wrap">
                        <div class="student-donut" style="--approval-rate:${approvalRate};">
                            <div class="student-donut-center">
                                <strong>${myEnrollments.size()}</strong>
                                <span>Enrollments</span>
                            </div>
                        </div>
                    </div>
                    <div class="student-donut-legend">
                        <div><span class="legend-dot present"></span>Approved <strong>${approvalRate}%</strong></div>
                        <div><span class="legend-dot absent"></span>Other <strong>${100 - approvalRate}%</strong></div>
                    </div>
                </div>
            </div>

            <!-- My enrollments -->
            <div class="section-header mt-32">
                <span class="section-title">My Enrollments</span>
                <div class="d-flex gap-8">
                    <a href="${pageContext.request.contextPath}/student/enrollments" class="btn btn-outline btn-sm">View All</a>
                    <a href="${pageContext.request.contextPath}/student/events" class="btn btn-outline btn-sm">+ Enroll in Event</a>
                </div>
            </div>
            <div class="table-wrap mb-24">
                <table>
                    <thead>
                    <tr><th>Event</th><th>Date</th><th>Enrolled On</th><th>Status</th><th>Event Status</th><th>Action</th></tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty myEnrollments}">
                            <tr><td colspan="6" class="text-center text-muted" style="padding:32px;">
                                You haven't enrolled in any events yet.
                                <a href="${pageContext.request.contextPath}/student/events">Browse events</a>
                            </td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="en" items="${myEnrollments}" varStatus="loop">
                                <c:if test="${loop.index < 4}">
                                    <tr>
                                        <td class="fw-600">${en.eventTitle}</td>
                                        <td class="text-sm">${en.eventDate}</td>
                                        <td class="text-sm text-muted">${en.enrolledAt}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${en.status == 'approved'}"><span class="badge badge-green">Approved</span></c:when>
                                                <c:when test="${en.status == 'pending'}"><span class="badge badge-amber">Pending</span></c:when>
                                                <c:when test="${en.status == 'rejected'}"><span class="badge badge-rose">Rejected</span></c:when>
                                                <c:otherwise><span class="badge badge-muted">Cancelled</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${en.eventStatus == 'upcoming'}"><span class="badge badge-violet">Upcoming</span></c:when>
                                                <c:when test="${en.eventStatus == 'ongoing'}"><span class="badge badge-green">Ongoing</span></c:when>
                                                <c:when test="${en.eventStatus == 'completed'}"><span class="badge badge-muted">Completed</span></c:when>
                                                <c:otherwise><span class="badge badge-rose">Cancelled</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:if test="${en.status == 'pending' || en.status == 'approved'}">
                                                <form method="post" action="${pageContext.request.contextPath}/student/enroll" style="display:inline">
                                                    <input type="hidden" name="action" value="cancel">
                                                    <input type="hidden" name="eventId" value="${en.eventId}">
                                                    <button type="submit" class="btn btn-danger btn-sm"
                                                            onclick="return confirm('Cancel this enrollment?')">Cancel</button>
                                                </form>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>

            <!-- Latest Events -->
            <div class="section-header">
                <span class="section-title">Latest Events</span>
                <a href="${pageContext.request.contextPath}/student/events" class="btn btn-outline btn-sm">See All</a>
            </div>
            <div class="events-grid latest-events-grid">
                <c:forEach var="ev" items="${popularEvents}">
                    <div class="event-card">
                        <div class="event-card-banner">
                            <c:choose>
                                <c:when test="${not empty ev.bannerImage && ev.bannerImage != 'default_event.png'}">
                                    <img src="${pageContext.request.contextPath}/uploads/events/${ev.bannerImage}"
                                         alt="${ev.title} cover">
                                </c:when>
                                <c:otherwise>
                                    <span>
                                        <c:choose>
                                            <c:when test="${ev.categoryName == 'Technical'}">TECH</c:when>
                                            <c:when test="${ev.categoryName == 'Cultural'}">CULT</c:when>
                                            <c:when test="${ev.categoryName == 'Sports'}">SPRT</c:when>
                                            <c:when test="${ev.categoryName == 'Academic'}">ACAD</c:when>
                                            <c:otherwise>EVNT</c:otherwise>
                                        </c:choose>
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="event-card-body">
                            <div class="event-card-category">${ev.categoryName}</div>
                            <div class="event-card-title">${ev.title}</div>
                            <c:if test="${not empty ev.description}">
                                <div class="event-card-description">${ev.description}</div>
                            </c:if>
                            <div class="event-meta">
                                <span>Date: ${ev.eventDate}</span>
                                <span>Venue: ${ev.venue}</span>
                                <span>${ev.enrollmentCount} enrolled</span>
                            </div>
                            <div class="event-card-footer">
                                <c:choose>
                                    <c:when test="${ev.status == 'upcoming'}"><span class="badge badge-violet">Upcoming</span></c:when>
                                    <c:when test="${ev.status == 'ongoing'}"><span class="badge badge-green">Ongoing</span></c:when>
                                    <c:when test="${ev.status == 'completed'}"><span class="badge badge-muted">Completed</span></c:when>
                                    <c:otherwise><span class="badge badge-rose">Cancelled</span></c:otherwise>
                                </c:choose>
                                <a href="${pageContext.request.contextPath}/student/events"
                                   class="btn btn-primary btn-sm latest-event-view-btn">View</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

        </div>
    </div>
</div>
</body>
</html>

