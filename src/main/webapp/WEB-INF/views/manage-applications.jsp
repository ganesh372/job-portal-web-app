<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Applications - Job Portal</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f0f4f8; }
        header { background: #1a73e8; color: white; padding: 15px 40px; display: flex; justify-content: space-between; align-items: center; }
        header h1 { font-size: 1.4rem; }
        nav a { color: white; text-decoration: none; margin-left: 20px; padding: 8px 14px; border-radius: 4px; transition: background 0.2s; }
        nav a:hover { background: rgba(255,255,255,0.2); }
        .container { max-width: 1200px; margin: 40px auto; padding: 0 20px; }
        h2 { color: #333; margin-bottom: 24px; font-size: 1.6rem; }
        .alert-success { background: #e6f4ea; color: #137333; padding: 12px; border-radius: 6px; margin-bottom: 20px; border: 1px solid #a8d5b5; }
        table { width: 100%; border-collapse: collapse; background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.08); }
        thead { background: #1a73e8; color: white; }
        th { padding: 14px 16px; text-align: left; font-weight: 600; }
        td { padding: 12px 16px; border-bottom: 1px solid #f0f0f0; color: #444; }
        tr:last-child td { border-bottom: none; }
        tr:hover td { background: #f8f9ff; }
        .status-badge { display: inline-block; padding: 4px 12px; border-radius: 20px; font-size: 0.85rem; font-weight: 600; text-transform: capitalize; }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-reviewed { background: #cce5ff; color: #004085; }
        .status-accepted { background: #d4edda; color: #155724; }
        .status-rejected { background: #f8d7da; color: #721c24; }
        select { padding: 6px 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 0.9rem; cursor: pointer; }
        .btn-update { padding: 6px 14px; background: #1a73e8; color: white; border: none; border-radius: 4px; font-size: 0.9rem; cursor: pointer; transition: background 0.2s; }
        .btn-update:hover { background: #1557b0; }
        .no-data { text-align: center; padding: 60px; color: #666; background: white; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.08); }
    </style>
</head>
<body>
<header>
    <h1>&#128188; Job Portal</h1>
    <nav>
        <a href="${pageContext.request.contextPath}/post-job">Post Job</a>
        <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </nav>
</header>
<div class="container">
    <h2>&#128101; Manage Applications</h2>
    <c:if test="${param.updated == 'true'}">
        <div class="alert-success">&#10003; Application status updated successfully!</div>
    </c:if>
    <c:choose>
        <c:when test="${empty applications}">
            <div class="no-data">
                <p style="font-size:1.1rem;margin-bottom:8px;">No applications received yet.</p>
                <p>Post a job to start receiving applications!</p>
            </div>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Candidate</th>
                        <th>Email</th>
                        <th>Job Title</th>
                        <th>Company</th>
                        <th>Applied On</th>
                        <th>Status</th>
                        <th>Update</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="app" items="${applications}" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td><c:out value="${app.candidateName}"/></td>
                            <td><c:out value="${app.candidateEmail}"/></td>
                            <td><c:out value="${app.jobTitle}"/></td>
                            <td><c:out value="${app.company}"/></td>
                            <td>${app.appliedAt}</td>
                            <td>
                                <span class="status-badge status-${app.status}">
                                    <c:out value="${app.status}"/>
                                </span>
                            </td>
                            <td>
                                <form action="${pageContext.request.contextPath}/manage-applications" method="post" style="display:flex;gap:6px;align-items:center;">
                                    <input type="hidden" name="applicationId" value="${app.id}">
                                    <select name="status">
                                        <option value="pending" ${app.status == 'pending' ? 'selected' : ''}>Pending</option>
                                        <option value="reviewed" ${app.status == 'reviewed' ? 'selected' : ''}>Reviewed</option>
                                        <option value="accepted" ${app.status == 'accepted' ? 'selected' : ''}>Accepted</option>
                                        <option value="rejected" ${app.status == 'rejected' ? 'selected' : ''}>Rejected</option>
                                    </select>
                                    <button type="submit" class="btn-update">Update</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
