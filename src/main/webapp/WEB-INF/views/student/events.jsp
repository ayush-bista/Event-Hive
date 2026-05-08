<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/favicon.png">
    <title>Browse Events &mdash; Event Hive</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="page-wrapper">
    <%@ include file="../includes/sidebar.jsp" %>
    <div class="main-content">

        <div class="top-bar">
            <div class="top-bar-title">Browse Events</div>
            <div class="top-bar-actions">
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline btn-sm">Sign Out</a>
            </div>
        </div>

        <div class="page-body">

            <!-- Flash messages -->
            <% String flashOk  = (String) session.getAttribute("flashSuccess");
                String flashErr = (String) session.getAttribute("flashError");
                if (flashOk  != null) { session.removeAttribute("flashSuccess"); }
                if (flashErr != null) { session.removeAttribute("flashError"); } %>
            <% if (flashOk  != null) { %><div class="alert alert-success mb-16">OK <%= flashOk %></div><% } %>
            <% if (flashErr != null) { %><div class="alert alert-error mb-16">! <%= flashErr %></div><% } %>

            <!-- Search & Filter -->
            <form method="get" action="${pageContext.request.contextPath}/student/events" class="search-bar">
                <div class="search-input-wrap">
                    <span class="search-icon">⌕</span>
                    <input type="text" name="keyword" class="form-control"
                           placeholder="Search events..." value="${keyword}">
                </div>
                <select name="category" class="form-control" style="max-width:180px;">
                    <option value="">All Categories</option>
                    <option value="Academic"  ${category == 'Academic'  ? 'selected' : ''}>Academic</option>
                    <option value="Cultural"  ${category == 'Cultural'  ? 'selected' : ''}>Cultural</option>
                    <option value="Sports"    ${category == 'Sports'    ? 'selected' : ''}>Sports</option>
                    <option value="Technical" ${category == 'Technical' ? 'selected' : ''}>Technical</option>
                    <option value="Social"    ${category == 'Social'    ? 'selected' : ''}>Social</option>
                </select>
                <button type="submit" class="btn btn-primary">Search</button>
                <a href="${pageContext.request.contextPath}/student/events" class="btn btn-outline">Reset</a>
            </form>

            <!-- Events Grid -->
            <c:choose>
                <c:when test="${empty events}">
                    <div class="card text-center" style="padding:60px;">
                        <h3 style="margin-bottom:8px;">No events found</h3>
                        <p class="text-muted">Try a different search or check back later.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="events-grid">
                        <c:forEach var="ev" items="${events}">
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
                                        <c:if test="${not empty ev.eventTime}">
                                            <span>Time: ${ev.eventTime}</span>
                                        </c:if>
                                        <span>Venue: ${ev.venue}</span>
                                        <c:if test="${ev.capacity > 0}">
                                            <span>${ev.capacity - ev.enrollmentCount} seats left</span>
                                        </c:if>
                                        <c:if test="${not empty ev.deadline}">
                                            <span>Deadline: ${ev.deadline}</span>
                                        </c:if>
                                    </div>
                                    <div class="event-card-footer">
                                        <c:choose>
                                            <c:when test="${ev.status == 'upcoming'}"><span class="badge badge-violet">Upcoming</span></c:when>
                                            <c:when test="${ev.status == 'ongoing'}"><span class="badge badge-green">Ongoing</span></c:when>
                                            <c:otherwise><span class="badge badge-muted">${ev.status}</span></c:otherwise>
                                        </c:choose>
                                        <c:if test="${ev.status == 'upcoming' || ev.status == 'ongoing'}">
                                            <form method="post" action="${pageContext.request.contextPath}/student/enroll" style="display:inline">
                                                <input type="hidden" name="action" value="enroll">
                                                <input type="hidden" name="eventId" value="${ev.eventId}">
                                                <button type="submit" class="btn btn-primary btn-sm">Apply</button>
                                            </form>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
    </div>
</div>
</body>
</html>
