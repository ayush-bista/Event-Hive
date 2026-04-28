<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">

  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/favicon.png">
  <title>Register &mdash; Event Hive</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<div class="auth-page" style="padding: 40px 20px; align-items: flex-start;">
  <div class="auth-card" style="max-width:560px; margin: auto;">

    <div class="auth-logo">
      <div class="logo-text">Event Hive</div>
      <div class="logo-tagline">Create your student account</div>
    </div>

    <h2 class="auth-title">Student Registration</h2>
    <p class="auth-subtitle">Fill in your details. Admin approval required before login.</p>

    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-error">! ${error}</div>
    <% } %>

    <form method="post" action="${pageContext.request.contextPath}/register" novalidate>

      <div class="form-row">
        <div class="form-group">
          <label class="form-label">Full Name *</label>
          <input type="text" name="fullName" class="form-control"
                 placeholder="e.g. Ayush Bista" required>
        </div>
        <div class="form-group">
          <label class="form-label">Date of Birth *</label>
          <input type="date" name="dateOfBirth" class="form-control" required>
        </div>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label class="form-label">Email Address *</label>
          <input type="email" name="email" class="form-control"
                 placeholder="you@college.edu" required>
        </div>
        <div class="form-group">
          <label class="form-label">Phone Number *</label>
          <input type="text" name="phone" class="form-control"
                 placeholder="10-digit number" maxlength="10" required>
        </div>
      </div>

      <div style="background:rgba(255,255,255,0.04); border:1px solid var(--border);
                  border-radius:12px; padding:18px; margin-bottom:18px;">
        <p class="text-sm fw-600 mb-16" style="color:var(--text-muted); text-transform:uppercase;
           letter-spacing:0.06em; font-size:0.7rem;">Academic Information</p>
        <div class="form-row">
          <div class="form-group">
            <label class="form-label">Course</label>
            <select name="course" class="form-control">
              <option value="">Select course</option>
              <option>BSc (Hons) Computing</option>
              <option>BA (Hons) Business Administration</option>
            </select>
          </div>
          <div class="form-group">
            <label class="form-label">Semester</label>
            <select name="level" class="form-control">
              <option value="">Select semester</option>
              <option>Semester 1</option>
              <option>Semester 2</option>
              <option>Semester 3</option>
              <option>Semester 4</option>
              <option>Semester 5</option>
              <option>Semester 6</option>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="form-label">Year</label>
          <select name="year" class="form-control">
            <option value="">Select year</option>
            <option value="1">Year 1</option>
            <option value="2">Year 2</option>
            <option value="3">Year 3</option>
            <option value="4">Year 4</option>
          </select>
        </div>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label class="form-label">Password *</label>
          <div class="password-field" style="position:relative; display:block;">
            <input type="password" name="password" id="pass" class="form-control"
                   placeholder="Min 8 chars, 1 upper, 1 number, 1 special" required>
            <button type="button" class="password-toggle" data-password-toggle="pass"
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
        <div class="form-group">
          <label class="form-label">Confirm Password *</label>
          <div class="password-field" style="position:relative; display:block;">
            <input type="password" name="confirmPassword" id="confirm" class="form-control"
                   placeholder="Repeat password" required>
            <button type="button" class="password-toggle" data-password-toggle="confirm"
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
      </div>

      <button type="submit" class="btn btn-primary btn-lg" style="width:100%; justify-content:center;">
        Create Account
      </button>
    </form>

    <p class="text-center text-sm mt-24" style="color:var(--text-muted);">
      Already have an account?
      <a href="${pageContext.request.contextPath}/login" style="color:var(--violet-lt); font-weight:600;">
        Sign in
      </a>
    </p>

  </div>
</div>

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

  document.querySelector('form').addEventListener('submit', function(e) {
    const pass    = document.getElementById('pass').value;
    const confirm = document.getElementById('confirm').value;
    if (pass !== confirm) {
      e.preventDefault();
      alert('Passwords do not match!');
    }
  });
</script>

</body>
</html>

