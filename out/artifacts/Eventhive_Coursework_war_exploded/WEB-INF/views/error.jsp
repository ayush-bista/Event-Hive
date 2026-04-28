<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">

  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/favicon.png">
  <title>Error &mdash; Event Hive</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-page">
  <div style="text-align:center; position:relative; z-index:1;">
    <div style="font-size:5rem; margin-bottom:16px;">
      <%= "403".equals(request.getParameter("code")) ? "&#128683;" : "&#9888;" %>
    </div>
    <h1 class="hero-title" style="font-size:2rem; margin-bottom:12px;">
      <%= "403".equals(request.getParameter("code")) ? "Access Denied" : "Something went wrong" %>
    </h1>
    <p style="color:var(--text-muted); margin-bottom:28px;">
      <%= "403".equals(request.getParameter("code"))
              ? "You don't have permission to access this page."
              : "An unexpected error occurred. Please try again." %>
    </p>
    <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go Home</a>
  </div>
</div>
</body>
</html>

