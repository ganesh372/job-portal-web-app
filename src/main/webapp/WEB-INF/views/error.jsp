<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Job Portal</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f0f4f8; display: flex; flex-direction: column; min-height: 100vh; }
        header { background: #1a73e8; color: white; padding: 15px 40px; }
        header a { color: white; text-decoration: none; font-size: 1.4rem; font-weight: bold; }
        .container { flex: 1; display: flex; justify-content: center; align-items: center; padding: 40px; }
        .error-card { background: white; border-radius: 12px; padding: 50px; text-align: center; max-width: 500px; box-shadow: 0 4px 20px rgba(0,0,0,0.1); }
        .error-icon { font-size: 4rem; margin-bottom: 20px; }
        h2 { color: #c5221f; margin-bottom: 16px; font-size: 1.6rem; }
        p { color: #666; margin-bottom: 24px; line-height: 1.6; }
        a { display: inline-block; padding: 12px 28px; background: #1a73e8; color: white; border-radius: 6px; text-decoration: none; font-weight: 600; transition: background 0.2s; }
        a:hover { background: #1557b0; }
    </style>
</head>
<body>
<header>
    <a href="${pageContext.request.contextPath}/">&#128188; Job Portal</a>
</header>
<div class="container">
    <div class="error-card">
        <div class="error-icon">&#9888;</div>
        <h2>Oops! Something went wrong</h2>
        <c:choose>
            <c:when test="${not empty error}">
                <p><c:out value="${error}"/></p>
            </c:when>
            <c:otherwise>
                <p>An unexpected error occurred. Please try again later.</p>
            </c:otherwise>
        </c:choose>
        <a href="${pageContext.request.contextPath}/">Go to Home</a>
    </div>
</div>
</body>
</html>
