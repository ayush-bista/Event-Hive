<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/favicon.png">
  <title>Contact - Event Hive</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <script src="https://code.iconify.design/iconify-icon/2.1.0/iconify-icon.min.js"></script>
  <style>
    .student-contact-page { background: #f5f7fb; }
    .student-contact-wrap { max-width: 1240px; margin: 0 auto; padding: 6px 6px 18px; }
    .student-contact-grid {
      display: grid;
      grid-template-columns: 1.2fr 0.9fr;
      gap: 18px;
    }
    .student-contact-card {
      background: #fff;
      border: 1px solid rgba(15,23,42,0.08);
      border-radius: 22px;
      padding: 34px;
      box-shadow: 0 4px 20px rgba(15,23,42,0.06);
    }
    .student-contact-card h2 {
      font-family: 'Manrope', sans-serif;
      font-size: 1.3rem;
      font-weight: 800;
      color: #111827;
      margin-bottom: 10px;
    }
    .student-contact-sub { font-size: 0.87rem; color: #6b7280; margin-bottom: 18px; }
    .student-contact-info {
      display: flex;
      flex-direction: column;
      gap: 14px;
      min-width: 0;
    }
    .student-info-card {
      background: #fff;
      border: 1px solid rgba(15,23,42,0.08);
      border-radius: 22px;
      padding: 24px;
      display: flex;
      align-items: flex-start;
      gap: 16px;
      box-shadow: 0 2px 10px rgba(15,23,42,0.05);
    }
    .student-info-icon {
      width: 74px;
      height: 74px;
      border-radius: 16px;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-shrink: 0;
      color: #111827;
    }
    .student-info-icon iconify-icon { font-size: 2rem; line-height: 1; }
    .student-info-icon.violet { background: rgba(124,92,252,0.12); }
    .student-info-icon.gold   { background: rgba(245,158,11,0.15); }
    .student-info-icon.green  { background: rgba(16,185,129,0.15); }
    .student-info-card h4 {
      font-family: 'Manrope', sans-serif;
      font-size: 0.9rem;
      font-weight: 800;
      color: #111827;
      margin-bottom: 8px;
    }
    .student-info-card p {
      font-size: 0.83rem;
      color: #6b7280;
      line-height: 1.55;
      margin: 0;
    }
    .hours-card {
      background: linear-gradient(135deg, #7C5CFC, #4f46e5);
      border-radius: 22px;
      padding: 26px 24px;
      color: #fff;
      box-shadow: 0 8px 28px rgba(79,70,229,0.2);
    }
    .hours-head {
      display: inline-flex;
      align-items: center;
      gap: 10px;
      font-family: 'Manrope', sans-serif;
      font-size: 0.9rem;
      font-weight: 800;
      margin-bottom: 18px;
    }
    .hours-head iconify-icon { font-size: 1rem; line-height: 1; }
    .hours-row {
      display: flex;
      justify-content: space-between;
      gap: 12px;
      font-size: 0.82rem;
      padding: 8px 0;
      border-bottom: 1px solid rgba(255,255,255,0.2);
    }
    .hours-row:last-child { border-bottom: none; }
    .hours-row span:last-child { font-weight: 700; }
    .student-contact-card .form-label {
      font-size: 0.86rem;
      color: #334e6e;
      margin-bottom: 8px;
      font-weight: 700;
    }
    .student-contact-card .form-control {
      min-height: 68px;
      border-radius: 18px;
      font-size: 0.84rem;
      padding: 14px 20px;
      border-color: rgba(15,23,42,0.12);
    }
    .student-contact-card textarea.form-control {
      min-height: 182px;
      resize: vertical;
    }
    .student-contact-submit {
      width: 100%;
      justify-content: center;
      padding: 16px;
      border-radius: 16px;
      font-size: 0.95rem;
      font-weight: 700;
      margin-top: 6px;
    }
    @media (max-width: 900px) {
      .student-contact-grid { grid-template-columns: 1fr; }
      .student-contact-card { padding: 22px; border-radius: 16px; }
      .student-info-card { border-radius: 16px; padding: 18px; }
      .student-info-icon { width: 56px; height: 56px; border-radius: 12px; }
      .hours-card { border-radius: 16px; padding: 18px; }
      .student-contact-card h2,
      .student-contact-sub,
      .student-info-card h4,
      .student-info-card p,
      .hours-head,
      .hours-row,
      .student-contact-card .form-label,
      .student-contact-card .form-control,
      .student-contact-submit { font-size: 0.9rem; }
    }
  </style>
</head>
<body class="student-contact-page">
<div class="page-wrapper">
  <%@ include file="../includes/sidebar.jsp" %>
  <div class="main-content">
    <div class="top-bar">
      <div class="top-bar-title">Contact</div>
      <div class="top-bar-actions">
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline btn-sm">Sign Out</a>
      </div>
    </div>

    <div class="page-body">
      <div class="student-contact-wrap">
        <div class="student-contact-grid">
          <div class="student-contact-card">
            <h2>Send a Message</h2>
            <div class="student-contact-sub">Fill in your details below and we will get back to you shortly.</div>

            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error mb-16">! ${error}</div>
            <% } %>
            <% if (request.getAttribute("success") != null) { %>
            <div class="alert alert-success mb-16">OK ${success}</div>
            <% } %>

            <form method="post" action="${pageContext.request.contextPath}/student/contact" novalidate>
              <div class="form-group">
                <label class="form-label">Full Name *</label>
                <input type="text" name="senderName" class="form-control" placeholder="e.g. Ayush Bista" required value="${param.senderName}">
              </div>

              <div class="form-group">
                <label class="form-label">Email Address *</label>
                <input type="email" name="senderEmail" class="form-control" placeholder="your@email.com" required value="${param.senderEmail}">
              </div>

              <div class="form-group">
                <label class="form-label">Subject *</label>
                <input type="text" name="subject" class="form-control" placeholder="What is your message about?" required value="${param.subject}">
              </div>

              <div class="form-group">
                <label class="form-label">Message *</label>
                <textarea name="message" class="form-control" rows="5" placeholder="Write your message here (minimum 10 characters)..." required>${param.message}</textarea>
              </div>

              <button type="submit" class="btn btn-primary student-contact-submit">
                Send Message
              </button>
            </form>
          </div>

          <div class="student-contact-info">
            <div class="student-info-card">
              <div class="student-info-icon violet"><iconify-icon icon="tabler:map-pin"></iconify-icon></div>
              <div>
                <h4>Address</h4>
                <p>Itahari International College<br>Sundarharaincha-10, Dulari<br>Province No. 1, Nepal</p>
              </div>
            </div>

            <div class="student-info-card">
              <div class="student-info-icon gold"><iconify-icon icon="tabler:mail"></iconify-icon></div>
              <div>
                <h4>Email</h4>
                <p>email@iic.edu.np<br>For support: support@eventhive.iic.edu.np</p>
              </div>
            </div>

            <div class="student-info-card">
              <div class="student-info-icon green"><iconify-icon icon="tabler:phone"></iconify-icon></div>
              <div>
                <h4>Phone</h4>
                <p>+977-9812345678<br>+977-9801234567</p>
              </div>
            </div>

            <div class="hours-card">
              <div class="hours-head"><iconify-icon icon="tabler:clock-hour-4"></iconify-icon>Office Hours</div>
              <div class="hours-row"><span>Sunday – Friday</span><span>9:00 AM – 5:00 PM</span></div>
              <div class="hours-row"><span>Saturday</span><span>10:00 AM – 2:00 PM</span></div>
              <div class="hours-row"><span>Public Holidays</span><span>Closed</span></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
