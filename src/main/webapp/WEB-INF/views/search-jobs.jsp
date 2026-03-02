<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Jobs - Job Portal</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f0f4f8; }
        header { background: #1a73e8; color: white; padding: 15px 40px; display: flex; justify-content: space-between; align-items: center; }
        header h1 { font-size: 1.4rem; }
        nav a { color: white; text-decoration: none; margin-left: 20px; padding: 8px 14px; border-radius: 4px; transition: background 0.2s; }
        nav a:hover { background: rgba(255,255,255,0.2); }
        .container { max-width: 1100px; margin: 40px auto; padding: 0 20px; }
        .search-bar { background: white; border-radius: 12px; padding: 24px; margin-bottom: 24px; box-shadow: 0 2px 10px rgba(0,0,0,0.08); display: flex; gap: 12px; }
        .search-bar input { flex: 1; padding: 12px 16px; border: 1px solid #ddd; border-radius: 6px; font-size: 1rem; }
        .search-bar input:focus { outline: none; border-color: #1a73e8; }
        .search-bar button { padding: 12px 28px; background: #1a73e8; color: white; border: none; border-radius: 6px; font-size: 1rem; font-weight: 600; cursor: pointer; transition: background 0.2s; }
        .search-bar button:hover { background: #1557b0; }
        .results-info { color: #666; margin-bottom: 16px; }
        .job-card { background: white; border-radius: 10px; padding: 24px; margin-bottom: 16px; box-shadow: 0 2px 8px rgba(0,0,0,0.07); display: flex; justify-content: space-between; align-items: flex-start; transition: box-shadow 0.2s; }
        .job-card:hover { box-shadow: 0 6px 20px rgba(0,0,0,0.12); }
        .job-info h3 { font-size: 1.2rem; color: #1a73e8; margin-bottom: 6px; }
        .job-info .company { font-weight: 600; color: #333; margin-bottom: 4px; }
        .job-info .meta { color: #666; font-size: 0.9rem; display: flex; gap: 16px; margin-top: 8px; flex-wrap: wrap; }
        .job-info .meta span { display: flex; align-items: center; gap: 4px; }
        .job-actions { display: flex; flex-direction: column; align-items: flex-end; gap: 8px; }
        .btn-apply { padding: 10px 24px; background: #1a73e8; color: white; border-radius: 6px; text-decoration: none; font-weight: 600; transition: background 0.2s; white-space: nowrap; }
        .btn-apply:hover { background: #1557b0; }
        .no-jobs { text-align: center; padding: 60px; color: #666; background: white; border-radius: 12px; }
        .alert-error { background: #fce8e6; color: #c5221f; padding: 12px; border-radius: 6px; margin-bottom: 20px; }
    </style>
</head>
<body>
<header>
    <h1>&#128188; Job Portal</h1>
    <nav>
        <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
        <a href="${pageContext.request.contextPath}/my-applications">My Applications</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </nav>
</header>
<div class="container">
    <c:if test="${not empty error}">
        <div class="alert-error"><c:out value="${error}"/></div>
    </c:if>
    <form action="${pageContext.request.contextPath}/search-jobs" method="get" class="search-bar">
        <input type="text" name="keyword" placeholder="Search by job title, company, or location..." value="${keyword}">
        <button type="submit">&#128269; Search</button>
    </form>

    <c:choose>
        <c:when test="${empty jobs}">
            <div class="no-jobs">
                <p style="font-size:1.1rem;">No jobs found. Try a different search term.</p>
            </div>
        </c:when>
        <c:otherwise>
            <p class="results-info">${jobs.size()} job(s) found<c:if test="${not empty keyword}"> for "<strong><c:out value="${keyword}"/></strong>"</c:if></p>
            <c:forEach var="job" items="${jobs}">
                <div class="job-card">
                    <div class="job-info">
                        <h3><c:out value="${job.title}"/></h3>
                        <div class="company"><c:out value="${job.company}"/></div>
                        <div class="meta">
                            <c:if test="${not empty job.location}"><span>&#128205; <c:out value="${job.location}"/></span></c:if>
                            <c:if test="${not empty job.salary}"><span>&#128176; <c:out value="${job.salary}"/></span></c:if>
                            <span>&#128197; ${job.createdAt}</span>
                        </div>
                    </div>
                    <div class="job-actions">
                        <a href="${pageContext.request.contextPath}/apply-job?jobId=${job.id}" class="btn-apply">Apply Now</a>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
