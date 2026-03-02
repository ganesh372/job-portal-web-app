<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Job Portal</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f0f4f8; display: flex; flex-direction: column; min-height: 100vh; }
        header { background: #1a73e8; color: white; padding: 15px 40px; }
        header a { color: white; text-decoration: none; font-size: 1.4rem; font-weight: bold; }
        .container { flex: 1; display: flex; justify-content: center; align-items: center; padding: 40px 20px; }
        .card { background: white; border-radius: 12px; padding: 40px; width: 100%; max-width: 440px; box-shadow: 0 4px 20px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #1a73e8; margin-bottom: 30px; font-size: 1.8rem; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 6px; font-weight: 600; color: #555; }
        input { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px; font-size: 1rem; transition: border-color 0.2s; }
        input:focus { outline: none; border-color: #1a73e8; }
        .btn { width: 100%; padding: 14px; background: #1a73e8; color: white; border: none; border-radius: 6px; font-size: 1rem; font-weight: 600; cursor: pointer; transition: background 0.2s; }
        .btn:hover { background: #1557b0; }
        .alert-error { background: #fce8e6; color: #c5221f; padding: 12px; border-radius: 6px; margin-bottom: 20px; border: 1px solid #f5c6cb; }
        .alert-success { background: #e6f4ea; color: #137333; padding: 12px; border-radius: 6px; margin-bottom: 20px; border: 1px solid #a8d5b5; }
        .link-text { text-align: center; margin-top: 20px; color: #666; }
        .link-text a { color: #1a73e8; text-decoration: none; font-weight: 600; }
    </style>
</head>
<body>
<header>
    <a href="${pageContext.request.contextPath}/">&#128188; Job Portal</a>
</header>
<div class="container">
    <div class="card">
        <h2>Welcome Back</h2>
        <c:if test="${param.registered == 'true'}">
            <div class="alert-success">Registration successful! Please log in.</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert-error"><c:out value="${error}"/></div>
        </c:if>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
            </div>
            <button type="submit" class="btn">Login</button>
        </form>
        <div class="link-text">
            Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a>
        </div>
    </div>
</div>
</body>
</html>
