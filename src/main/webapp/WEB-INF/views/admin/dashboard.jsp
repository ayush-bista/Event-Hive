<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

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
                <div class="alert alert-error mb-16">! ${error}</div>
            </c:if>

            <!-- Stat Cards -->
            <div class="stats-grid admin-stats-grid">
                <div class="stat-card admin-stat-card violet">
                    <div>
                        <div class="admin-stat-title">Total Students</div>
                        <div class="admin-stat-value">${totalStudents}</div>
                        <div class="admin-stat-note">Registered students</div>
                    </div>
                    <div class="admin-stat-icon">
                        <svg viewBox="0 0 24 24"><path d="M16 21v-2a4 4 0 0 0-4-4H7a4 4 0 0 0-4 4v2"/><circle cx="9.5" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.87M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                    </div>
                </div>
                <div class="stat-card admin-stat-card amber">
                    <div>
                        <div class="admin-stat-title">Pending Approvals</div>
                        <div class="admin-stat-value">${pendingUsers}</div>
                        <div class="admin-stat-note">Awaiting review</div>
                    </div>
                    <div class="admin-stat-icon">
                        <svg viewBox="0 0 24 24"><path d="M9 12l2 2 4-4"/><path d="M21 12a9 9 0 1 1-4.2-7.6"/><path d="M21 3v6h-6"/></svg>
                    </div>
                </div>
                <div class="stat-card admin-stat-card cyan">
                    <div>
                        <div class="admin-stat-title">Upcoming Events</div>
                        <div class="admin-stat-value">${upcomingEvents}</div>
                        <div class="admin-stat-note">Scheduled events</div>
                    </div>
                    <div class="admin-stat-icon">
                        <svg viewBox="0 0 24 24"><rect x="4" y="5" width="16" height="15" rx="2"/><path d="M8 3v4M16 3v4M4 10h16"/></svg>
                    </div>
                </div>
                <div class="stat-card admin-stat-card green">
                    <div>
                        <div class="admin-stat-title">Approved Enrollments</div>
                        <div class="admin-stat-value">${totalEnrollments}</div>
                        <div class="admin-stat-note">Confirmed participants</div>
                    </div>
                    <div class="admin-stat-icon">
                        <svg viewBox="0 0 24 24"><path d="M9 11l3 3L22 4"/><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"/></svg>
                    </div>
                </div>
            </div>

            <!-- Two column grid -->
            <div style="display:grid; grid-template-columns:1fr 1fr; gap:20px;" class="dashboard-grid">

                <!-- Participation Charts -->
                <div class="admin-chart-grid">
                    <div class="admin-chart-card monthly-card">
                        <div class="admin-chart-head">
                            <h3>Monthly Participation</h3>
                            <div class="chart-years">
                                <span>${currentYear - 1}</span>
                                <strong>${currentYear}</strong>
                            </div>
                        </div>
                        <div class="bar-chart">
                            <c:forEach var="month" items="${monthlyParticipation}">
                                <div class="bar-item">
                                    <div class="bar-track">
                                        <div class="bar-fill" style="height:${(month.value * 100) / maxMonthlyParticipation}%"></div>
                                    </div>
                                    <span>${month.key}</span>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="admin-chart-card participation-card">
                        <h3>Student Participation</h3>
                        <div class="participation-ring" style="--participation:${participationRate};">
                            <div>
                                <strong>${participatingStudents}</strong>
                                <span>STUDENTS</span>
                            </div>
                        </div>
                        <div class="participation-legend">
                            <div><span class="legend-dot-blue"></span>Participating <strong>${participatingStudents}</strong></div>
                            <div><span class="legend-dot-muted"></span>Total Students <strong>${totalStudents}</strong></div>
                        </div>
                    </div>
                </div>

                <!-- Pending Enrollments -->
                <div>
                    <div class="section-header">
                        <span class="section-title">Pending Enrollments</span>
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
                                    <tr><td colspan="3" class="text-center text-muted" style="padding:24px;">All caught up.</td></tr>
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
                                                        <button type="submit" class="btn btn-success btn-sm">Approve</button>
                                                    </form>
                                                    <form method="post" action="${pageContext.request.contextPath}/admin/events" style="display:inline">
                                                        <input type="hidden" name="action" value="updateEnrollment">
                                                        <input type="hidden" name="enrollmentId" value="${en.enrollmentId}">
                                                        <input type="hidden" name="eventId" value="${en.eventId}">
                                                        <input type="hidden" name="status" value="rejected">
                                                        <button type="submit" class="btn btn-danger btn-sm">Reject</button>
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

            <div class="section-header mt-32">
                <span class="section-title">Student Requests</span>
                <a href="${pageContext.request.contextPath}/admin/users"
                   class="btn btn-outline btn-sm">View All</a>
            </div>
            <div class="table-wrap">
                <table>
                    <thead>
                    <tr>
                        <th>Student</th>
                        <th>Email</th>
                        <th>Course</th>
                        <th>Registered</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty studentRequests}">
                            <tr><td colspan="5" class="text-center text-muted" style="padding:24px;">No student requests.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="s" items="${studentRequests}">
                                <tr>
                                    <td class="fw-600">${s.fullName}</td>
                                    <td class="text-sm">${s.email}</td>
                                    <td class="text-sm text-muted">${empty s.course ? '&mdash;' : s.course}</td>
                                    <td class="text-sm text-muted">${s.createdAt}</td>
                                    <td>
                                        <div class="d-flex gap-8">
                                            <form method="post" action="${pageContext.request.contextPath}/admin/users" style="display:inline">
                                                <input type="hidden" name="action" value="approve">
                                                <input type="hidden" name="userId" value="${s.userId}">
                                                <button type="submit" class="btn btn-success btn-sm">Approve</button>
                                            </form>
                                            <form method="post" action="${pageContext.request.contextPath}/admin/users" style="display:inline">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="userId" value="${s.userId}">
                                                <button type="submit" class="btn btn-danger btn-sm"
                                                        onclick="return confirm('Delete this student request?')">Delete</button>
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

        </div><!-- page-body -->
    </div><!-- main-content -->
