<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/favicon.png">
  <title>Manage Events &mdash; Event Hive</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="page-wrapper">
  <%@ include file="../includes/sidebar.jsp" %>
  <div class="main-content">

    <div class="top-bar">
      <div class="top-bar-title">Manage Events</div>
      <div class="top-bar-actions">
        <a href="${pageContext.request.contextPath}/admin/events?action=add"
           class="btn btn-primary btn-sm">+ Add Event</a>
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline btn-sm">Sign Out</a>
      </div>
    </div>

    <div class="page-body">
      <c:if test="${param.msg == 'saved'}">
        <div class="alert alert-success mb-16">OK Event saved successfully.</div>
      </c:if>
      <c:if test="${param.msg == 'deleted'}">
        <div class="alert alert-info mb-16">Info Event deleted.</div>
      </c:if>

      <div class="table-wrap">
        <table>
          <thead>
          <tr>
            <th>#</th>
            <th>Title</th>
            <th>Category</th>
            <th>Date</th>
            <th>Venue</th>
            <th>Enrolled</th>
            <th>Status</th>
            <th>Actions</th>
          </tr>
          </thead>
          <tbody>
          <c:choose>
            <c:when test="${empty events}">
              <tr>
                <td colspan="8" class="text-center text-muted" style="padding:40px;">
                  No events yet. <a href="${pageContext.request.contextPath}/admin/events?action=add">Create one</a>
                </td>
              </tr>
            </c:when>
            <c:otherwise>
              <c:forEach var="ev" items="${events}" varStatus="loop">
                <tr>
                  <td class="text-muted text-sm">${loop.count}</td>
                  <td class="fw-600">${ev.title}</td>
                  <td><span class="badge badge-violet">${ev.categoryName}</span></td>
                  <td class="text-sm">${ev.eventDate}</td>
                  <td class="text-sm text-muted">${ev.venue}</td>
                  <td><span class="badge badge-cyan">${ev.enrollmentCount}</span></td>
                  <td>
                    <c:choose>
                      <c:when test="${ev.status == 'upcoming'}"><span class="badge badge-violet">Upcoming</span></c:when>
                      <c:when test="${ev.status == 'ongoing'}"><span class="badge badge-green">Ongoing</span></c:when>
                      <c:when test="${ev.status == 'completed'}"><span class="badge badge-muted">Completed</span></c:when>
                      <c:otherwise><span class="badge badge-rose">Cancelled</span></c:otherwise>
                    </c:choose>
                  </td>
                  <td>
                    <div class="d-flex gap-8">
                      <a href="${pageContext.request.contextPath}/admin/events?action=participants&id=${ev.eventId}"
                         class="btn btn-outline btn-sm">View</a>
                      <a href="${pageContext.request.contextPath}/admin/events?action=edit&id=${ev.eventId}"
                         class="btn btn-outline btn-sm">Edit</a>
                      <a href="${pageContext.request.contextPath}/admin/events?action=delete&id=${ev.eventId}"
                         class="btn btn-danger btn-sm"
                         onclick="return confirm('Delete this event?')">Delete</a>
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
  </div>
</div>
</body>
</html>

