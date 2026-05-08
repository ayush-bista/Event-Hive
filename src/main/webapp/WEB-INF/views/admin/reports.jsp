<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%--<%@ taglib prefix="c" uri="jakarta.tags.core" %>--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/favicon.png">
  <title>Reports &mdash; Event Hive</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <style>
    .reports-grid {
      display: grid; grid-template-columns: 1fr 1fr; gap: 22px; margin-bottom: 28px;
    }
    .report-card {
      background: #fff; border: 1px solid rgba(15,23,42,0.08);
      border-radius: 16px; padding: 28px;
      box-shadow: 0 2px 12px rgba(15,23,42,0.06);
    }
    .report-card-title {
      font-family: 'Manrope', sans-serif; font-size: 1rem; font-weight: 800;
      color: #111827; margin-bottom: 18px; display: flex; align-items: center; gap: 8px;
    }
    /* Bar chart */
    .bar-chart { display: flex; align-items: flex-end; gap: 10px; height: 160px; padding: 0 4px; }
    .bar-group { display: flex; flex-direction: column; align-items: center; gap: 6px; flex: 1; }
    .bar-fill {
      width: 100%; border-radius: 6px 6px 0 0;
      background: linear-gradient(180deg, #7C5CFC, #4f46e5);
      transition: height 0.6s ease; min-height: 4px;
    }
    .bar-label { font-size: 0.7rem; color: #9ca3af; font-weight: 600; white-space: nowrap; }
    .bar-value { font-size: 0.72rem; font-weight: 700; color: #374151; }

    /* Summary list */
    .summary-list { display: flex; flex-direction: column; gap: 10px; }
    .summary-row {
      display: flex; align-items: center; justify-content: space-between;
      padding: 10px 14px; background: #f9fafb; border-radius: 10px;
      font-size: 0.88rem;
    }
    .summary-row-left { display: flex; align-items: center; gap: 10px; }
    .summary-rank {
      width: 24px; height: 24px; border-radius: 6px;
      background: linear-gradient(135deg, #7C5CFC, #4f46e5);
      color: #fff; font-size: 0.7rem; font-weight: 700;
      display: flex; align-items: center; justify-content: center;
    }
    .summary-count { font-weight: 700; color: #7C5CFC; font-size: 0.9rem; }

    /* Category breakdown */
    .cat-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
    .cat-item {
      padding: 14px; border-radius: 10px; text-align: center;
      border: 1px solid rgba(15,23,42,0.06);
    }
    .cat-item-num { font-family:'Manrope',sans-serif; font-size:1.6rem; font-weight:800; line-height:1; margin-bottom:4px; }
    .cat-item-label { font-size:0.76rem; color:#6b7280; font-weight:600; }

    /* Full-width table */
    .full-width-card {
      background: #fff; border: 1px solid rgba(15,23,42,0.08);
      border-radius: 16px; overflow: hidden;
      box-shadow: 0 2px 12px rgba(15,23,42,0.06); margin-bottom: 28px;
    }
    .full-width-card-header {
      padding: 18px 24px; border-bottom: 1px solid rgba(15,23,42,0.08);
      font-family: 'Manrope', sans-serif; font-size: 1rem; font-weight: 800; color: #111827;
    }
    @media (max-width: 900px) {
      .reports-grid { grid-template-columns: 1fr; gap: 14px; }
      .cat-grid { grid-template-columns: 1fr; }
      .bar-chart { gap: 6px; padding: 0; }
      .bar-label { font-size: 0.64rem; }
      .report-card { padding: 18px 14px; border-radius: 12px; }
      .full-width-card-header { padding: 14px 14px; font-size: 0.95rem; }
      .stats-grid[style*='repeat(4,1fr)'] { grid-template-columns: 1fr 1fr !important; }
    }
    @media (max-width: 480px) {
      .stats-grid[style*='repeat(4,1fr)'] { grid-template-columns: 1fr !important; }
    }
  </style>
</head>
<body>
<div class="page-wrapper">
  <%@ include file="../includes/sidebar.jsp" %>
  <div class="main-content">

    <div class="top-bar">
      <div class="top-bar-title">Reports &amp; Analytics</div>
      <div class="top-bar-actions">
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline btn-sm">Sign Out</a>
      </div>
    </div>

    <div class="page-body">
      <c:if test="${not empty error}">
        <div class="alert alert-error mb-16">⚠ ${error}</div>
      </c:if>

      <!-- Summary Stats -->
      <div class="stats-grid" style="grid-template-columns:repeat(4,1fr); margin-bottom:28px;">
        <div class="stat-card admin-stat-card violet">
          <div>
            <div class="admin-stat-title">Total Students</div>
            <div class="admin-stat-value">${totalStudents}</div>
            <div class="admin-stat-note">Registered accounts</div>
          </div>
          <div class="admin-stat-icon">
            <svg viewBox="0 0 24 24"><path d="M16 21v-2a4 4 0 0 0-4-4H7a4 4 0 0 0-4 4v2"/><circle cx="9.5" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.87M16 3.13a4 4 0 0 1 0 7.75"/></svg>
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
        <div class="stat-card admin-stat-card amber">
          <div>
            <div class="admin-stat-title">Active Participants</div>
            <div class="admin-stat-value">${participatingStudents}</div>
            <div class="admin-stat-note">Students with approvals</div>
          </div>
          <div class="admin-stat-icon">
            <svg viewBox="0 0 24 24"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
          </div>
        </div>
      </div>

      <div class="reports-grid">

        <!-- Monthly Participation Bar Chart -->
        <div class="report-card">
          <div class="report-card-title">📊 Monthly Participation (Last 6 Months)</div>
          <div class="bar-chart">
            <c:forEach var="entry" items="${monthlyParticipation}">
              <div class="bar-group">
                <div class="bar-value">${entry.value}</div>
                <div class="bar-fill"
                     style="height:${monthlyParticipation.size() > 0 && entry.value > 0 ?
                             (entry.value * 120 / (monthlyParticipation.values().stream().mapToInt(Integer::intValue).max().orElse(1))) : 4}px;">
                </div>
                <div class="bar-label">${entry.key}</div>
              </div>
            </c:forEach>
          </div>
          <div style="margin-top:14px; font-size:0.8rem; color:#9ca3af; text-align:center;">
            Based on approved enrollments per month
          </div>
        </div>

        <!-- Category Breakdown -->
        <div class="report-card">
          <div class="report-card-title">🏷 Events by Category</div>
          <div class="cat-grid">
            <c:set var="academic"  value="0"/>
            <c:set var="cultural"  value="0"/>
            <c:set var="sports"    value="0"/>
            <c:set var="technical" value="0"/>
            <c:set var="social"    value="0"/>
            <c:forEach var="ev" items="${allEvents}">
              <c:choose>
                <c:when test="${ev.categoryName == 'Academic'}">  <c:set var="academic"  value="${academic  + 1}"/></c:when>
                <c:when test="${ev.categoryName == 'Cultural'}">  <c:set var="cultural"  value="${cultural  + 1}"/></c:when>
                <c:when test="${ev.categoryName == 'Sports'}">    <c:set var="sports"    value="${sports    + 1}"/></c:when>
                <c:when test="${ev.categoryName == 'Technical'}"> <c:set var="technical" value="${technical + 1}"/></c:when>
                <c:when test="${ev.categoryName == 'Social'}">    <c:set var="social"    value="${social    + 1}"/></c:when>
              </c:choose>
            </c:forEach>
            <div class="cat-item" style="background:rgba(124,92,252,0.07);">
              <div class="cat-item-num" style="color:#7C5CFC;">${academic}</div>
              <div class="cat-item-label">Academic</div>
            </div>
            <div class="cat-item" style="background:rgba(245,158,11,0.07);">
              <div class="cat-item-num" style="color:#F59E0B;">${cultural}</div>
              <div class="cat-item-label">Cultural</div>
            </div>
            <div class="cat-item" style="background:rgba(16,185,129,0.07);">
              <div class="cat-item-num" style="color:#10B981;">${sports}</div>
              <div class="cat-item-label">Sports</div>
            </div>
            <div class="cat-item" style="background:rgba(56,189,248,0.07);">
              <div class="cat-item-num" style="color:#38BDF8;">${technical}</div>
              <div class="cat-item-label">Technical</div>
            </div>
          </div>
          <div class="cat-item" style="background:rgba(244,63,94,0.07); margin-top:10px; border-radius:10px; padding:14px; text-align:center; border:1px solid rgba(15,23,42,0.06);">
            <div class="cat-item-num" style="color:#F43F5E;">${social}</div>
            <div class="cat-item-label">Social</div>
          </div>
        </div>

      </div>

      <!-- Popular Events Table -->
      <div class="full-width-card">
        <div class="full-width-card-header">🔥 Most Popular Events (by Enrollment Count)</div>
        <table>
          <thead>
          <tr>
            <th>Rank</th>
            <th>Event Title</th>
            <th>Category</th>
            <th>Date</th>
            <th>Venue</th>
            <th>Capacity</th>
            <th>Enrolled</th>
            <th>Status</th>
          </tr>
          </thead>
          <tbody>
          <c:choose>
            <c:when test="${empty popularEvents}">
              <tr>
                <td colspan="8" class="text-center text-muted" style="padding:32px;">
                  No events with enrollments yet.
                </td>
              </tr>
            </c:when>
            <c:otherwise>
              <c:forEach var="ev" items="${popularEvents}" varStatus="loop">
                <tr>
                  <td>
                    <div style="width:28px;height:28px;border-radius:7px;
                                  background:linear-gradient(135deg,#7C5CFC,#4f46e5);
                                  color:#fff;font-size:0.75rem;font-weight:700;
                                  display:flex;align-items:center;justify-content:center;">
                        ${loop.count}
                    </div>
                  </td>
                  <td class="fw-600">${ev.title}</td>
                  <td><span class="badge badge-violet">${ev.categoryName}</span></td>
                  <td class="text-sm">${ev.eventDate}</td>
                  <td class="text-sm text-muted">${ev.venue}</td>
                  <td class="text-sm">${ev.capacity == 0 ? 'Unlimited' : ev.capacity}</td>
                  <td>
                    <span class="badge badge-cyan">${ev.enrollmentCount}</span>
                  </td>
                  <td>
                    <c:choose>
                      <c:when test="${ev.status == 'upcoming'}"><span class="badge badge-violet">Upcoming</span></c:when>
                      <c:when test="${ev.status == 'ongoing'}"><span class="badge badge-green">Ongoing</span></c:when>
                      <c:when test="${ev.status == 'completed'}"><span class="badge badge-muted">Completed</span></c:when>
                      <c:otherwise><span class="badge badge-rose">Cancelled</span></c:otherwise>
                    </c:choose>
                  </td>
                </tr>
              </c:forEach>
            </c:otherwise>
          </c:choose>
          </tbody>
        </table>
      </div>

      <!-- All Events Summary -->
      <div class="full-width-card">
        <div class="full-width-card-header">📋 All Events Summary</div>
        <table>
          <thead>
          <tr><th>#</th><th>Title</th><th>Category</th><th>Date</th><th>Enrollments</th><th>Status</th></tr>
          </thead>
          <tbody>
          <c:forEach var="ev" items="${allEvents}" varStatus="loop">
            <tr>
              <td class="text-sm text-muted">${loop.count}</td>
              <td class="fw-600">${ev.title}</td>
              <td><span class="badge badge-violet">${ev.categoryName}</span></td>
              <td class="text-sm">${ev.eventDate}</td>
              <td><span class="badge badge-cyan">${ev.enrollmentCount}</span></td>
              <td>
                <c:choose>
                  <c:when test="${ev.status == 'upcoming'}"><span class="badge badge-violet">Upcoming</span></c:when>
                  <c:when test="${ev.status == 'ongoing'}"><span class="badge badge-green">Ongoing</span></c:when>
                  <c:when test="${ev.status == 'completed'}"><span class="badge badge-muted">Completed</span></c:when>
                  <c:otherwise><span class="badge badge-rose">Cancelled</span></c:otherwise>
                </c:choose>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>

    </div>
  </div>
</div>
</body>
</html>
