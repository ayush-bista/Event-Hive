<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/favicon.png">
    <title>Event Hive &mdash; Itahari International College</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@500;600;700;800&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root {
            --navy:      #f8fafc;
            --navy-2:    #ffffff;
            --navy-3:    #eef2ff;
            --violet:    #6C4FF6;
            --violet-lt: #8B72FB;
            --violet-dk: #4A32D4;
            --gold:      #E8B84B;
            --gold-lt:   #F5D07A;
            --cyan:      #22D3EE;
            --white:     #111827;
            --muted:     #6B7280;
            --border:    rgba(15,23,42,0.12);
            --content-max: 1280px;
            --edge-space: max(64px, calc((100vw - var(--content-max)) / 2));
        }
        html { scroll-behavior: smooth; }
        body {
            font-family: 'Inter', sans-serif;
            background: var(--navy);
            color: #111827;
            overflow-x: hidden;
            cursor: auto;
        }

        /* Navbar */
        nav {
            position: fixed; top: 0; left: 0; right: 0; z-index: 100;
            padding: 22px var(--edge-space);
            display: flex; align-items: center; justify-content: space-between;
            background: rgba(255,255,255,0);
            border-bottom: 1px solid transparent;
            box-shadow: 0 0 0 rgba(15,23,42,0);
            transition: padding 0.35s cubic-bezier(0.22, 1, 0.36, 1),
            background-color 0.35s ease,
            border-color 0.35s ease,
            box-shadow 0.35s ease;
        }
        nav.scrolled {
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(20px);
            padding: 14px var(--edge-space);
            border-bottom-color: var(--border);
            box-shadow: 0 8px 24px rgba(15,23,42,0.08);
        }
        .nav-logo {
            display: flex; align-items: center; gap: 12px; text-decoration: none;
        }
        .nav-logo-icon {
            width: 40px; height: 40px;
            background: linear-gradient(135deg, var(--violet), var(--gold));
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-family: 'Manrope', sans-serif;
            font-size: 1rem; font-weight: 900; color: white;
        }
        .nav-logo-text {
            font-family: 'Manrope', sans-serif;
            font-size: 1.25rem; font-weight: 700; color: var(--white);
        }
        .nav-links { display: flex; align-items: center; gap: 36px; list-style: none; }
        .nav-links a {
            color: #4B5563; text-decoration: none;
            font-size: 0.87rem; font-weight: 500; letter-spacing: 0.02em;
            transition: color 0.2s; position: relative;
        }
        .nav-links a::after {
            content: ''; position: absolute; bottom: -3px; left: 0;
            width: 0; height: 1px; background: var(--gold); transition: width 0.3s;
        }
        .nav-links a:hover { color: var(--violet-dk); }
        .nav-links a:hover::after { width: 100%; }
        .nav-cta { display: flex; gap: 10px; align-items: center; }
        .btn-ghost {
            padding: 9px 22px; border: 1px solid rgba(15,23,42,0.15);
            border-radius: 8px; color: #4B5563; text-decoration: none;
            font-size: 0.85rem; font-weight: 500; transition: all 0.25s;
            font-family: 'Inter', sans-serif;
        }
        .btn-ghost:hover { border-color: var(--gold); color: var(--gold); }
        .btn-nav-primary {
            padding: 9px 24px;
            background: linear-gradient(135deg, var(--violet), var(--violet-dk));
            border-radius: 8px; color: white; text-decoration: none;
            font-size: 0.85rem; font-weight: 600; transition: all 0.25s;
            font-family: 'Inter', sans-serif;
            box-shadow: 0 4px 20px rgba(108,79,246,0.35);
        }
        .btn-nav-primary:hover { transform: translateY(-1px); box-shadow: 0 8px 28px rgba(108,79,246,0.5); }

        /* Hero */
        .hero {
            min-height: 100vh; display: flex; align-items: center;
            position: relative; overflow: hidden; padding: 130px var(--edge-space) 90px;
        }
        .hero-grid {
            position: absolute; inset: 0;
            background-image:
                    linear-gradient(rgba(108,79,246,0.055) 1px, transparent 1px),
                    linear-gradient(90deg, rgba(108,79,246,0.055) 1px, transparent 1px);
            background-size: 64px 64px;
            animation: gridSlide 25s linear infinite;
        }
        @keyframes gridSlide { 0%{transform:translateY(0)} 100%{transform:translateY(64px)} }
        .orb {
            position: absolute; border-radius: 50%;
            filter: blur(90px); pointer-events: none;
        }
        .orb-1 {
            width: 560px; height: 560px;
            background: radial-gradient(circle, rgba(108,79,246,0.22) 0%, transparent 70%);
            top: -120px; left: -120px;
            animation: orbFloat 9s ease-in-out infinite;
        }
        .orb-2 {
            width: 420px; height: 420px;
            background: radial-gradient(circle, rgba(232,184,75,0.13) 0%, transparent 70%);
            bottom: -60px; right: 60px;
            animation: orbFloat 11s ease-in-out infinite reverse;
        }
        .orb-3 {
            width: 280px; height: 280px;
            background: radial-gradient(circle, rgba(34,211,238,0.1) 0%, transparent 70%);
            top: 40%; right: 28%;
            animation: orbFloat 13s ease-in-out infinite;
        }
        @keyframes orbFloat {
            0%,100%{transform:translate(0,0)} 50%{transform:translate(24px,-24px)}
        }

        .hero-inner {
            position: relative; z-index: 2;
            display: grid; grid-template-columns: 1fr 1fr;
            gap: 80px; align-items: center;
            max-width: 1280px; margin: 0 auto; width: 100%;
        }

        /* hero-badge removed per landing-page cleanup */
        .hero-title {
            font-family: 'Manrope', sans-serif;
            font-size: clamp(2.8rem, 4vw, 4rem);
            font-weight: 800; line-height: 1.1; letter-spacing: -0.02em;
            margin-bottom: 22px;
            animation: fadeUp 0.7s 0.1s ease both;
        }
        .hero-title .gradient-text {
            background: linear-gradient(135deg, var(--gold) 0%, var(--violet-lt) 100%);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .hero-desc {
            font-size: 1.02rem; color: #4B5563;
            line-height: 1.82; max-width: 450px; margin-bottom: 38px;
            animation: fadeUp 0.7s 0.2s ease both;
        }
        .hero-btns {
            display: flex; gap: 14px; flex-wrap: wrap;
            animation: fadeUp 0.7s 0.3s ease both;
        }
        .btn-big-primary {
            display: inline-flex; align-items: center; gap: 10px;
            padding: 14px 32px;
            background: linear-gradient(135deg, var(--violet), var(--violet-dk));
            border-radius: 12px; color: white; text-decoration: none;
            font-size: 0.95rem; font-weight: 700; transition: all 0.3s;
            box-shadow: 0 8px 32px rgba(108,79,246,0.4);
            font-family: 'Inter', sans-serif;
        }
        .btn-big-primary:hover { transform: translateY(-3px); box-shadow: 0 16px 48px rgba(108,79,246,0.55); }
        .btn-big-primary .arr {
            width: 20px; height: 20px; background: rgba(255,255,255,0.28);
            border-radius: 50%; display: flex; align-items: center;
            justify-content: center; font-size: 0.75rem; transition: transform 0.3s;
        }
        .btn-big-primary:hover .arr { transform: translateX(3px); }
        .btn-big-ghost {
            display: inline-flex; align-items: center; gap: 10px;
            padding: 14px 28px; border: 1px solid rgba(15,23,42,0.14);
            border-radius: 12px; color: #4B5563; text-decoration: none;
            font-size: 0.95rem; font-weight: 600; transition: all 0.3s;
            font-family: 'Inter', sans-serif;
        }
        .btn-big-ghost:hover { border-color: var(--gold); color: var(--gold); background: rgba(232,184,75,0.06); }

        .hero-stats {
            display: flex; gap: 36px; margin-top: 56px;
            padding-top: 36px; border-top: 1px solid var(--border);
            animation: fadeUp 0.7s 0.4s ease both;
        }
        .stat-num {
            font-family: 'Manrope', sans-serif;
            font-size: 1.9rem; font-weight: 900; color: var(--white);
            line-height: 1; margin-bottom: 4px;
        }
        .stat-num em { color: var(--gold); font-style: normal; }
        .stat-lbl { font-size: 0.77rem; color: var(--muted); font-weight: 500; }

        /* Hero right collage */
        .hero-right {
            position: relative; height: 560px;
            animation: fadeUp 0.9s 0.2s ease both;
        }
        .img-card {
            position: absolute; border-radius: 20px; overflow: hidden;
            box-shadow: 0 16px 36px rgba(15,23,42,0.14);
            border: 1px solid rgba(15,23,42,0.12);
        }
        .img-card img { width: 100%; height: 100%; object-fit: cover; display: block; }
        .img-c1 {
            width: 265px; height: 325px; top: 0; right: 70px;
            animation: iFloat1 7s ease-in-out infinite;
        }
        .img-c2 {
            width: 220px; height: 265px; bottom: 10px; right: 0;
            animation: iFloat2 8s ease-in-out infinite;
        }
        .img-c3 {
            width: 185px; height: 210px; top: 110px; right: 315px;
            animation: iFloat1 10s ease-in-out infinite reverse;
        }
        /* Fallback gradient for failed images */
        .img-c1 .img-fallback { background: linear-gradient(135deg,#EEF2FF,#6C4FF644); }
        .img-c2 .img-fallback { background: linear-gradient(135deg,#F8FAFC,#E8B84B33); }
        .img-c3 .img-fallback { background: linear-gradient(135deg,#F1F5F9,#22D3EE22); }

        @keyframes iFloat1 { 0%,100%{transform:translateY(0) rotate(-1.5deg)} 50%{transform:translateY(-14px) rotate(1deg)} }
        @keyframes iFloat2 { 0%,100%{transform:translateY(0) rotate(2deg)} 50%{transform:translateY(-10px) rotate(-1deg)} }

        .float-tag {
            position: absolute; z-index: 3;
            background: rgba(255,255,255,0.92); backdrop-filter: blur(14px);
            border: 1px solid rgba(15,23,42,0.12); border-radius: 16px; padding: 12px 16px;
            box-shadow: 0 10px 26px rgba(15,23,42,0.12);
            min-width: 300px;
            max-width: 330px;
        }
        .float-tag-inner { display: flex; align-items: center; gap: 12px; }
        .float-tag-icon {
            width: 42px; height: 42px; border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.05rem; font-weight: 700;
            border: 1px solid rgba(124,92,252,0.22);
            background: linear-gradient(135deg, #f2ecff, #eef7ff);
            color: #5a3ed4;
            flex-shrink: 0;
        }
        .float-tag-content { display: flex; flex-direction: column; min-width: 0; }
        .float-tag-a { top: 24px; left: -10px; animation: tagF 5s ease-in-out infinite; }
        .float-tag-b { bottom: 70px; left: 30px; animation: tagF 6s ease-in-out infinite 1.5s; }
        @keyframes tagF { 0%,100%{transform:translateY(0)} 50%{transform:translateY(-8px)} }
        .tag-lbl { font-size: 0.67rem; color: #6b7280; font-weight: 700; letter-spacing: 0.06em; text-transform: uppercase; margin-bottom: 3px; }
        .tag-val { font-size: 0.88rem; font-weight: 800; color: #111827; display: flex; align-items: center; gap: 7px; }
        .live-dot { width: 8px; height: 8px; border-radius: 50%; background: #10B981; animation: livePulse 2s ease-in-out infinite; }
        @keyframes livePulse { 0%,100%{opacity:1;transform:scale(1)} 50%{opacity:0.5;transform:scale(0.75)} }

        /* College strip */
        .college-strip {
            background: linear-gradient(90deg, rgba(108,79,246,0.1), rgba(232,184,75,0.07));
            border-top: 1px solid var(--border); border-bottom: 1px solid var(--border);
            padding: 16px var(--edge-space);
            display: flex; align-items: center; justify-content: center;
            gap: 14px; flex-wrap: wrap;
        }
        .cs-text { font-size: 0.82rem; color: var(--muted); font-weight: 500; }
        .cs-name { font-size: 0.88rem; font-weight: 700; font-family: 'Manrope', sans-serif; color: var(--gold); }
        .cs-div { width: 1px; height: 18px; background: var(--border); }

        /* Features */
        .section { padding: 100px var(--edge-space); max-width: none; margin: 0 auto; }
        .s-eye {
            font-size: 0.71rem; font-weight: 700; letter-spacing: 0.12em;
            text-transform: uppercase; color: var(--violet-lt); margin-bottom: 14px;
            display: flex; align-items: center; gap: 10px;
        }
        .s-eye::before { content:''; width:22px; height:1px; background:var(--violet-lt); }
        .s-eye.no-line::before { display: none; }
        .s-title {
            font-family: 'Manrope', sans-serif;
            font-size: clamp(1.8rem, 3vw, 2.7rem);
            font-weight: 800; margin-bottom: 14px; line-height: 1.24;
        }
        .s-sub {
            font-size: 1rem; color: #4B5563;
            max-width: 480px; line-height: 1.78; margin-bottom: 56px;
        }

        .feat-grid {
            display: grid; grid-template-columns: repeat(3,1fr); gap: 18px;
        }
        .feat-card {
            background: #ffffff;
            border: 1px solid var(--border); border-radius: 20px; padding: 30px;
            position: relative; overflow: hidden;
            transition: all 0.35s cubic-bezier(0.23,1,0.32,1);
        }
        .feat-card::before {
            content: ''; position: absolute; inset: 0;
            background: linear-gradient(135deg, rgba(108,79,246,0.08), transparent 60%);
            opacity: 0; transition: opacity 0.35s;
        }
        .feat-card:hover { transform: translateY(-6px); border-color: rgba(108,79,246,0.35); box-shadow: 0 14px 32px rgba(15,23,42,0.12); }
        .feat-card:hover::before { opacity: 1; }
        .feat-icon {
            width: 50px; height: 50px; border-radius: 13px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.35rem; margin-bottom: 18px;
        }
        .fi-v { background: rgba(108,79,246,0.14); box-shadow: inset 0 0 0 1px rgba(108,79,246,0.2); }
        .fi-g { background: rgba(232,184,75,0.11);  box-shadow: inset 0 0 0 1px rgba(232,184,75,0.2); }
        .fi-c { background: rgba(34,211,238,0.09);  box-shadow: inset 0 0 0 1px rgba(34,211,238,0.2); }
        .feat-title { font-family:'Manrope',sans-serif; font-size:1.05rem; font-weight:650; margin-bottom:9px; }
        .feat-desc  { font-size:0.86rem; color:#4B5563; line-height:1.72; }

        /* Gallery */
        .gallery-wrap { padding: 80px 0; overflow: hidden; }
        .gal-head { padding: 0 var(--edge-space); margin-bottom: 38px; }
        .gal-head .s-eye::before { display: none; }
        .gallery-track {
            display: flex; gap: 18px;
            animation: gScroll 28s linear infinite;
            width: max-content;
        }
        .gallery-track:hover { animation-play-state: paused; }
        @keyframes gScroll { 0%{transform:translateX(0)} 100%{transform:translateX(-50%)} }
        .gal-item {
            width: 295px; height: 195px; border-radius: 16px;
            overflow: hidden; flex-shrink: 0;
            border: 1px solid var(--border); position: relative;
        }
        .gal-item img { width:100%; height:100%; object-fit:cover; transition:transform 0.5s; display:block; }
        .gal-item:hover img { transform:scale(1.07); }
        .gal-label {
            position: absolute; bottom:0; left:0; right:0;
            background: linear-gradient(to top, rgba(15,23,42,0.7), transparent);
            padding: 22px 14px 12px;
            font-size: 0.77rem; font-weight: 600; color: rgba(255,255,255,0.9); letter-spacing: 0.03em;
        }
        .gal-placeholder {
            width:100%; height:100%;
            display:flex; align-items:center; justify-content:center; flex-direction:column; gap:6px;
        }
        .gal-placeholder .gp-icon { font-size:2.2rem; }
        .gal-placeholder .gp-text { font-size:0.76rem; color:#6B7280; font-weight:600; }

        /* Steps */
        .steps-wrap { display:grid; grid-template-columns:repeat(4,1fr); gap:0; position:relative; }
        .steps-wrap::before {
            content:''; position:absolute; top:28px; left:12.5%; right:12.5%; height:1px;
            background:linear-gradient(90deg,transparent,var(--border),var(--border),transparent);
        }
        .step { text-align:center; padding:0 18px; position:relative; z-index:1; }
        .step-n {
            width:56px; height:56px; border-radius:50%;
            background:var(--navy-3); border:1px solid var(--border);
            display:flex; align-items:center; justify-content:center;
            font-family:'Manrope',sans-serif; font-size:1.1rem; font-weight:800; color:var(--gold);
            margin:0 auto 20px; transition:all 0.3s;
        }
        .step:hover .step-n { background:var(--violet); border-color:var(--violet); color:white; box-shadow:0 8px 24px rgba(108,79,246,0.4); }
        .step-t { font-family:'Manrope',sans-serif; font-size:1rem; font-weight:650; margin-bottom:8px; }
        .step-d { font-size:0.82rem; color:var(--muted); line-height:1.65; }

        /* CTA */
        .cta-wrap {
            margin: 0 var(--edge-space) 100px;
            background: linear-gradient(135deg, rgba(108,79,246,0.18), rgba(232,184,75,0.07));
            border: 1px solid rgba(108,79,246,0.24); border-radius: 28px;
            padding: 84px 80px; text-align: center; position: relative; overflow: hidden;
        }
        .cta-wrap::before {
            content:''; position:absolute; width:400px; height:400px; border-radius:50%;
            background:radial-gradient(circle,rgba(108,79,246,0.14),transparent 70%);
            top:-100px; left:-100px; pointer-events:none;
        }
        .cta-wrap::after {
            content:''; position:absolute; width:300px; height:300px; border-radius:50%;
            background:radial-gradient(circle,rgba(232,184,75,0.09),transparent 70%);
            bottom:-80px; right:-80px; pointer-events:none;
        }
        .cta-t { font-family:'Manrope',sans-serif; font-size:clamp(1.8rem,3vw,2.7rem); font-weight:800; margin-bottom:14px; position:relative;z-index:1; }
        .cta-d { font-size:0.98rem; color:#4B5563; margin-bottom:34px; position:relative;z-index:1; }
        .cta-b { display:flex; gap:14px; justify-content:center; flex-wrap:wrap; position:relative;z-index:1; }

        /* Footer */
        footer {
            border-top:1px solid var(--border); padding:38px var(--edge-space);
            display:flex; align-items:center; justify-content:space-between; flex-wrap:wrap; gap:20px;
        }
        .f-logo { font-family:'Manrope',sans-serif; font-size:1.1rem; font-weight:700; color:var(--white); }
        .f-college { font-size:0.77rem; color:var(--muted); margin-top:2px; }
        .f-links { display:flex; gap:26px; }
        .f-links a { font-size:0.82rem; color:var(--muted); text-decoration:none; transition:color 0.2s; }
        .f-links a:hover { color:var(--gold); }
        .f-copy { font-size:0.74rem; color:rgba(122,125,146,0.55); }

        /* Animations */
        @keyframes fadeUp { from{opacity:0;transform:translateY(22px)} to{opacity:1;transform:translateY(0)} }
        .reveal { opacity:0; transform:translateY(28px); transition:opacity 0.7s ease, transform 0.7s ease; }
        .reveal.visible { opacity:1; transform:translateY(0); }

        /* Responsive */
        @media(max-width:1024px){
            nav{padding:20px 32px}
            nav.scrolled{padding:12px 32px}
            .hero{padding:120px 32px 80px}
            .hero-inner{grid-template-columns:1fr; gap:50px}
            .hero-right{height:320px}
            .img-c1{width:210px;height:250px;right:30px}
            .img-c2{width:175px;height:210px}
            .img-c3{display:none}
            .section{padding:80px 32px}
            .college-strip{padding:16px 32px}
            .gal-head{padding:0 32px}
            .feat-grid{grid-template-columns:1fr 1fr}
            .steps-wrap{grid-template-columns:1fr 1fr;gap:40px}
            .steps-wrap::before{display:none}
            .cta-wrap{margin:0 32px 80px;padding:60px 40px}
            footer{padding:32px}
        }
        @media(max-width:640px){
            nav{padding:16px 20px}
            nav.scrolled{padding:12px 20px}
            .nav-links{display:none}
            .hero{padding:100px 20px 60px}
            .hero-right{display:none}
            .section{padding:60px 20px}
            .feat-grid{grid-template-columns:1fr}
            .steps-wrap{grid-template-columns:1fr 1fr}
            .cta-wrap{margin:0 20px 60px;padding:48px 24px}
            footer{padding:28px 20px;flex-direction:column;align-items:flex-start}
            .college-strip{padding:14px 20px}
        }
    </style>
</head>
<body>

<!-- NAVBAR -->
<nav id="navbar">
    <a href="#" class="nav-logo">
        <%--        <div class="nav-logo-icon">EH</div>--%>
        <span class="nav-logo-text">Event Hive</span>
    </a>
    <ul class="nav-links">
        <li><a href="#features">Features</a></li>
        <li><a href="#gallery">Campus</a></li>
        <li><a href="#how">How it Works</a></li>
        <li><a href="${pageContext.request.contextPath}/about">About</a></li>
        <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
    </ul>
    <div class="nav-cta">
        <a href="${pageContext.request.contextPath}/login" class="btn-ghost">Sign In</a>
        <a href="${pageContext.request.contextPath}/register" class="btn-nav-primary">Get Started -></a>
    </div>
</nav>

<!-- HERO -->
<section class="hero">
    <div class="hero-grid"></div>
    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>
    <div class="orb orb-3"></div>

    <div class="hero-inner">
        <div class="hero-left">
            <h1 class="hero-title">
                Discover &amp; Join<br>
                <span class="gradient-text">Amazing Events</span><br>
                On Campus
            </h1>

            <p class="hero-desc">
                Event Hive is your college's central hub for discovering, registering,
                and experiencing events from tech fests and cultural nights to
                sports tournaments and academic seminars.
            </p>

            <div class="hero-btns">
                <a href="${pageContext.request.contextPath}/register" class="btn-big-primary">
                    Get Started Free
                    <span class="arr">-></span>
                </a>
                <a href="${pageContext.request.contextPath}/login" class="btn-big-ghost">
                    Sign In
                </a>
            </div>

            <div class="hero-stats">
                <div>
                    <div class="stat-num" id="s1">25<em>+</em></div>
                    <div class="stat-lbl">Events Per Year</div>
                </div>
                <div>
                    <div class="stat-num" id="s2">2k<em>+</em></div>
                    <div class="stat-lbl">Students</div>
                </div>
                <div>
                    <div class="stat-num" id="s3">5<em>+</em></div>
                    <div class="stat-lbl">Event Categories</div>
                </div>
            </div>
        </div>

        <div class="hero-right">
            <!-- Image 1 &mdash; IIC Building -->
            <div class="img-card img-c1">
                <img
                        src="https://iic.edu.np/image/about-iic.png"
                        alt="Itahari International College"
                        onerror="this.style.display='none'; this.parentElement.style.background='linear-gradient(135deg,#EEF2FF,#6C4FF644)';"
                >
            </div>
            <!-- Image 2 &mdash; Students -->
            <div class="img-card img-c2">
                <img
                        src="https://iic.edu.np/storage/lifeAtIic/4-14-upload3.jpg"
                        alt="IIC Students"
                        onerror="this.style.display='none'; this.parentElement.style.background='linear-gradient(135deg,#F8FAFC,#E8B84B33)';"
                >
            </div>
            <!-- Image 3 &mdash; Campus -->
            <div class="img-card img-c3">
                <img
                        src="https://iic.edu.np/storage/lifeAtIic/1-25-upload8.png"
                        alt="IIC Campus"
                        onerror="this.style.display='none'; this.parentElement.style.background='linear-gradient(135deg,#F1F5F9,#22D3EE22)';"
                >
            </div>

            <%--            <div class="float-tag float-tag-a">--%>
            <%--                <div class="float-tag-inner">--%>
            <%--                    <div class="float-tag-icon" aria-hidden="true">IIC</div>--%>
            <%--                    <div class="float-tag-content">--%>
            <%--                        <div class="tag-lbl">Next Event</div>--%>
            <%--                        <div class="tag-val">--%>
            <%--                            <span class="live-dot"></span>--%>
            <%--                            Annual Tech Fest 2026--%>
            <%--                        </div>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </div>--%>
            <div class="float-tag float-tag-b">
                <div class="float-tag-inner">
                    <div class="float-tag-icon" aria-hidden="true">EV</div>
                    <div class="float-tag-content">
                        <div class="tag-lbl">Registrations Open</div>
                        <div class="tag-val">4 Live Events</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- COLLEGE STRIP -->
<%--<div class="college-strip">--%>
<%--    <span class="cs-text">Proudly built for</span>--%>
<%--    <span class="cs-name">Itahari International College</span>--%>
<%--    <div class="cs-div"></div>--%>
<%--    <span class="cs-text">Affiliated with</span>--%>
<%--    <span class="cs-name">London Metropolitan University</span>--%>
<%--    <div class="cs-div"></div>--%>
<%--    <span class="cs-text">Module</span>--%>
<%--    <span class="cs-name" style="color:var(--violet-lt);">CS5054NT &middot; Advanced Programming</span>--%>
<%--    <div class="cs-div"></div>--%>
<%--    <span class="cs-text">Team</span>--%>
<%--    <span class="cs-name" style="color:var(--cyan);">TVA Squad</span>--%>
<%--</div>--%>

<!-- FEATURES -->
<div id="features">
    <div class="section">
        <div class="s-eye reveal no-line">Why Event Hive</div>
        <h2 class="s-title reveal">Everything you need,<br>all in one place</h2>
        <p class="s-sub reveal">
            Designed specifically for Itahari International College students and
            administrators to manage campus events without the hassle.
        </p>

        <div class="feat-grid">
            <div class="feat-card reveal">
                <div class="feat-icon fi-v">EV</div>
                <div class="feat-title">Browse &amp; Enroll</div>
                <div class="feat-desc">Discover upcoming events, filter by Academic, Cultural, Sports, or Technical categories and apply instantly.</div>
            </div>
            <div class="feat-card reveal">
                <div class="feat-icon fi-g">SEC</div>
                <div class="feat-title">Secure &amp; Role-Based</div>
                <div class="feat-desc">SHA-256 encrypted passwords, session management, and completely separate dashboards for admins and students.</div>
            </div>
            <div class="feat-card reveal">
                <div class="feat-icon fi-c">DB</div>
                <div class="feat-title">Admin Dashboard</div>
                <div class="feat-desc">Full event management, student approvals, participant lists, and live enrollment analytics in one place.</div>
            </div>
            <div class="feat-card reveal">
                <div class="feat-icon fi-v">SR</div>
                <div class="feat-title">Smart Search</div>
                <div class="feat-desc">Find events instantly with keyword search and category filters. Never miss what matters to you.</div>
            </div>
            <div class="feat-card reveal">
                <div class="feat-icon fi-g">PR</div>
                <div class="feat-title">Student Profiles</div>
                <div class="feat-desc">Track your enrolled events, manage personal information, and update your password from your profile.</div>
            </div>
            <div class="feat-card reveal">
                <div class="feat-icon fi-c">MB</div>
                <div class="feat-title">Fully Responsive</div>
                <div class="feat-desc">Works perfectly on every device: desktop, tablet, or phone. No app download required.</div>
            </div>
        </div>
    </div>
</div>

<!-- GALLERY -->
<div class="gallery-wrap" id="gallery">
    <div class="gal-head">
        <div class="s-eye reveal">Campus Life</div>
        <h2 class="s-title reveal">Itahari International College</h2>
    </div>
    <div style="overflow:hidden;">
        <div class="gallery-track">
            <!-- Set 1 -->
            <div class="gal-item">
                <img src="https://iic.edu.np/image/about-iic.png"
                     alt="IIC Main Building"
                     onerror="this.style.display='none'; this.parentElement.querySelector('.gal-placeholder').style.display='flex';">
                <div class="gal-placeholder" style="display:none; background:linear-gradient(135deg,#EEF2FF,#6C4FF644);">
                    <div class="gp-icon">IIC</div><div class="gp-text">Main Building</div>
                </div>
                <div class="gal-label">IIC Main Campus</div>
            </div>
            <div class="gal-item" style="background:linear-gradient(135deg,#F8FAFC,#6C4FF622);">
                <img src="https://futurama.ingskill.com/images/homepage.PNG"
                     alt="Annual Tech Fest"
                     onerror="this.style.display='none'; this.parentElement.querySelector('.gal-placeholder').style.display='flex';">
                <div class="gal-placeholder" style="display:none; background:linear-gradient(135deg,#EEF2FF,#6C4FF644);">
                    <div class="gp-icon">TECH</div><div class="gp-text">Tech Fest</div>
                </div>
                <div class="gal-label">Annual Tech Fest</div>
            </div>
            <div class="gal-item" style="background:linear-gradient(135deg,#F8FAFC,#E8B84B22);">
                <img src="https://iic.edu.np/image/life-at-iic/banner.jpg"
                     alt="Cultural Night"
                     onerror="this.style.display='none'; this.parentElement.querySelector('.gal-placeholder').style.display='flex';">
                <div class="gal-placeholder" style="display:none; background:linear-gradient(135deg,#EEF2FF,#E8B84B44);">
                    <div class="gp-icon">CULT</div><div class="gp-text">Cultural Night</div>
                </div>
                <div class="gal-label">Cultural Night</div>
            </div>
            <div class="gal-item" style="background:linear-gradient(135deg,#F8FAFC,#10B98122);">
                <img src="https://iic.edu.np/storage/lifeAtIic/4-banner_image.webp"
                     alt="Inter-College Sports"
                     onerror="this.style.display='none'; this.parentElement.querySelector('.gal-placeholder').style.display='flex';">
                <div class="gal-placeholder" style="display:none; background:linear-gradient(135deg,#EEF2FF,#10B98144);">
                    <div class="gp-icon">SPRT</div><div class="gp-text">Sports Day</div>
                </div>
                <div class="gal-label">Inter-College Sports</div>
            </div>
            <div class="gal-item" style="background:linear-gradient(135deg,#F8FAFC,#22D3EE22);">
                <img src="https://islington.edu.np/images/blog-images/international_exposure/five.jpg"
                     alt="Academic Seminar"
                     onerror="this.style.display='none'; this.parentElement.querySelector('.gal-placeholder').style.display='flex';">
                <div class="gal-placeholder" style="display:none; background:linear-gradient(135deg,#EEF2FF,#22D3EE33);">
                    <div class="gp-icon">ACAD</div><div class="gp-text">Research Seminar</div>
                </div>
                <div class="gal-label">Academic Seminar</div>
            </div>
            <div class="gal-item" style="background:linear-gradient(135deg,#F8FAFC,#F43F5E22);">
                <img src="https://iic.edu.np/storage/post/IIC%20Graduation%202024%20(1200%20x%20400px)_1740396861.png"
                     alt="Graduation Ceremony"
                     onerror="this.style.display='none'; this.parentElement.querySelector('.gal-placeholder').style.display='flex';">
                <div class="gal-placeholder" style="display:none; background:linear-gradient(135deg,#EEF2FF,#F43F5E33);">
                    <div class="gp-icon">GRAD</div><div class="gp-text">Graduation</div>
                </div>
                <div class="gal-label">Graduation Ceremony</div>
            </div>


            <!-- Set 2 (duplicate for seamless loop) -->
            <div class="gal-item">
                <img src="https://iic.edu.np/image/about-iic.png"
                     alt="IIC Main Building"
                     onerror="this.style.display='none'; this.parentElement.querySelector('.gal-placeholder').style.display='flex';">
                <div class="gal-placeholder" style="display:none; background:linear-gradient(135deg,#EEF2FF,#6C4FF644);">
                    <div class="gp-icon">IIC</div><div class="gp-text">Main Building</div>
                </div>
                <div class="gal-label">IIC Main Campus</div>
            </div>
            <div class="gal-item" style="background:linear-gradient(135deg,#EEF2FF,#6C4FF644);">
                <img src="https://futurama.ingskill.com/images/homepage.PNG"
                     alt="Annual Tech Fest"
                     onerror="this.style.display='none'; this.parentElement.querySelector('.gal-placeholder').style.display='flex';">
                <div class="gal-placeholder" style="display:none;"><div class="gp-icon">TECH</div><div class="gp-text">Tech Fest</div></div>
                <div class="gal-label">Annual Tech Fest</div>
            </div>
            <div class="gal-item" style="background:linear-gradient(135deg,#EEF2FF,#E8B84B44);">
                <img src="https://iic.edu.np/image/life-at-iic/banner.jpg"
                     alt="Cultural Night"
                     onerror="this.style.display='none'; this.parentElement.querySelector('.gal-placeholder').style.display='flex';">
                <div class="gal-placeholder" style="display:none;"><div class="gp-icon">CULT</div><div class="gp-text">Cultural Night</div></div>
                <div class="gal-label">Cultural Night</div>
            </div>
            <div class="gal-item" style="background:linear-gradient(135deg,#EEF2FF,#10B98144);">
                <img src="https://iic.edu.np/storage/lifeAtIic/4-banner_image.webp"
                     alt="Inter-College Sports"
                     onerror="this.style.display='none'; this.parentElement.querySelector('.gal-placeholder').style.display='flex';">
                <div class="gal-placeholder" style="display:none;"><div class="gp-icon">SPRT</div><div class="gp-text">Sports Day</div></div>
                <div class="gal-label">Inter-College Sports</div>
            </div>
            <div class="gal-item" style="background:linear-gradient(135deg,#EEF2FF,#22D3EE33);">
                <img src="https://islington.edu.np/images/blog-images/international_exposure/five.jpg"
                     alt="Academic Seminar"
                     onerror="this.style.display='none'; this.parentElement.querySelector('.gal-placeholder').style.display='flex';">
                <div class="gal-placeholder" style="display:none;"><div class="gp-icon">ACAD</div><div class="gp-text">Research Seminar</div></div>
                <div class="gal-label">Academic Seminar</div>
            </div>
            <div class="gal-item" style="background:linear-gradient(135deg,#EEF2FF,#F43F5E33);">
                <img src="https://iic.edu.np/storage/post/IIC%20Graduation%202024%20(1200%20x%20400px)_1740396861.png"
                     alt="Graduation Ceremony"
                     onerror="this.style.display='none'; this.parentElement.querySelector('.gal-placeholder').style.display='flex';">
                <div class="gal-placeholder" style="display:none;"><div class="gp-icon">GRAD</div><div class="gp-text">Graduation</div></div>
                <div class="gal-label">Graduation Ceremony</div>
            </div>
        </div>
    </div>
</div>

<!-- HOW IT WORKS -->
<div id="how">
    <div class="section">
        <div class="s-eye reveal no-line">Simple Process</div>
        <h2 class="s-title reveal">How it works</h2>
        <p class="s-sub reveal">Get started in minutes. No complicated setup required.</p>

        <div class="steps-wrap">
            <div class="step reveal">
                <div class="step-n">01</div>
                <div class="step-t">Register</div>
                <div class="step-d">Create your student account with your college details in under 2 minutes.</div>
            </div>
            <div class="step reveal">
                <div class="step-n">02</div>
                <div class="step-t">Get Approved</div>
                <div class="step-d">Admin reviews and approves your account, usually within the same day.</div>
            </div>
            <div class="step reveal">
                <div class="step-n">03</div>
                <div class="step-t">Browse Events</div>
                <div class="step-d">Explore all upcoming events, filter by category, and read full details.</div>
            </div>
            <div class="step reveal">
                <div class="step-n">04</div>
                <div class="step-t">Enroll &amp; Enjoy</div>
                <div class="step-d">Apply for events you love and track your enrollment status in real time.</div>
            </div>
        </div>
    </div>
</div>

<!-- CTA -->
<div class="cta-wrap reveal">
    <h2 class="cta-t">Ready to join the experience?</h2>
    <p class="cta-d">Register now and never miss a campus event at Itahari International College.</p>
    <div class="cta-b">
        <a href="${pageContext.request.contextPath}/register" class="btn-big-primary">
            Create Free Account
        </a>
        <a href="${pageContext.request.contextPath}/login" class="btn-big-ghost">
            Already have an account? Sign In
        </a>
    </div>
</div>

<!-- FOOTER -->
<footer>
    <div>
        <div class="f-logo">Event Hive</div>
        <div class="f-college">Itahari International College</div>
    </div>
    <div class="f-links">
        <a href="${pageContext.request.contextPath}/about">About</a>
        <a href="${pageContext.request.contextPath}/contact">Contact</a>
        <a href="${pageContext.request.contextPath}/login">Sign In</a>
        <a href="${pageContext.request.contextPath}/register">Register</a>
    </div>
    <div class="f-copy">&copy; 2026 TVA Squad</div>
</footer>

<script>

    // Navbar scroll
    const navbar = document.getElementById('navbar');
    const syncNavbar = () => navbar.classList.toggle('scrolled', window.scrollY > 40);
    syncNavbar();
    window.addEventListener('scroll', syncNavbar, { passive: true });

    // Scroll reveal
    const obs = new IntersectionObserver(entries=>{
        entries.forEach((e,i)=>{
            if(e.isIntersecting){
                setTimeout(()=>e.target.classList.add('visible'), i*75);
                obs.unobserve(e.target);
            }
        });
    },{threshold:0.1});
    document.querySelectorAll('.reveal').forEach(el=>obs.observe(el));

    // Animated counters
    function counter(el, end, suffix, delay){
        setTimeout(()=>{
            let start=0, dur=1600, s;
            const step=ts=>{
                if(!s) s=ts;
                const p=Math.min((ts-s)/dur,1);
                const e=1-Math.pow(1-p,3);
                el.innerHTML = Math.floor(e*end) + '<em>'+suffix+'</em>';
                if(p<1) requestAnimationFrame(step);
            };
            requestAnimationFrame(step);
        }, delay);
    }
    const statsObs = new IntersectionObserver(entries=>{
        entries.forEach(e=>{
            if(e.isIntersecting){
                counter(document.getElementById('s1'), 50, '+', 0);
                counter(document.getElementById('s2'), 2000, '+', 150);
                counter(document.getElementById('s3'), 5, '', 300);
                statsObs.unobserve(e.target);
            }
        });
    },{threshold:0.4});
    const statsEl = document.querySelector('.hero-stats');
    if(statsEl) statsObs.observe(statsEl);
</script>

</body>
</html>



