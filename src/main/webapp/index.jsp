<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Portal - Find Your Dream Job</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f0f4f8; color: #333; }
        header { background: #1a73e8; color: white; padding: 20px 40px; display: flex; justify-content: space-between; align-items: center; }
        header h1 { font-size: 1.8rem; }
        nav a { color: white; text-decoration: none; margin-left: 20px; font-size: 1rem; padding: 8px 16px; border: 1px solid white; border-radius: 4px; transition: background 0.2s; }
        nav a:hover { background: rgba(255,255,255,0.2); }
        .hero { text-align: center; padding: 80px 20px; background: linear-gradient(135deg, #1a73e8, #0d47a1); color: white; }
        .hero h2 { font-size: 2.5rem; margin-bottom: 20px; }
        .hero p { font-size: 1.2rem; margin-bottom: 40px; opacity: 0.9; }
        .hero-buttons a { display: inline-block; margin: 10px; padding: 14px 32px; border-radius: 6px; text-decoration: none; font-size: 1.1rem; font-weight: 600; transition: transform 0.2s; }
        .hero-buttons a:hover { transform: translateY(-2px); }
        .btn-primary { background: white; color: #1a73e8; }
        .btn-secondary { background: transparent; color: white; border: 2px solid white; }
        .features { display: flex; justify-content: center; gap: 30px; padding: 60px 40px; flex-wrap: wrap; }
        .feature-card { background: white; border-radius: 12px; padding: 30px; width: 280px; text-align: center; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .feature-card .icon { font-size: 2.5rem; margin-bottom: 15px; }
        .feature-card h3 { font-size: 1.2rem; margin-bottom: 10px; color: #1a73e8; }
        .feature-card p { color: #666; line-height: 1.6; }
        footer { text-align: center; padding: 20px; background: #333; color: #aaa; font-size: 0.9rem; }
    </style>
</head>
<body>
<header>
    <h1>&#128188; Job Portal</h1>
    <nav>
        <a href="${pageContext.request.contextPath}/login">Login</a>
        <a href="${pageContext.request.contextPath}/register">Register</a>
    </nav>
</header>

<div class="hero">
    <h2>Find Your Dream Job Today</h2>
    <p>Connect with top employers and discover thousands of job opportunities</p>
    <div class="hero-buttons">
        <a href="${pageContext.request.contextPath}/register" class="btn-primary">Get Started</a>
        <a href="${pageContext.request.contextPath}/login" class="btn-secondary">Sign In</a>
    </div>
</div>

<div class="features">
    <div class="feature-card">
        <div class="icon">&#128269;</div>
        <h3>Search Jobs</h3>
        <p>Browse thousands of job listings and find the perfect match for your skills and experience.</p>
    </div>
    <div class="feature-card">
        <div class="icon">&#128203;</div>
        <h3>Easy Apply</h3>
        <p>Apply to jobs with just a few clicks. Upload your resume and cover letter effortlessly.</p>
    </div>
    <div class="feature-card">
        <div class="icon">&#127970;</div>
        <h3>Post Jobs</h3>
        <p>Employers can post job openings and manage applications from qualified candidates.</p>
    </div>
</div>

<footer>
    <p>&copy; 2024 Job Portal. All rights reserved.</p>
</footer>
</body>
</html>
