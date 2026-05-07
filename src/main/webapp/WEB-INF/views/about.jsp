<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/favicon.png">
  <title>About Us &mdash; Event Hive</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <style>
    /* ── About page specific styles ── */
    body { background: #f5f7fb; color: #111827; }

    .public-nav {
      background: #fff;
      border-bottom: 1px solid rgba(15,23,42,0.1);
      padding: 0 48px;
      height: 64px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      position: sticky; top: 0; z-index: 100;
      box-shadow: 0 1px 8px rgba(15,23,42,0.06);
    }
    .public-nav-logo {
      font-family: 'Manrope', sans-serif;
      font-size: 1.3rem; font-weight: 800;
      background: linear-gradient(135deg, #7C5CFC, #38BDF8);
      -webkit-background-clip: text; -webkit-text-fill-color: transparent;
      background-clip: text;
    }
    .public-nav-links { display: flex; align-items: center; gap: 12px; }

    .about-hero {
      background: linear-gradient(135deg, #6d28d9 0%, #8b2ee6 50%, #4f46e5 100%);
      color: #fff;
      text-align: center;
      padding: 80px 24px 70px;
    }
    .about-hero-badge {
      display: inline-flex; align-items: center; gap: 8px;
      background: rgba(255,255,255,0.15);
      border: 1px solid rgba(255,255,255,0.3);
      border-radius: 100px; padding: 6px 18px;
      font-size: 0.78rem; font-weight: 600;
      letter-spacing: 0.05em; margin-bottom: 20px;
      color: rgba(255,255,255,0.9);
    }
    .about-hero h1 {
      font-family: 'Manrope', sans-serif;
      font-size: clamp(2rem, 4vw, 3rem);
      font-weight: 900; line-height: 1.15;
      margin-bottom: 16px;
    }
    .about-hero p {
      font-size: 1.05rem; color: rgba(255,255,255,0.8);
      max-width: 560px; margin: 0 auto; line-height: 1.75;
    }

    .about-main {
      max-width: 1100px; margin: 0 auto; padding: 60px 24px 80px;
    }

    /* Mission section */
    .mission-grid {
      display: grid; grid-template-columns: 1fr 1fr; gap: 32px;
      margin-bottom: 56px;
    }
    .mission-card {
      background: #fff;
      border: 1px solid rgba(15,23,42,0.08);
      border-radius: 18px; padding: 36px;
      box-shadow: 0 4px 20px rgba(15,23,42,0.06);
    }
    .mission-icon {
      width: 52px; height: 52px; border-radius: 13px;
      display: flex; align-items: center; justify-content: center;
      font-size: 1.4rem; margin-bottom: 18px;
    }
    .mission-icon.violet { background: rgba(124,92,252,0.12); }
    .mission-icon.gold   { background: rgba(245,158,11,0.12); }
    .mission-card h3 {
      font-family: 'Manrope', sans-serif;
      font-size: 1.15rem; font-weight: 800; margin-bottom: 10px; color: #111827;
    }
    .mission-card p { font-size: 0.92rem; color: #6b7280; line-height: 1.72; }

    /* Stats bar */
    .stats-bar {
      background: linear-gradient(135deg, #7C5CFC, #4f46e5);
      border-radius: 18px; padding: 36px;
      display: grid; grid-template-columns: repeat(4, 1fr);
      gap: 24px; text-align: center; margin-bottom: 56px;
      color: #fff;
    }
    .stats-bar-num {
      font-family: 'Manrope', sans-serif;
      font-size: 2.4rem; font-weight: 900; line-height: 1;
      margin-bottom: 6px;
    }
    .stats-bar-label { font-size: 0.82rem; color: rgba(255,255,255,0.75); font-weight: 500; }

    /* Team section */
    .section-heading {
      font-family: 'Manrope', sans-serif;
      font-size: 1.6rem; font-weight: 800; color: #111827;
      margin-bottom: 6px;
    }
    .section-sub {
      font-size: 0.92rem; color: #6b7280; margin-bottom: 32px;
    }

    .team-grid {
      display: grid; grid-template-columns: repeat(4, 1fr);
      gap: 20px; margin-bottom: 56px;
    }
    .team-card {
      background: #fff;
      border: 1px solid rgba(15,23,42,0.08);
      border-radius: 16px; padding: 28px 20px; text-align: center;
      box-shadow: 0 4px 18px rgba(15,23,42,0.06);
      transition: transform 0.22s, box-shadow 0.22s;
    }
    .team-card:hover { transform: translateY(-4px); box-shadow: 0 12px 32px rgba(124,92,252,0.14); }
    .team-avatar {
      width: 70px; height: 70px; border-radius: 50%;
      background: linear-gradient(135deg, #7C5CFC, #38BDF8);
      display: flex; align-items: center; justify-content: center;
      font-family: 'Manrope', sans-serif;
      font-size: 1.6rem; font-weight: 800; color: #fff;
      margin: 0 auto 14px;
    }
    .team-card .team-name {
      font-family: 'Manrope', sans-serif;
      font-size: 1rem; font-weight: 800; color: #111827; margin-bottom: 4px;
    }
    .team-card .team-role {
      font-size: 0.78rem; color: #7C5CFC; font-weight: 600;
      letter-spacing: 0.04em; text-transform: uppercase; margin-bottom: 8px;
    }
    .team-card .team-id {
      font-size: 0.75rem; color: #9ca3af;
    }

    /* Features grid */
    .features-grid-about {
      display: grid; grid-template-columns: repeat(3, 1fr);
      gap: 18px; margin-bottom: 56px;
    }
    .feature-item {
      background: #fff;
      border: 1px solid rgba(15,23,42,0.08);
      border-radius: 14px; padding: 24px;
      box-shadow: 0 2px 10px rgba(15,23,42,0.05);
    }
    .feature-item-icon { font-size: 1.5rem; margin-bottom: 12px; }
    .feature-item h4 {
      font-family: 'Manrope', sans-serif;
      font-size: 0.95rem; font-weight: 700; color: #111827; margin-bottom: 6px;
    }
    .feature-item p { font-size: 0.85rem; color: #6b7280; line-height: 1.65; }

    /* College info */
    .college-card {
      background: #fff;
      border: 1px solid rgba(15,23,42,0.08);
      border-radius: 18px; padding: 40px;
      display: grid; grid-template-columns: 1fr auto;
      align-items: center; gap: 32px;
      box-shadow: 0 4px 18px rgba(15,23,42,0.06);
    }
    .college-card h3 {
      font-family: 'Manrope', sans-serif;
      font-size: 1.4rem; font-weight: 800; color: #111827; margin-bottom: 10px;
    }
    .college-card p { font-size: 0.92rem; color: #6b7280; line-height: 1.72; margin-bottom: 20px; }
    .college-badge {
      background: rgba(124,92,252,0.08);
      border: 1px solid rgba(124,92,252,0.2);
      border-radius: 100px; padding: 4px 14px;
      font-size: 0.76rem; font-weight: 600; color: #7C5CFC;
      display: inline-flex; align-items: center; gap: 6px;
    }

    /* Footer */
    .public-footer {
      background: #fff;
      border-top: 1px solid rgba(15,23,42,0.08);
      padding: 28px 48px;
      display: flex; align-items: center; justify-content: space-between;
      flex-wrap: wrap; gap: 16px;
    }
    .public-footer-logo { font-family:'Manrope',sans-serif; font-size:1.05rem; font-weight:800; color:#111827; }
    .public-footer-links { display:flex; gap:24px; }
    .public-footer-links a { font-size:0.82rem; color:#6b7280; text-decoration:none; }
    .public-footer-links a:hover { color:#7C5CFC; }
    .public-footer-copy { font-size:0.75rem; color:#9ca3af; }

    @media (max-width: 900px) {
      .mission-grid { grid-template-columns: 1fr; }
      .team-grid { grid-template-columns: 1fr 1fr; }
      .features-grid-about { grid-template-columns: 1fr 1fr; }
      .stats-bar { grid-template-columns: 1fr 1fr; }
      .college-card { grid-template-columns: 1fr; }
      .public-nav, .public-footer { padding: 0 20px; }
    }
    @media (max-width: 600px) {
      .team-grid { grid-template-columns: 1fr; }
      .features-grid-about { grid-template-columns: 1fr; }
      .stats-bar { grid-template-columns: 1fr 1fr; gap: 16px; }
    }
  </style>
</head>
<body>

<!-- Navbar -->
<nav class="public-nav">
  <span class="public-nav-logo">⚡ Event Hive</span>
  <div class="public-nav-links">
    <a href="${pageContext.request.contextPath}/" class="btn btn-outline btn-sm">Home</a>
    <a href="${pageContext.request.contextPath}/contact" class="btn btn-outline btn-sm">Contact</a>
    <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-sm">Sign In</a>
  </div>
</nav>

<!-- Hero -->
<div class="about-hero">
  <div class="about-hero-badge">🎓 Itahari International College</div>
  <h1>About Event Hive</h1>
  <p>
    A modern, web-based college event management system built to simplify how
    students discover, register, and engage with campus events.
  </p>
</div>

<div class="about-main">

  <!-- Mission & Vision -->
  <div class="mission-grid">
    <div class="mission-card">
      <div class="mission-icon violet">🎯</div>
      <h3>Our Mission</h3>
      <p>
        To create a centralised, efficient, and user-friendly platform that connects
        students with meaningful college events — making participation easier, more
        transparent, and accessible to everyone at Itahari International College.
      </p>
    </div>
    <div class="mission-card">
      <div class="mission-icon gold">👁</div>
      <h3>Our Vision</h3>
      <p>
        To build a campus culture where every student is informed, engaged, and
        empowered to participate in academic, cultural, sports, and technical events
        that shape their college experience and professional development.
      </p>
    </div>
  </div>

  <!-- Stats -->
  <div class="stats-bar">
    <div>
      <div class="stats-bar-num">50+</div>
      <div class="stats-bar-label">Events Per Year</div>
    </div>
    <div>
      <div class="stats-bar-num">2000+</div>
      <div class="stats-bar-label">Students</div>
    </div>
    <div>
      <div class="stats-bar-num">5</div>
      <div class="stats-bar-label">Event Categories</div>
    </div>
    <div>
      <div class="stats-bar-num">100%</div>
      <div class="stats-bar-label">Web-Based</div>
    </div>
  </div>

  <!-- Team -->
  <div class="section-heading">Meet the Team</div>
  <div class="section-sub">TVA Squad — CS5054NT Advanced Programming and Technologies, Spring 2026</div>
  <div class="team-grid">
    <div class="team-card">
      <div class="team-avatar">A</div>
      <div class="team-name">Ayush Bista</div>
      <div class="team-role">Team Leader</div>
      <div class="team-id">ID: 24045833</div>
    </div>
    <div class="team-card">
      <div class="team-avatar">S</div>
      <div class="team-name">Suprim Giri</div>
      <div class="team-role">Backend Developer</div>
      <div class="team-id">ID: 24046116</div>
    </div>
    <div class="team-card">
      <div class="team-avatar">D</div>
      <div class="team-name">Darsana Bhandari</div>
      <div class="team-role">Student Portal</div>
      <div class="team-id">ID: 24045861</div>
    </div>
    <div class="team-card">
      <div class="team-avatar">A</div>
      <div class="team-name">Akisha Bhujel</div>
      <div class="team-role">Frontend & UI</div>
      <div class="team-id">ID: 24045800</div>
    </div>
  </div>

  <!-- Features -->
  <div class="section-heading">System Features</div>
  <div class="section-sub">Everything built into Event Hive for the final milestone</div>
  <div class="features-grid-about">
    <div class="feature-item">
      <div class="feature-item-icon">🔐</div>
      <h4>Secure Authentication</h4>
      <p>SHA-256 password encryption, session management, remember-me cookie, and role-based access control.</p>
    </div>
    <div class="feature-item">
      <div class="feature-item-icon">📅</div>
      <h4>Event Management</h4>
      <p>Full CRUD for events with banner image upload, category, venue, deadline, capacity, and status control.</p>
    </div>
    <div class="feature-item">
      <div class="feature-item-icon">🎫</div>
      <h4>Student Enrollment</h4>
      <p>Students can browse, search, filter, apply for events, and track approval status in real time.</p>
    </div>
    <div class="feature-item">
      <div class="feature-item-icon">👥</div>
      <h4>User Management</h4>
      <p>Admin can approve, reject, and delete student accounts with full control over registration requests.</p>
    </div>
    <div class="feature-item">
      <div class="feature-item-icon">📊</div>
      <h4>Reports & Analytics</h4>
      <p>Admin dashboard with participation charts, popular events, enrollment stats, and monthly trends.</p>
    </div>
    <div class="feature-item">
      <div class="feature-item-icon">✉</div>
      <h4>Contact System</h4>
      <p>Public contact form with admin inbox, read/unread tracking, and message management.</p>
    </div>
    <div class="feature-item">
      <div class="feature-item-icon">📱</div>
      <h4>Responsive Design</h4>
      <p>Fully responsive using CSS Flexbox and media queries — no Bootstrap used, pure custom CSS.</p>
    </div>
    <div class="feature-item">
      <div class="feature-item-icon">🛡</div>
      <h4>Input Validation</h4>
      <p>Server-side validation with regex patterns and meaningful error messages on every form.</p>
    </div>
    <div class="feature-item">
      <div class="feature-item-icon">🗄</div>
      <h4>MVC Architecture</h4>
      <p>Clean separation of Model, View, and Controller layers with DAO pattern and utility classes.</p>
    </div>
  </div>

  <!-- Tech Stack -->
  <div class="section-heading">Technologies Used</div>
  <div class="section-sub">Built as required by CS5054NT — no Bootstrap or external CSS frameworks</div>
  <div class="features-grid-about" style="grid-template-columns: repeat(3,1fr);">
    <div class="feature-item">
      <div class="feature-item-icon">☕</div>
      <h4>Java & Jakarta EE</h4>
      <p>Servlets and Filters using Jakarta EE 10 annotations — @WebServlet, @WebFilter, @MultipartConfig.</p>
    </div>
    <div class="feature-item">
      <div class="feature-item-icon">📄</div>
      <h4>JSP & JSTL</h4>
      <p>JavaServer Pages with JSTL core and functions tags for dynamic rendering and data display.</p>
    </div>
    <div class="feature-item">
      <div class="feature-item-icon">🗃</div>
      <h4>MySQL Database</h4>
      <p>Relational database with 6 normalised tables, foreign keys, and JDBC PreparedStatements.</p>
    </div>
    <div class="feature-item">
      <div class="feature-item-icon">🎨</div>
      <h4>Custom CSS</h4>
      <p>Handcrafted CSS using Flexbox, Grid, CSS variables, and media queries — zero Bootstrap.</p>
    </div>
    <div class="feature-item">
      <div class="feature-item-icon">⚡</div>
      <h4>Apache Tomcat 10</h4>
      <p>Deployed on Apache Tomcat 10.x as a WAR application with Tomcat's servlet container.</p>
    </div>
    <div class="feature-item">
      <div class="feature-item-icon">🔧</div>
      <h4>Maven Build</h4>
      <p>Maven project management with pom.xml dependency management and WAR packaging.</p>
    </div>
  </div>

  <!-- College Info -->
  <div class="college-card">
    <div>
      <h3>Itahari International College</h3>
      <p>
        Itahari International College (IIC) is affiliated with London Metropolitan University, UK.
        IIC offers internationally recognised undergraduate and postgraduate programmes in computing,
        business, and more. This project was developed as part of the CS5054NT Advanced Programming
        and Technologies module, Spring Semester 2026.
      </p>
      <div class="d-flex gap-8" style="flex-wrap:wrap;">
        <span class="college-badge">📍 Itahari, Nepal</span>
        <span class="college-badge">🎓 London Metropolitan University</span>
        <span class="college-badge">💻 CS5054NT</span>
        <span class="college-badge">📅 Spring 2026</span>
      </div>
    </div>
    <div style="text-align:center;">
      <div style="font-size:4rem; margin-bottom:8px;">🏫</div>
      <div style="font-family:'Manrope',sans-serif; font-size:0.82rem; color:#6b7280; font-weight:600;">
        Itahari International<br>College
      </div>
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
    <a href="${pageContext.request.contextPath}/contact">Contact</a>
    <a href="${pageContext.request.contextPath}/login">Sign In</a>
  </div>
  <div class="public-footer-copy">© 2026 TVA Squad · Spring Semester</div>
</footer>

</body>
</html>
