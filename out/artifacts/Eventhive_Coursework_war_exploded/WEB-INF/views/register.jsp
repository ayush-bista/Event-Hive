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
    <div class="alert alert-error">&#9888; ${error}</div>
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
            <input type="text" name="course" class="form-control" placeholder="e.g. BSc Computer Science">
          </div>
          <div class="form-group">
            <label class="form-label">Level</label>
            <select name="level" class="form-control">
              <option value="">Select level</option>
              <option>Level 4</option>
              <option>Level 5</option>
              <option>Level 6</option>
              <option>Masters</option>
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
          <input type="password" name="password" id="pass" class="form-control"
                 placeholder="Min 8 chars, 1 upper, 1 number, 1 special" required>
        </div>
        <div class="form-group">
          <label class="form-label">Confirm Password *</label>
          <input type="password" name="confirmPassword" id="confirm" class="form-control"
                 placeholder="Repeat password" required>
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

