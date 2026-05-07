<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/favicon.png">
  <title>Pending Approval &mdash; Event Hive</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <style>
    body {
      background: #f5f7fb;
      display: flex; align-items: center; justify-content: center;
      min-height: 100vh;
    }
    .pending-card {
      background: #fff;
      border: 1px solid rgba(15,23,42,0.08);
      border-radius: 20px; padding: 52px 48px;
      text-align: center; max-width: 440px; width: 100%;
      box-shadow: 0 8px 32px rgba(15,23,42,0.1);
    }
    .pending-icon {
      width: 80px; height: 80px; border-radius: 50%;
      background: rgba(245,158,11,0.12);
      display: flex; align-items: center; justify-content: center;
      font-size: 2.2rem; margin: 0 auto 20px;
    }
    .pending-card h2 {
      font-family: 'Manrope', sans-serif;
      font-size: 1.5rem; font-weight: 800; color: #111827; margin-bottom: 12px;
    }
    .pending-card p {
      font-size: 0.92rem; color: #6b7280; line-height: 1.7; margin-bottom: 28px;
    }
    .pending-steps {
      background: #f9fafb; border-radius: 12px; padding: 20px; text-align: left;
      margin-bottom: 28px;
    }
    .pending-steps p {
      font-size: 0.82rem; color: #374151; margin-bottom: 8px; font-weight: 600;
    }
    .pending-step {
      display: flex; align-items: center; gap: 10px;
      font-size: 0.84rem; color: #6b7280; padding: 4px 0;
    }
    .pending-step-num {
      width: 22px; height: 22px; border-radius: 50%;
      background: #7C5CFC; color: #fff;
      display: flex; align-items: center; justify-content: center;
      font-size: 0.7rem; font-weight: 700; flex-shrink: 0;
    }
  </style>
</head>
<body>

<div class="pending-card">
  <div class="pending-icon">⏳</div>
  <h2>Account Pending Approval</h2>
  <p>
    Your registration was received successfully. An administrator
    will review and approve your account shortly.
  </p>

  <div class="pending-steps">
    <p>What happens next?</p>
    <div class="pending-step">
      <span class="pending-step-num">1</span>
      Admin reviews your registration details
    </div>
    <div class="pending-step">
      <span class="pending-step-num">2</span>
      Your account gets approved
    </div>
    <div class="pending-step">
      <span class="pending-step-num">3</span>
      You can log in and start browsing events
    </div>
  </div>

  <a href="${pageContext.request.contextPath}/logout" class="btn btn-primary" style="width:100%; justify-content:center; padding:12px;">
    Back to Login
  </a>
</div>

</body>
</html>
