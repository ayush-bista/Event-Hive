<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/favicon.png">
  <title>Contact Us &mdash; Event Hive</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <style>
    body { background: #f5f7fb; color: #111827; }

    .public-nav {
      background: #fff; border-bottom: 1px solid rgba(15,23,42,0.1);
      padding: 0 48px; height: 64px;
      display: flex; align-items: center; justify-content: space-between;
      position: sticky; top: 0; z-index: 100;
      box-shadow: 0 1px 8px rgba(15,23,42,0.06);
    }
    .public-nav-logo {
      font-family: 'Manrope', sans-serif; font-size: 1.3rem; font-weight: 800;
      background: linear-gradient(135deg, #7C5CFC, #38BDF8);
      -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;
    }

    .contact-hero {
      background: linear-gradient(135deg, #6d28d9 0%, #8b2ee6 50%, #4f46e5 100%);
      color: #fff; text-align: center; padding: 60px 24px 50px;
    }
    .contact-hero h1 {
      font-family: 'Manrope', sans-serif; font-size: clamp(1.8rem, 3.5vw, 2.6rem);
      font-weight: 900; margin-bottom: 12px;
    }
    .contact-hero p { font-size: 1rem; color: rgba(255,255,255,0.8); max-width: 480px; margin: 0 auto; }

    .contact-main {
      max-width: 1000px; margin: 0 auto; padding: 56px 24px 80px;
      display: grid; grid-template-columns: 1.3fr 1fr; gap: 32px;
    }

    /* Left — form */
    .contact-form-card {
      background: #fff;
      border: 1px solid rgba(15,23,42,0.08);
      border-radius: 18px; padding: 40px;
      box-shadow: 0 4px 20px rgba(15,23,42,0.06);
    }
    .contact-form-card h2 {
      font-family: 'Manrope', sans-serif;
      font-size: 1.3rem; font-weight: 800; margin-bottom: 6px; color: #111827;
    }
    .contact-form-card .form-subtitle {
      font-size: 0.87rem; color: #6b7280; margin-bottom: 28px;
    }

    /* Right — info cards */
    .contact-info { display: flex; flex-direction: column; gap: 18px; }
    .info-card {
      background: #fff;
      border: 1px solid rgba(15,23,42,0.08);
      border-radius: 14px; padding: 24px;
      box-shadow: 0 2px 10px rgba(15,23,42,0.05);
      display: flex; align-items: flex-start; gap: 16px;
    }
    .info-icon {
      width: 44px; height: 44px; border-radius: 11px;
      display: flex; align-items: center; justify-content: center;
      font-size: 1.2rem; flex-shrink: 0;
    }
    .info-icon.violet { background: rgba(124,92,252,0.1); }
    .info-icon.gold   { background: rgba(245,158,11,0.1); }
    .info-icon.green  { background: rgba(16,185,129,0.1); }
    .info-card h4 {
      font-family: 'Manrope', sans-serif;
      font-size: 0.9rem; font-weight: 700; color: #111827; margin-bottom: 4px;
    }
    .info-card p { font-size: 0.83rem; color: #6b7280; line-height: 1.6; }

    /* Hours card */
    .hours-card {
      background: linear-gradient(135deg, #7C5CFC, #4f46e5);
      border-radius: 14px; padding: 24px; color: #fff;
    }
    .hours-card h4 {
      font-family: 'Manrope', sans-serif;
      font-size: 0.9rem; font-weight: 700; margin-bottom: 14px;
    }
    .hours-row {
      display: flex; justify-content: space-between;
      font-size: 0.82rem; padding: 6px 0;
      border-bottom: 1px solid rgba(255,255,255,0.15);
    }
    .hours-row:last-child { border-bottom: none; }
    .hours-row span:last-child { font-weight: 600; }

    /* Footer */
    .public-footer {
      background: #fff; border-top: 1px solid rgba(15,23,42,0.08);
      padding: 28px 48px;
      display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 16px;
    }
    .public-footer-logo { font-family:'Manrope',sans-serif; font-size:1.05rem; font-weight:800; color:#111827; }
    .public-footer-links { display:flex; gap:24px; }
    .public-footer-links a { font-size:0.82rem; color:#6b7280; text-decoration:none; }
    .public-footer-links a:hover { color:#7C5CFC; }

    @media (max-width: 800px) {
      .contact-main { grid-template-columns: 1fr; }
      .public-nav { padding: 0 20px; }
      .public-footer { padding: 24px 20px; flex-direction: column; align-items: flex-start; }
    }
  </style>
</head>
<body>

<!-- Navbar -->
<nav class="public-nav">
  <span class="public-nav-logo">⚡ Event Hive</span>
  <div class="d-flex gap-8 align-center">
    <a href="${pageContext.request.contextPath}/" class="btn btn-outline btn-sm">Home</a>
    <a href="${pageContext.request.contextPath}/about" class="btn btn-outline btn-sm">About</a>
    <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-sm">Sign In</a>
  </div>
</nav>

<!-- Hero -->
<div class="contact-hero">
  <h1>Get in Touch</h1>
  <p>Have a question, suggestion, or need help? Send us a message and we'll respond as soon as possible.</p>
</div>

<div class="contact-main">

  <!-- Contact Form -->
  <div class="contact-form-card">
    <h2>Send a Message</h2>
    <div class="form-subtitle">Fill in your details below and we'll get back to you shortly.</div>

    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-error mb-16">⚠ ${error}</div>
    <% } %>
    <% if (request.getAttribute("success") != null) { %>
    <div class="alert alert-success mb-16">✔ ${success}</div>
    <% } %>

    <form method="post" action="${pageContext.request.contextPath}/contact" novalidate>

      <div class="form-group">
        <label class="form-label">Full Name *</label>
        <input type="text" name="senderName" class="form-control"
               placeholder="e.g. Ayush Bista" required
               value="${param.senderName}">
      </div>

      <div class="form-group">
        <label class="form-label">Email Address *</label>
        <input type="email" name="senderEmail" class="form-control"
               placeholder="your@email.com" required
               value="${param.senderEmail}">
      </div>

      <div class="form-group">
        <label class="form-label">Subject *</label>
        <input type="text" name="subject" class="form-control"
               placeholder="What is your message about?" required
               value="${param.subject}">
      </div>

      <div class="form-group">
        <label class="form-label">Message *</label>
        <textarea name="message" class="form-control" rows="5"
                  placeholder="Write your message here (minimum 10 characters)..." required>${param.message}</textarea>
      </div>

      <button type="submit" class="btn btn-primary" style="width:100%; justify-content:center; padding:12px;">
        Send Message
      </button>
    </form>
  </div>

  <!-- Contact Info -->
  <div class="contact-info">

    <div class="info-card">
      <div class="info-icon violet">📍</div>
      <div>
        <h4>Address</h4>
        <p>Itahari International College<br>Itahari-6, Sunsari<br>Province No. 1, Nepal</p>
      </div>
    </div>

    <div class="info-card">
      <div class="info-icon gold">📧</div>
      <div>
        <h4>Email</h4>
        <p>info@iic.edu.np<br>For support: support@eventhive.iic.edu.np</p>
      </div>
    </div>

    <div class="info-card">
      <div class="info-icon green">📞</div>
      <div>
        <h4>Phone</h4>
        <p>+977-025-580900<br>+977-025-580901</p>
      </div>
    </div>

    <div class="hours-card">
      <h4>📅 Office Hours</h4>
      <div class="hours-row"><span>Sunday – Friday</span><span>9:00 AM – 5:00 PM</span></div>
      <div class="hours-row"><span>Saturday</span><span>10:00 AM – 2:00 PM</span></div>
      <div class="hours-row"><span>Public Holidays</span><span>Closed</span></div>
    </div>

  </div>
</div>

<!-- Footer -->
<footer class="public-footer">
  <div>
    <div class="public-footer-logo">⚡ Event Hive</div>
    <div style="font-size:0.75rem; color:#9ca3af; margin-top:2px;">Itahari International College · CS5054NT · TVA Squad</div>
  </div>
  <div class="public-footer-links">
    <a href="${pageContext.request.contextPath}/">Home</a>
    <a href="${pageContext.request.contextPath}/about">About</a>
    <a href="${pageContext.request.contextPath}/login">Sign In</a>
  </div>
  <div style="font-size:0.75rem; color:#9ca3af;">© 2026 TVA Squad</div>
</footer>

</body>
</html>