</div><!-- page-wrapper -->

<style>
    .admin-stats-grid {
        grid-template-columns: repeat(4, minmax(190px, 1fr));
        gap: 24px;
        margin-bottom: 28px;
    }
    .admin-stat-card {
        min-height: 118px;
        border-radius: 9px;
        padding: 20px 18px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 16px;
        border: 1px solid #e5e7eb;
        box-shadow: 0 3px 8px rgba(15,23,42,0.12);
    }
    .admin-stat-card::before {
        display: none;
    }
    .admin-stat-card:hover {
        transform: none;
        border-color: #d7dce5;
    }
    .admin-stat-title {
        font-size: 0.88rem;
        font-weight: 800;
        color: #1f2937;
        margin-bottom: 14px;
    }
    .admin-stat-value {
        font-family: 'Manrope', sans-serif;
        font-size: 1.72rem;
        line-height: 1;
        font-weight: 900;
        color: #111827;
        margin-bottom: 13px;
    }
    .admin-stat-note {
        font-size: 0.78rem;
        font-weight: 600;
        color: #8b8f99;
    }
    .admin-stat-icon {
        width: 42px;
        height: 42px;
        border-radius: 50%;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        background: #f0ecf8;
        color: #6f55cb;
        flex: 0 0 auto;
    }
    .admin-stat-icon svg {
        width: 23px;
        height: 23px;
        fill: none;
        stroke: currentColor;
        stroke-width: 1.9;
        stroke-linecap: round;
        stroke-linejoin: round;
    }
    .admin-chart-grid {
        display: grid;
        grid-template-columns: minmax(0, 1.45fr) minmax(220px, 0.75fr);
        gap: 20px;
        height: 100%;
    }
    .admin-chart-card {
        background: #ffffff;
        border: 1px solid #eef0f4;
        border-radius: 14px;
        padding: 28px;
        box-shadow: 0 14px 34px rgba(15,23,42,0.06);
    }
    .admin-chart-card h3 {
        font-size: 1rem;
        font-weight: 800;
        margin: 0;
    }
    .admin-chart-head {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 16px;
        margin-bottom: 28px;
    }
    .chart-years {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 0.75rem;
        color: #6b7280;
    }
    .chart-years span,
    .chart-years strong {
        border-radius: 999px;
        padding: 5px 12px;
    }
    .chart-years span {
        background: #f0f1f5;
        font-weight: 700;
    }
    .chart-years strong {
        background: #4f37df;
        color: #ffffff;
        font-weight: 800;
    }
    .bar-chart {
        height: 220px;
        display: grid;
        grid-template-columns: repeat(6, 1fr);
        align-items: end;
        gap: 14px;
    }
    .bar-item {
        height: 100%;
        display: flex;
        flex-direction: column;
        justify-content: flex-end;
        align-items: center;
        gap: 10px;
    }
    .bar-track {
        width: 100%;
        max-width: 62px;
        height: 180px;
        display: flex;
        align-items: flex-end;
        background: #f7f7fd;
        border-radius: 0;
        overflow: hidden;
    }
    .bar-fill {
        width: 100%;
        min-height: 4px;
        background: #5141df;
    }
    .bar-item span {
        font-size: 0.68rem;
        font-weight: 800;
        color: #8b94a6;
    }
    .participation-card {
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    .participation-card h3 {
        align-self: flex-start;
        margin-bottom: 28px;
    }
    .participation-ring {
        width: 156px;
        height: 156px;
        border-radius: 50%;
        background: conic-gradient(#3e2bd7 0 calc(var(--participation) * 1%), #eeeeF4 0 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 28px;
    }
    .participation-ring > div {
        width: 112px;
        height: 112px;
        border-radius: 50%;
        background: #ffffff;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
    }
    .participation-ring strong {
        font-size: 2rem;
        line-height: 1;
        font-weight: 900;
    }
    .participation-ring span {
        font-size: 0.62rem;
        letter-spacing: 0.12em;
        font-weight: 800;
        color: #4b5563;
        margin-top: 6px;
    }
    .participation-legend {
        width: 100%;
        display: flex;
        flex-direction: column;
        gap: 14px;
        font-size: 0.84rem;
        color: #4b5563;
    }
    .participation-legend div {
        display: grid;
        grid-template-columns: auto 1fr auto;
        align-items: center;
        gap: 9px;
    }
    .participation-legend strong {
        color: #111827;
        font-weight: 900;
    }
    .legend-dot-blue,
    .legend-dot-muted {
        width: 8px;
        height: 8px;
        border-radius: 50%;
        display: inline-block;
    }
    .legend-dot-blue { background: #3e2bd7; }
    .legend-dot-muted { background: #e5e7eb; }
    @media (max-width: 800px) {
        .admin-stats-grid { grid-template-columns: 1fr !important; }
        .dashboard-grid { grid-template-columns: 1fr !important; }
        .admin-chart-grid { grid-template-columns: 1fr; }
    }
</style>

</body>
</html>
