<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Pending Approval — Event Hive</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-page">
  <div style="text-align:center; position:relative; z-index:1;">
    <div style="font-size:4rem; margin-bottom:16px;">⏳</div>
    <h2 style="font-family:'Sora',sans-serif; font-size:1.6rem; margin-bottom:12px;">
      Account Pending Approval
    </h2>
    <p style="color:var(--text-muted); margin-bottom:28px; max-width:380px;">
      Your registration is under review. An admin will approve
      your account shortly. Please check back later.
    </p>
    <a href="${pageContext.request.contextPath}/logout" class="btn btn-primary">
      Back to Login
    </a>
  </div>
</div>
</body>
</html>