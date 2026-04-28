<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">

  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/favicon.png">
  <title>Login &mdash; Event Hive</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<div class="auth-page">
  <div class="auth-card">

    <div class="auth-logo">
      <div class="logo-text">Event Hive</div>
      <div class="logo-tagline">College Event Management System</div>
    </div>

    <h2 class="auth-title">Welcome back</h2>
    <p class="auth-subtitle">Sign in to your account to continue</p>

    <!-- Flash messages -->
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-error">&#9888; ${error}</div>
    <% } %>
    <% if (request.getAttribute("success") != null) { %>
    <div class="alert alert-success">&#10004; ${success}</div>
    <% } %>

    <form method="post" action="${pageContext.request.contextPath}/login" novalidate>

      <div class="form-group">
        <label class="form-label" for="email">Email Address</label>
        <input
                type="email"
                id="email"
                name="email"
                class="form-control"
                placeholder="you@college.edu"
                value="<%= request.getCookies() != null ? getCookieValue(request.getCookies(), "eh_email") : "" %>"
                required
                autocomplete="email"
        >
      </div>

      <div class="form-group">
        <label class="form-label" for="password">Password</label>
        <input
                type="password"
                id="password"
                name="password"
                class="form-control"
                placeholder="Enter your password"
                required
                autocomplete="current-password"
        >
      </div>

      <div class="d-flex justify-between align-center mb-16">
        <label class="d-flex align-center gap-8" style="font-size:0.82rem; color:var(--text-muted); cursor:pointer;">
          <input type="checkbox" name="rememberMe" style="accent-color:var(--violet);">
          Remember me
        </label>
      </div>

      <button type="submit" class="btn btn-primary btn-lg" style="width:100%; justify-content:center;">
        Sign In
      </button>
    </form>

    <a href="${pageContext.request.contextPath}/" class="btn btn-outline btn-lg mt-16" style="width:100%; justify-content:center;">
      Go to landing page
    </a>

    <p class="text-center text-sm mt-24" style="color:var(--text-muted);">
      Don't have an account?
      <a href="${pageContext.request.contextPath}/register" style="color:var(--violet-lt); font-weight:600;">
        Register here
      </a>
    </p>

  </div>
</div>

<%!
  // Helper to read a specific cookie value
  private String getCookieValue(jakarta.servlet.http.Cookie[] cookies, String name) {
    for (jakarta.servlet.http.Cookie c : cookies) {
      if (name.equals(c.getName())) return c.getValue();
    }
    return "";
  }
%>

</body>
</html>

