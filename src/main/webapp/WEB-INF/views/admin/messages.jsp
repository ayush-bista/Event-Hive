<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/favicon.png">
  <title>Messages &mdash; Event Hive</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <style>
    .message-row.unread { background: rgba(124,92,252,0.04); }
    .message-row.unread td:first-child { border-left: 3px solid #7C5CFC; }
    .unread-dot {
      display: inline-block; width: 8px; height: 8px;
      border-radius: 50%; background: #7C5CFC;
      margin-right: 6px; vertical-align: middle;
    }
    .message-body-cell {
      max-width: 320px; overflow: hidden;
      text-overflow: ellipsis; white-space: nowrap;
      color: #6b7280; font-size: 0.84rem;
    }
  </style>
</head>
<body>
<div class="page-wrapper">
  <%@ include file="../includes/sidebar.jsp" %>
  <div class="main-content">

    <div class="top-bar">
      <div class="top-bar-title">
        Messages
        <c:if test="${unreadCount > 0}">
          <span class="badge badge-violet" style="margin-left:10px;">${unreadCount} new</span>
        </c:if>
      </div>
      <div class="top-bar-actions">
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline btn-sm">Sign Out</a>
      </div>
    </div>

    <div class="page-body">
      <c:if test="${not empty error}">
        <div class="alert alert-error mb-16">⚠ ${error}</div>
      </c:if>

      <div class="table-wrap">
        <table>
          <thead>
          <tr>
            <th>#</th>
            <th>From</th>
            <th>Email</th>
            <th>Subject</th>
            <th>Message Preview</th>
            <th>Received</th>
            <th>Actions</th>
          </tr>
          </thead>
          <tbody>
          <c:choose>
            <c:when test="${empty messages}">
              <tr>
                <td colspan="7" class="text-center text-muted" style="padding:40px;">
                  No messages yet. When visitors submit the contact form, messages appear here.
                </td>
              </tr>
            </c:when>
            <c:otherwise>
              <c:forEach var="msg" items="${messages}" varStatus="loop">
                <tr class="message-row ${msg.isRead == 0 ? 'unread' : ''}">
                  <td class="text-sm text-muted">${loop.count}</td>
                  <td class="fw-600">
                    <c:if test="${msg.isRead == 0}">
                      <span class="unread-dot"></span>
                    </c:if>
                      ${msg.senderName}
                  </td>
                  <td class="text-sm">${msg.senderEmail}</td>
                  <td class="fw-600 text-sm">${msg.subject}</td>
                  <td class="message-body-cell">${msg.message}</td>
                  <td class="text-sm text-muted">${msg.sentAt}</td>
                  <td>
                    <div class="d-flex gap-8">
                      <c:if test="${msg.isRead == 0}">
                        <form method="post" action="${pageContext.request.contextPath}/admin/messages" style="display:inline">
                          <input type="hidden" name="action" value="markRead">
                          <input type="hidden" name="id" value="${msg.messageId}">
                          <button type="submit" class="btn btn-success btn-sm">Mark Read</button>
                        </form>
                      </c:if>
                      <form method="post" action="${pageContext.request.contextPath}/admin/messages" style="display:inline"
                            onsubmit="return confirm('Delete this message?')">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="${msg.messageId}">
                        <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                      </form>
                    </div>
                  </td>
                </tr>
                <!-- Message expand row -->
                <tr>
                  <td colspan="7" style="padding:0 16px 12px; background:${msg.isRead == 0 ? 'rgba(124,92,252,0.02)' : '#fff'};">
                    <div style="font-size:0.85rem; color:#374151; line-height:1.65;
                            background:#f9fafb; border-radius:8px; padding:12px 16px;
                            border-left:3px solid ${msg.isRead == 0 ? '#7C5CFC' : '#e5e7eb'};">
                        ${msg.message}
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
