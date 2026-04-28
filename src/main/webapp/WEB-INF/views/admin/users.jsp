<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">

  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/favicon.png">
  <title>Manage Students &mdash; Event Hive</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="page-wrapper">
  <%@ include file="../includes/sidebar.jsp" %>
  <div class="main-content">

    <div class="top-bar">
      <div class="top-bar-title">&#128101; Manage Students</div>
      <div class="top-bar-actions">
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline btn-sm">Sign Out</a>
      </div>
    </div>

    <div class="page-body">
      <div class="table-wrap">
        <table>
          <thead>
          <tr>
            <th>#</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Course</th>
            <th>Registered</th>
            <th>Status</th>
            <th>Actions</th>
          </tr>
          </thead>
          <tbody>
          <c:choose>
            <c:when test="${empty students}">
              <tr><td colspan="8" class="text-center text-muted" style="padding:40px;">No students registered yet.</td></tr>
            </c:when>
            <c:otherwise>
              <c:forEach var="s" items="${students}" varStatus="loop">
                <tr>
                  <td class="text-muted text-sm">${loop.count}</td>
                  <td>
                    <div class="d-flex align-center gap-8">
                      <div class="user-avatar" style="width:28px;height:28px;font-size:0.75rem;">
                          ${s.fullName.substring(0,1).toUpperCase()}
                      </div>
                      <span class="fw-600">${s.fullName}</span>
                    </div>
                  </td>
                  <td class="text-sm">${s.email}</td>
                  <td class="text-sm">${s.phone}</td>
                  <td class="text-sm text-muted">${empty s.course ? '&mdash;' : s.course}</td>
                  <td class="text-sm text-muted">${s.createdAt}</td>
                  <td>
                    <c:choose>
                      <c:when test="${s.isApproved == 1}">
                        <span class="badge badge-green">Approved</span>
                      </c:when>
                      <c:otherwise>
                        <span class="badge badge-amber">Pending</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td>
                    <div class="d-flex gap-8">
                      <c:if test="${s.isApproved != 1}">
                        <form method="post" action="${pageContext.request.contextPath}/admin/users" style="display:inline">
                          <input type="hidden" name="action" value="approve">
                          <input type="hidden" name="userId" value="${s.userId}">
                          <button type="submit" class="btn btn-success btn-sm">Approve</button>
                        </form>
                      </c:if>
                      <form method="post" action="${pageContext.request.contextPath}/admin/users" style="display:inline">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="userId" value="${s.userId}">
                        <button type="submit" class="btn btn-danger btn-sm"
                                onclick="return confirm('Delete this student?')">Delete</button>
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
  </div>
</div>
</body>
</html>