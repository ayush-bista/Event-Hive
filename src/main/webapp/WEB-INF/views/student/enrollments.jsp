<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/favicon.png">
    <title>My Enrollments - Event Hive</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="page-wrapper">
    <%@ include file="../includes/sidebar.jsp" %>
    <div class="main-content">

        <div class="top-bar">
            <div class="top-bar-title">My Enrollments</div>
            <div class="top-bar-actions">
                <a href="${pageContext.request.contextPath}/student/events" class="btn btn-primary btn-sm">Enroll in Event</a>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline btn-sm">Sign Out</a>
            </div>
        </div>

        <div class="page-body">
            <% String flashOk  = (String) session.getAttribute("flashSuccess");
                String flashErr = (String) session.getAttribute("flashError");
                if (flashOk  != null) { session.removeAttribute("flashSuccess"); }
                if (flashErr != null) { session.removeAttribute("flashError"); } %>
            <% if (flashOk  != null) { %><div class="alert alert-success mb-16">OK <%= flashOk %></div><% } %>
            <% if (flashErr != null) { %><div class="alert alert-error mb-16">! <%= flashErr %></div><% } %>

            <div class="section-header">
                <span class="section-title">All Enrollments</span>
                <a href="${pageContext.request.contextPath}/student/events" class="btn btn-outline btn-sm">+ Enroll in Event</a>
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
