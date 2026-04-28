<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/favicon.png">
    <title>My Dashboard - Event Hive</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="page-wrapper">
    <%@ include file="../includes/sidebar.jsp" %>
    <div class="main-content">

        <div class="top-bar">
            <div class="top-bar-title">&#128075; Welcome, ${sessionScope.loggedInUser.fullName}</div>
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
            <% if (flashOk  != null) { %><div class="alert alert-success mb-16">&#10004; <%= flashOk %></div><% } %>
            <% if (flashErr != null) { %><div class="alert alert-error mb-16">&#9888; <%= flashErr %></div><% } %>

            <!-- Quick stats -->
            <div class="stats-grid" style="grid-template-columns: repeat(3, 1fr);">
                <div class="stat-card violet">
                    <div class="stat-icon">&#128467;</div>
                    <div class="stat-value">${upcomingEvents.size()}</div>
                    <div class="stat-label">Events Available</div>
                </div>
                <div class="stat-card cyan">
                    <div class="stat-icon">&#127915;</div>
                    <div class="stat-value">${myEnrollments.size()}</div>
                    <div class="stat-label">My Enrollments</div>
                </div>
                <div class="stat-card green">
                    <div class="stat-icon">&#10004;</div>
                    <div class="stat-value">
                        <c:set var="approvedCount" value="0"/>
                        <c:forEach var="en" items="${myEnrollments}">
                            <c:if test="${en.status == 'approved'}">
                                <c:set var="approvedCount" value="${approvedCount + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${approvedCount}
                    </div>
                    <div class="stat-label">Approved</div>
                </div>
            </div>

            <!-- My enrollments -->
            <div class="section-header mt-32">
                <span class="section-title">My Enrollments</span>
                <a href="${pageContext.request.contextPath}/student/events" class="btn btn-outline btn-sm">+ Enroll in Event</a>
            </div>
            <div class="table-wrap mb-24">
                <table>
                    <thead>
                    <tr><th>Event</th><th>Date</th><th>Enrolled On</th><th>Status</th><th>Action</th></tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty myEnrollments}">
                            <tr><td colspan="5" class="text-center text-muted" style="padding:32px;">
                                You haven't enrolled in any events yet.
                                <a href="${pageContext.request.contextPath}/student/events">Browse events &rarr;</a>
                            </td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="en" items="${myEnrollments}">
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
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>

            <!-- Popular Events -->
            <div class="section-header">
                <span class="section-title">&#128293; Trending Events &#128293;</span>
                <a href="${pageContext.request.contextPath}/student/events" class="btn btn-outline btn-sm">See All</a>
            </div>
            <div class="events-grid">
                <c:forEach var="ev" items="${popularEvents}">
                    <div class="event-card">
                        <div class="event-card-banner">
                            <c:choose>
                                <c:when test="${ev.categoryName == 'Technical'}">&#128187;</c:when>
                                <c:when test="${ev.categoryName == 'Cultural'}">&#127917;</c:when>
                                <c:when test="${ev.categoryName == 'Sports'}">&#9917;</c:when>
                                <c:when test="${ev.categoryName == 'Academic'}">&#128218;</c:when>
                                <c:otherwise>&#127881;</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="event-card-body">
                            <div class="event-card-category">${ev.categoryName}</div>
                            <div class="event-card-title">${ev.title}</div>
                            <div class="event-meta">
                                <span>&#128467; ${ev.eventDate}</span>
                                <span>&#128205; ${ev.venue}</span>
                                <span>&#128101; ${ev.enrollmentCount} enrolled</span>
                            </div>
                            <div class="event-card-footer">
                                <c:choose>
                                    <c:when test="${ev.status == 'upcoming'}"><span class="badge badge-violet">Upcoming</span></c:when>
                                    <c:when test="${ev.status == 'ongoing'}"><span class="badge badge-green">Ongoing</span></c:when>
                                    <c:when test="${ev.status == 'completed'}"><span class="badge badge-muted">Completed</span></c:when>
                                    <c:otherwise><span class="badge badge-rose">Cancelled</span></c:otherwise>
                                </c:choose>
                                <a href="${pageContext.request.contextPath}/student/events"
                                   class="btn btn-primary btn-sm">View</a>
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

