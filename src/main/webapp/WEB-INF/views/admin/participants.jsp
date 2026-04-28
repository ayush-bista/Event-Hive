<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/favicon.png">
  <title>Event Participants &mdash; Event Hive</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="page-wrapper">
  <%@ include file="../includes/sidebar.jsp" %>

  <div class="main-content">
    <div class="top-bar">
      <div class="top-bar-title">Participants &mdash; ${event.title}</div>
      <div class="top-bar-actions">
        <a href="${pageContext.request.contextPath}/admin/events?action=list" class="btn btn-outline btn-sm">Back to Events</a>
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline btn-sm">Sign Out</a>
      </div>
    </div>

    <div class="page-body">
      <div class="table-wrap">
        <table>
          <thead>
          <tr>
            <th>#</th>
            <th>Student</th>
            <th>Event</th>
            <th>Date</th>
            <th>Status</th>
            <th>Action</th>
          </tr>
          </thead>
          <tbody>
          <c:choose>
            <c:when test="${empty enrollments}">
              <tr>
                <td colspan="6" class="text-center text-muted" style="padding: 32px;">No enrollments found for this event.</td>
              </tr>
            </c:when>
            <c:otherwise>
              <c:forEach var="en" items="${enrollments}" varStatus="loop">
                <tr>
                  <td class="text-sm text-muted">${loop.count}</td>
                  <td class="fw-600">${en.studentName}</td>
                  <td class="text-sm">${en.eventTitle}</td>
                  <td class="text-sm">${en.eventDate}</td>
                  <td>
                    <c:choose>
                      <c:when test="${en.status == 'approved'}"><span class="badge badge-green">Approved</span></c:when>
                      <c:when test="${en.status == 'pending'}"><span class="badge badge-amber">Pending</span></c:when>
                      <c:when test="${en.status == 'rejected'}"><span class="badge badge-rose">Rejected</span></c:when>
                      <c:otherwise><span class="badge badge-muted">${en.status}</span></c:otherwise>
                    </c:choose>
                  </td>
                  <td>
                    <c:choose>
                      <c:when test="${en.status == 'pending'}">
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
                      </c:when>
                      <c:otherwise>
                        <span class="text-sm text-muted">No action needed</span>
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
  </div>
</div>
</body>
</html>