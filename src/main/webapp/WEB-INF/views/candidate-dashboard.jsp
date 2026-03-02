<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Candidate Dashboard - Job Portal</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f0f4f8; }
        header { background: #1a73e8; color: white; padding: 15px 40px; display: flex; justify-content: space-between; align-items: center; }
        header h1 { font-size: 1.4rem; }
        nav a { color: white; text-decoration: none; margin-left: 20px; padding: 8px 14px; border-radius: 4px; transition: background 0.2s; }
        nav a:hover { background: rgba(255,255,255,0.2); }
        .container { max-width: 1100px; margin: 40px auto; padding: 0 20px; }
        .welcome { background: white; border-radius: 12px; padding: 30px; margin-bottom: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.08); }
        .welcome h2 { color: #1a73e8; font-size: 1.6rem; margin-bottom: 8px; }
        .welcome p { color: #666; }
        .cards { display: flex; gap: 24px; flex-wrap: wrap; }
        .card { background: white; border-radius: 12px; padding: 30px; flex: 1; min-width: 220px; box-shadow: 0 2px 10px rgba(0,0,0,0.08); text-align: center; transition: transform 0.2s, box-shadow 0.2s; }
        .card:hover { transform: translateY(-4px); box-shadow: 0 8px 24px rgba(0,0,0,0.12); }
        .card .icon { font-size: 3rem; margin-bottom: 16px; }
        .card h3 { font-size: 1.2rem; color: #333; margin-bottom: 10px; }
        .card p { color: #666; margin-bottom: 20px; font-size: 0.95rem; }
        .card a { display: inline-block; padding: 10px 24px; background: #1a73e8; color: white; border-radius: 6px; text-decoration: none; font-weight: 600; transition: background 0.2s; }
        .card a:hover { background: #1557b0; }
        .coming-soon { display: inline-block; padding: 10px 24px; background: #e0e0e0; color: #888; border-radius: 6px; font-size: 0.9rem; font-style: italic; }
    </style>
</head>
<body>
<header>
    <h1>&#128188; Job Portal</h1>
    <nav>
        <span>Hello, <c:out value="${sessionScope.userName}"/>!</span>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </nav>
</header>
<div class="container">
    <div class="welcome">
        <h2>Welcome, <c:out value="${sessionScope.userName}"/>!</h2>
        <p>You are logged in as a <strong>Candidate</strong>. Start exploring job opportunities!</p>
    </div>
    <div class="cards">
        <div class="card">
            <div class="icon">&#128269;</div>
            <h3>Search Jobs</h3>
            <p>Browse and search for available job openings that match your skills.</p>
            <span class="coming-soon">Coming soon</span>
        </div>
        <div class="card">
            <div class="icon">&#128203;</div>
            <h3>My Applications</h3>
            <p>Track the status of all your submitted job applications.</p>
            <span class="coming-soon">Coming soon</span>
        </div>
    </div>
</div>
</body>
</html>
