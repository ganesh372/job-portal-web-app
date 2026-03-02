<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Apply for Job - Job Portal</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f0f4f8; }
        header { background: #1a73e8; color: white; padding: 15px 40px; display: flex; justify-content: space-between; align-items: center; }
        header h1 { font-size: 1.4rem; }
        nav a { color: white; text-decoration: none; margin-left: 20px; padding: 8px 14px; border-radius: 4px; transition: background 0.2s; }
        nav a:hover { background: rgba(255,255,255,0.2); }
        .container { max-width: 800px; margin: 40px auto; padding: 0 20px; }
        .job-detail { background: white; border-radius: 12px; padding: 30px; margin-bottom: 24px; box-shadow: 0 2px 10px rgba(0,0,0,0.08); }
        .job-detail h2 { color: #1a73e8; font-size: 1.6rem; margin-bottom: 8px; }
        .job-detail .company { font-size: 1.1rem; font-weight: 600; color: #333; margin-bottom: 12px; }
        .job-detail .meta { display: flex; gap: 20px; flex-wrap: wrap; color: #666; margin-bottom: 16px; }
        .section-title { font-weight: 700; color: #333; margin: 16px 0 8px; }
        .job-detail p { color: #555; line-height: 1.7; white-space: pre-wrap; }
        .apply-form { background: white; border-radius: 12px; padding: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.08); }
        .apply-form h3 { color: #333; margin-bottom: 20px; font-size: 1.2rem; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 6px; font-weight: 600; color: #555; }
        input[type="file"] { width: 100%; padding: 10px; border: 1px dashed #ddd; border-radius: 6px; font-size: 0.95rem; background: #f9f9f9; }
        textarea { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px; font-size: 1rem; resize: vertical; min-height: 120px; font-family: inherit; }
        textarea:focus { outline: none; border-color: #1a73e8; }
        .btn { padding: 12px 32px; background: #1a73e8; color: white; border: none; border-radius: 6px; font-size: 1rem; font-weight: 600; cursor: pointer; transition: background 0.2s; }
        .btn:hover { background: #1557b0; }
        .btn-back { padding: 12px 24px; background: #6c757d; color: white; border-radius: 6px; text-decoration: none; font-size: 1rem; margin-left: 10px; }
        .alert-warning { background: #fff3cd; color: #856404; padding: 16px; border-radius: 8px; margin-bottom: 20px; border: 1px solid #ffc107; }
    </style>
</head>
<body>
<header>
    <h1>&#128188; Job Portal</h1>
    <nav>
        <a href="${pageContext.request.contextPath}/search-jobs">Search Jobs</a>
        <a href="${pageContext.request.contextPath}/my-applications">My Applications</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </nav>
</header>
<div class="container">
    <div class="job-detail">
        <h2><c:out value="${job.title}"/></h2>
        <div class="company"><c:out value="${job.company}"/></div>
        <div class="meta">
            <c:if test="${not empty job.location}"><span>&#128205; <c:out value="${job.location}"/></span></c:if>
            <c:if test="${not empty job.salary}"><span>&#128176; <c:out value="${job.salary}"/></span></c:if>
        </div>
        <c:if test="${not empty job.description}">
            <div class="section-title">Job Description</div>
            <p><c:out value="${job.description}"/></p>
        </c:if>
        <c:if test="${not empty job.requirements}">
            <div class="section-title">Requirements</div>
            <p><c:out value="${job.requirements}"/></p>
        </c:if>
    </div>

    <c:choose>
        <c:when test="${alreadyApplied}">
            <div class="alert-warning">
                &#10003; You have already applied for this job. <a href="${pageContext.request.contextPath}/my-applications">View your applications</a>.
            </div>
        </c:when>
        <c:otherwise>
            <div class="apply-form">
                <h3>&#128203; Submit Your Application</h3>
                <form action="${pageContext.request.contextPath}/apply-job" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="jobId" value="${job.id}">
                    <div class="form-group">
                        <label for="resume">Upload Resume (PDF, DOC, DOCX - max 5MB)</label>
                        <input type="file" id="resume" name="resume" accept=".pdf,.doc,.docx">
                    </div>
                    <div class="form-group">
                        <label for="coverLetter">Cover Letter</label>
                        <textarea id="coverLetter" name="coverLetter" placeholder="Tell the employer why you're a great fit for this role..."></textarea>
                    </div>
                    <button type="submit" class="btn">Submit Application</button>
                    <a href="${pageContext.request.contextPath}/search-jobs" class="btn-back">Back to Search</a>
                </form>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
