<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Post a Job - Job Portal</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f0f4f8; }
        header { background: #1a73e8; color: white; padding: 15px 40px; display: flex; justify-content: space-between; align-items: center; }
        header h1 { font-size: 1.4rem; }
        nav a { color: white; text-decoration: none; margin-left: 20px; padding: 8px 14px; border-radius: 4px; transition: background 0.2s; }
        nav a:hover { background: rgba(255,255,255,0.2); }
        .container { max-width: 700px; margin: 40px auto; padding: 0 20px; }
        .card { background: white; border-radius: 12px; padding: 40px; box-shadow: 0 2px 10px rgba(0,0,0,0.08); }
        h2 { color: #1a73e8; margin-bottom: 30px; font-size: 1.6rem; }
        .form-group { margin-bottom: 20px; }
        .form-row { display: flex; gap: 16px; }
        .form-row .form-group { flex: 1; }
        label { display: block; margin-bottom: 6px; font-weight: 600; color: #555; }
        input, textarea { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px; font-size: 1rem; transition: border-color 0.2s; font-family: inherit; }
        input:focus, textarea:focus { outline: none; border-color: #1a73e8; }
        textarea { resize: vertical; min-height: 120px; }
        .btn { padding: 12px 32px; background: #1a73e8; color: white; border: none; border-radius: 6px; font-size: 1rem; font-weight: 600; cursor: pointer; transition: background 0.2s; }
        .btn:hover { background: #1557b0; }
        .btn-cancel { padding: 12px 32px; background: #6c757d; color: white; border: none; border-radius: 6px; font-size: 1rem; cursor: pointer; text-decoration: none; display: inline-block; margin-left: 10px; }
        .btn-cancel:hover { background: #545b62; }
        .alert-error { background: #fce8e6; color: #c5221f; padding: 12px; border-radius: 6px; margin-bottom: 20px; }
    </style>
</head>
<body>
<header>
    <h1>&#128188; Job Portal</h1>
    <nav>
        <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </nav>
</header>
<div class="container">
    <div class="card">
        <h2>&#10133; Post a New Job</h2>
        <c:if test="${not empty error}">
            <div class="alert-error"><c:out value="${error}"/></div>
        </c:if>
        <form action="${pageContext.request.contextPath}/post-job" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label for="title">Job Title *</label>
                    <input type="text" id="title" name="title" placeholder="e.g. Senior Software Engineer" required value="${param.title}">
                </div>
                <div class="form-group">
                    <label for="company">Company Name *</label>
                    <input type="text" id="company" name="company" placeholder="e.g. Tech Corp" required value="${param.company}">
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="location">Location</label>
                    <input type="text" id="location" name="location" placeholder="e.g. New York, NY" value="${param.location}">
                </div>
                <div class="form-group">
                    <label for="salary">Salary Range</label>
                    <input type="text" id="salary" name="salary" placeholder="e.g. $80,000 - $100,000" value="${param.salary}">
                </div>
            </div>
            <div class="form-group">
                <label for="description">Job Description</label>
                <textarea id="description" name="description" placeholder="Describe the role, responsibilities, and what you're looking for..."><c:out value="${param.description}"/></textarea>
            </div>
            <div class="form-group">
                <label for="requirements">Requirements</label>
                <textarea id="requirements" name="requirements" placeholder="List required skills, experience, and qualifications..."><c:out value="${param.requirements}"/></textarea>
            </div>
            <button type="submit" class="btn">Post Job</button>
            <a href="${pageContext.request.contextPath}/dashboard" class="btn-cancel">Cancel</a>
        </form>
    </div>
</div>
</body>
</html>
