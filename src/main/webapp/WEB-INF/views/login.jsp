<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

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
    <div class="alert alert-error">! ${error}</div>
    <% } %>
    <% if (request.getAttribute("success") != null) { %>
    <div class="alert alert-success">OK ${success}</div>
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
        <div class="password-field" style="position:relative; display:block;">
          <input
                  type="password"
                  id="password"
                  name="password"
                  class="form-control"
                  placeholder="Enter your password"
                  required
                  autocomplete="current-password"
          >
          <button type="button" class="password-toggle" data-password-toggle="password"
                  aria-label="Show password" aria-pressed="false"
                  style="position:absolute; right:12px; top:0; bottom:0; width:32px; height:100%; border:0; background:transparent; color:var(--text-muted); cursor:pointer; display:inline-flex; align-items:center; justify-content:center; padding:0;">
            <svg class="icon-eye" viewBox="0 0 24 24" aria-hidden="true">
              <path fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                    d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7z"/>
              <circle cx="12" cy="12" r="3" fill="none" stroke="currentColor" stroke-width="2"/>
            </svg>
            <svg class="icon-eye-off" viewBox="0 0 24 24" aria-hidden="true" style="display:none;">
              <path fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                    d="M3 3l18 18M10.7 5.1A10.7 10.7 0 0112 5c7 0 10 7 10 7a13.2 13.2 0 01-2.2 3.2M6.6 6.6C3.5 8.7 2 12 2 12s3 7 10 7a10.8 10.8 0 004.4-.9M10.6 10.6A3 3 0 0012 15a3 3 0 002.4-1.2"/>
            </svg>
          </button>
        </div>
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

<script>
  document.querySelectorAll('[data-password-toggle]').forEach(function(button) {
    button.addEventListener('click', function() {
      const input = document.getElementById(button.getAttribute('data-password-toggle'));
      if (!input) return;

      const isVisible = input.type === 'text';
      input.type = isVisible ? 'password' : 'text';
      button.querySelector('.icon-eye').style.display = isVisible ? 'block' : 'none';
      button.querySelector('.icon-eye-off').style.display = isVisible ? 'none' : 'block';
      button.classList.toggle('is-visible', !isVisible);
      button.setAttribute('aria-pressed', String(!isVisible));
      button.setAttribute('aria-label', isVisible ? 'Show password' : 'Hide password');
    });
  });
</script>

</body>
</html>
