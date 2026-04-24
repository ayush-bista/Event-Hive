<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/favicon.png">
    <title>Admin Dashboard &mdash; Event Hive</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<div class="page-wrapper">

    <%@ include file="../includes/sidebar.jsp" %>

    <div class="main-content">

        <!-- Top Bar -->
        <div class="top-bar">
            <div class="top-bar-title">Dashboard</div>
            <div class="top-bar-actions">
                <a href="${pageContext.request.contextPath}/admin/events?action=add"
                   class="btn btn-primary btn-sm">+ New Event</a>
                <a href="${pageContext.request.contextPath}/logout"
                   class="btn btn-outline btn-sm">Sign Out</a>
            </div>
        </div>

        <div class="page-body">

            <!-- Alert -->
            <c:if test="${not empty error}">
                <div class="alert alert-error mb-16">&#9888; ${error}</div>
            </c:if>

            <!-- Stat Cards -->
            <div class="stats-grid">
                <div class="stat-card violet">
                    <div class="stat-icon">&#127891;</div>
                    <div class="stat-value">${totalStudents}</div>
                    <div class="stat-label">Total Students</div>
                </div>
                <div class="stat-card amber">
                    <div class="stat-icon">&#9203;</div>
                    <div class="stat-value">${pendingUsers}</div>
                    <div class="stat-label">Pending Approvals</div>
                </div>
                <div class="stat-card cyan">
                    <div class="stat-icon">&#128467;</div>
                    <div class="stat-value">${upcomingEvents}</div>
                    <div class="stat-label">Upcoming Events</div>
                </div>
                <div class="stat-card green">
                    <div class="stat-icon">&#10004;</div>
                    <div class="stat-value">${totalEnrollments}</div>
                    <div class="stat-label">Approved Enrollments</div>
                </div>
            </div>

            <!-- Two column grid -->
            <div style="display:grid; grid-template-columns:1fr 1fr; gap:20px;" class="dashboard-grid">

                <!-- Popular Events -->
                <div>
                    <div class="section-header">
                        <span class="section-title">&#128293; Popular Events</span>
                        <a href="${pageContext.request.contextPath}/admin/events?action=list"
                           class="btn btn-outline btn-sm">View All</a>
                    </div>
                    <div class="table-wrap">
                        <table>
                            <thead>
                            <tr>
                                <th>Event</th>
                                <th>Enrolled</th>
                                <th>Status</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${empty popularEvents}">
                                    <tr><td colspan="3" class="text-center text-muted" style="padding:24px;">No events yet</td></tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="ev" items="${popularEvents}">
                                        <tr>
                                            <td class="fw-600">${ev.title}</td>
                                            <td><span class="badge badge-cyan">${ev.enrollmentCount}</span></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${ev.status == 'upcoming'}">
                                                        <span class="badge badge-violet">Upcoming</span>
                                                    </c:when>
                                                    <c:when test="${ev.status == 'ongoing'}">
                                                        <span class="badge badge-green">Ongoing</span>
                                                    </c:when>
                                                    <c:when test="${ev.status == 'completed'}">
                                                        <span class="badge badge-muted">Completed</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-rose">Cancelled</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Pending Enrollments -->
                <div>
                    <div class="section-header">
                        <span class="section-title">&#128203; Pending Enrollments</span>
                    </div>
                    <div class="table-wrap">
                        <table>
                            <thead>
                            <tr>
                                <th>Student</th>
                                <th>Event</th>
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${empty pendingEnrollments}">
                                    <tr><td colspan="3" class="text-center text-muted" style="padding:24px;">All caught up! &#10024;</td></tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="en" items="${pendingEnrollments}">
                                        <tr>
                                            <td>${en.studentName}</td>
                                            <td class="text-sm" style="max-width:120px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">${en.eventTitle}</td>
                                            <td>
                                                <div class="d-flex gap-8">
                                                    <form method="post" action="${pageContext.request.contextPath}/admin/events" style="display:inline">
                                                        <input type="hidden" name="action" value="updateEnrollment">
                                                        <input type="hidden" name="enrollmentId" value="${en.enrollmentId}">
                                                        <input type="hidden" name="eventId" value="${en.eventId}">
                                                        <input type="hidden" name="status" value="approved">
                                                        <button type="submit" class="btn btn-success btn-sm">&#10003;</button>
                                                    </form>
                                                    <form method="post" action="${pageContext.request.contextPath}/admin/events" style="display:inline">
                                                        <input type="hidden" name="action" value="updateEnrollment">
                                                        <input type="hidden" name="enrollmentId" value="${en.enrollmentId}">
                                                        <input type="hidden" name="eventId" value="${en.eventId}">
                                                        <input type="hidden" name="status" value="rejected">
                                                        <button type="submit" class="btn btn-danger btn-sm">&#10005;</button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div><!-- end dashboard-grid -->

        </div><!-- page-body -->
    </div><!-- main-content -->
</div><!-- page-wrapper -->

<style>
    @media (max-width: 800px) {
        .dashboard-grid { grid-template-columns: 1fr !important; }
    }
</style>

</body>
</html>