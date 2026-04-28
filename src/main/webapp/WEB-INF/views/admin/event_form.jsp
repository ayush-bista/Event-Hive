<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">

  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/favicon.png">
  <title>${empty event ? 'Add Event' : 'Edit Event'} &mdash; Event Hive</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="page-wrapper">
  <%@ include file="../includes/sidebar.jsp" %>
  <div class="main-content">

    <div class="top-bar">
      <div class="top-bar-title">${empty event ? '&#10133; Add New Event' : '&#9998; Edit Event'}</div>
      <div class="top-bar-actions">
        <a href="${pageContext.request.contextPath}/admin/events?action=list"
           class="btn btn-outline btn-sm">&larr; Back</a>
      </div>
    </div>

    <div class="page-body">
      <div class="card" style="max-width:700px;">

        <c:if test="${not empty error}">
          <div class="alert alert-error mb-16">&#9888; ${error}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/admin/events">
          <input type="hidden" name="action" value="save">
          <c:if test="${not empty event}">
            <input type="hidden" name="eventId" value="${event.eventId}">
          </c:if>

          <div class="form-group">
            <label class="form-label">Event Title *</label>
            <input type="text" name="title" class="form-control"
                   value="${event.title}" placeholder="e.g. Annual Tech Fest 2026" required>
          </div>

          <div class="form-group">
            <label class="form-label">Description</label>
            <textarea name="description" class="form-control"
                      placeholder="Describe the event...">${event.description}</textarea>
          </div>

          <div class="form-row">
            <div class="form-group">
              <label class="form-label">Category *</label>
              <select name="categoryId" class="form-control" required>
                <option value="">Select category</option>
                <option value="1" ${event.categoryId == 1 ? 'selected' : ''}>Academic</option>
                <option value="2" ${event.categoryId == 2 ? 'selected' : ''}>Cultural</option>
                <option value="3" ${event.categoryId == 3 ? 'selected' : ''}>Sports</option>
                <option value="4" ${event.categoryId == 4 ? 'selected' : ''}>Technical</option>
                <option value="5" ${event.categoryId == 5 ? 'selected' : ''}>Social</option>
              </select>
            </div>
            <div class="form-group">
              <label class="form-label">Venue *</label>
              <input type="text" name="venue" class="form-control"
                     value="${event.venue}" placeholder="e.g. Main Auditorium" required>
            </div>
          </div>

          <div class="form-row">
            <div class="form-group">
              <label class="form-label">Event Date *</label>
              <input type="date" name="eventDate" class="form-control"
                     value="${event.eventDate}" required>
            </div>
            <div class="form-group">
              <label class="form-label">Event Time</label>
              <input type="time" name="eventTime" class="form-control"
                     value="${event.eventTime}">
            </div>
          </div>

          <div class="form-row">
            <div class="form-group">
              <label class="form-label">Registration Deadline</label>
              <input type="date" name="deadline" class="form-control"
                     value="${event.deadline}">
            </div>
            <div class="form-group">
              <label class="form-label">Capacity <span class="text-muted">(0 = unlimited)</span></label>
              <input type="number" name="capacity" class="form-control"
                     value="${event.capacity != 0 ? event.capacity : ''}" placeholder="0" min="0">
            </div>
          </div>

          <div class="form-group">
            <label class="form-label">Status</label>
            <select name="status" class="form-control">
              <option value="upcoming" ${event.status == 'upcoming' ? 'selected' : ''}>Upcoming</option>
              <option value="ongoing"  ${event.status == 'ongoing'  ? 'selected' : ''}>Ongoing</option>
              <option value="completed"${event.status == 'completed'? 'selected' : ''}>Completed</option>
              <option value="cancelled"${event.status == 'cancelled'? 'selected' : ''}>Cancelled</option>
            </select>
          </div>

          <div class="d-flex gap-12 mt-24">
            <button type="submit" class="btn btn-primary">
              ${empty event ? 'Create Event' : 'Save Changes'}
            </button>
            <a href="${pageContext.request.contextPath}/admin/events?action=list"
               class="btn btn-outline">Cancel</a>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
</body>
</html>

