<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/favicon.png">
  <title>About - Event Hive</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <style>
    .student-about-page { background: #f5f7fb; }
    .student-about-wrap { max-width: 1040px; margin: 0 auto; padding: 6px 6px 18px; }
    .student-about-hero {
      background: linear-gradient(135deg, #6d28d9 0%, #8b2ee6 50%, #4f46e5 100%);
      border-radius: 14px;
      padding: 36px 28px;
      color: #fff;
      margin-bottom: 16px;
    }
    .student-about-hero h1 {
      font-family: 'Manrope', sans-serif;
      font-size: clamp(1.7rem, 2.8vw, 2.4rem);
      font-weight: 900;
      margin-bottom: 8px;
      line-height: 1.2;
    }
    .student-about-hero p { color: rgba(255,255,255,0.85); line-height: 1.7; max-width: 760px; }
    .student-about-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 14px;
      margin-bottom: 14px;
    }
    .student-about-card {
      background: #fff;
      border: 1px solid rgba(15,23,42,0.08);
      border-radius: 12px;
      padding: 20px;
      box-shadow: 0 2px 10px rgba(15,23,42,0.05);
    }
    .student-about-card h3 {
      font-family: 'Manrope', sans-serif;
      font-size: 1.02rem;
      font-weight: 800;
      color: #111827;
      margin-bottom: 8px;
    }
    .student-about-card p { color: #6b7280; font-size: 0.9rem; line-height: 1.65; }
    .section-heading {
      font-family: 'Manrope', sans-serif;
      font-size: 1.45rem;
      font-weight: 800;
      color: #111827;
      margin: 2px 0 4px;
    }
    .section-sub {
      font-size: 0.9rem;
      color: #6b7280;
      margin-bottom: 12px;
    }
    .team-grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 14px;
      margin-bottom: 14px;
    }
    .team-card {
      background: #fff;
      border: 1px solid rgba(15,23,42,0.08);
      border-radius: 12px;
      padding: 18px;
      text-align: center;
      box-shadow: 0 2px 10px rgba(15,23,42,0.05);
    }
    .team-avatar {
      width: 62px;
      height: 62px;
      border-radius: 50%;
      margin: 0 auto 10px;
      overflow: hidden;
      display: flex;
      align-items: center;
      justify-content: center;
      background: linear-gradient(135deg, #7C5CFC, #38BDF8);
      color: #fff;
      font-family: 'Manrope', sans-serif;
      font-size: 1.35rem;
      font-weight: 800;
    }
    .team-avatar img { width: 100%; height: 100%; object-fit: cover; display: block; }
    .team-name {
      font-family: 'Manrope', sans-serif;
      font-size: 0.95rem;
      font-weight: 800;
      color: #111827;
    }
    .student-about-college {
      background: #fff;
      border: 1px solid rgba(15,23,42,0.08);
      border-radius: 12px;
      padding: 20px;
      display: grid;
      grid-template-columns: 1fr auto;
      gap: 16px;
      align-items: center;
    }
    .student-about-college h3 {
      font-family: 'Manrope', sans-serif;
      font-size: 1.1rem;
      font-weight: 800;
      margin-bottom: 8px;
      color: #111827;
    }
    .student-about-college p { color: #6b7280; font-size: 0.9rem; line-height: 1.7; }
    .student-about-college img {
      width: 180px;
      max-width: 100%;
      aspect-ratio: 3 / 4;
      object-fit: cover;
      border-radius: 10px;
      border: 1px solid rgba(15,23,42,0.08);
    }
    @media (max-width: 900px) {
      .student-about-grid { grid-template-columns: 1fr; }
      .team-grid { grid-template-columns: 1fr 1fr; }
      .student-about-college { grid-template-columns: 1fr; }
    }
    @media (max-width: 600px) {
      .team-grid { grid-template-columns: 1fr; }
    }
  </style>
</head>
<body class="student-about-page">
<div class="page-wrapper">
  <%@ include file="../includes/sidebar.jsp" %>
  <div class="main-content">
    <div class="top-bar">
      <div class="top-bar-title">About</div>
      <div class="top-bar-actions">
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline btn-sm">Sign Out</a>
      </div>
    </div>

    <div class="page-body">
      <div class="student-about-wrap">
        <div class="student-about-hero">
          <h1>About Event Hive</h1>
          <p>A modern, web-based college event management system built to simplify how students discover, register, and engage with campus events.</p>
        </div>

        <div class="student-about-grid">
          <div class="student-about-card">
            <h3>Our Mission</h3>
            <p>To create a centralized, efficient, and user-friendly platform that connects students with meaningful college events, making participation easier and transparent.</p>
          </div>
          <div class="student-about-card">
            <h3>Our Vision</h3>
            <p>To build a campus culture where every student is informed, engaged, and empowered to participate in academic, cultural, sports, and technical events.</p>
          </div>
        </div>

        <div class="section-heading">Meet the Team</div>
        <div class="section-sub">TVA Squad</div>
        <div class="team-grid">
          <div class="team-card">
            <div class="team-avatar">
              <img src="${pageContext.request.contextPath}/assets/team/ayush.jpg" alt="Ayush Bista" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
              <span style="display:none; width:100%; height:100%; align-items:center; justify-content:center;">A</span>
            </div>
            <div class="team-name">Ayush Bista</div>
          </div>
          <div class="team-card">
            <div class="team-avatar">
              <img src="${pageContext.request.contextPath}/assets/team/suprim.jpg" alt="Suprim Giri" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
              <span style="display:none; width:100%; height:100%; align-items:center; justify-content:center;">S</span>
            </div>
            <div class="team-name">Suprim Giri</div>
          </div>
          <div class="team-card">
            <div class="team-avatar">
              <img src="${pageContext.request.contextPath}/assets/team/darsana.jpg" alt="Darsana Bhandari" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
              <span style="display:none; width:100%; height:100%; align-items:center; justify-content:center;">D</span>
            </div>
            <div class="team-name">Darsana Bhandari</div>
          </div>
          <div class="team-card">
            <div class="team-avatar">
              <img src="${pageContext.request.contextPath}/assets/team/akisha.jpg" alt="Akisha Bhujel" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
              <span style="display:none; width:100%; height:100%; align-items:center; justify-content:center;">A</span>
            </div>
            <div class="team-name">Akisha Bhujel</div>
          </div>
        </div>

        <div class="student-about-college">
          <div>
            <h3>Itahari International College</h3>
            <p>Itahari International College (IIC) is affiliated with London Metropolitan University, UK. This project was developed as part of the CS5054NT Advanced Programming and Technologies module, Spring Semester 2026.</p>
          </div>
          <img src="${pageContext.request.contextPath}/assets/iic-college-building.png" alt="Itahari International College">
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
