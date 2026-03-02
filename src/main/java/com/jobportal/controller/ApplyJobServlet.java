package com.jobportal.controller;

import com.jobportal.dao.ApplicationDAO;
import com.jobportal.dao.JobDAO;
import com.jobportal.model.Application;
import com.jobportal.model.Job;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.SQLException;

@WebServlet("/apply-job")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 5 * 1024 * 1024,
    maxRequestSize = 10 * 1024 * 1024
)
public class ApplyJobServlet extends HttpServlet {

    private final JobDAO jobDAO = new JobDAO();
    private final ApplicationDAO applicationDAO = new ApplicationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        if (!"candidate".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        String jobIdStr = request.getParameter("jobId");
        if (jobIdStr == null || jobIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/search-jobs");
            return;
        }

        try {
            int jobId = Integer.parseInt(jobIdStr);
            Job job = jobDAO.getJobById(jobId);
            if (job == null) {
                request.setAttribute("error", "Job not found.");
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
                return;
            }
            int candidateId = (Integer) session.getAttribute("userId");
            boolean alreadyApplied = applicationDAO.hasApplied(jobId, candidateId);
            request.setAttribute("job", job);
            request.setAttribute("alreadyApplied", alreadyApplied);
            request.getRequestDispatcher("/WEB-INF/views/apply-job.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/search-jobs");
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        if (!"candidate".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        String jobIdStr = request.getParameter("jobId");
        String coverLetter = request.getParameter("coverLetter");
        int candidateId = (Integer) session.getAttribute("userId");

        try {
            int jobId = Integer.parseInt(jobIdStr);

            if (applicationDAO.hasApplied(jobId, candidateId)) {
                response.sendRedirect(request.getContextPath() + "/my-applications?alreadyApplied=true");
                return;
            }

            // Handle file upload
            String resumePath = null;
            Part resumePart = request.getPart("resume");
            if (resumePart != null && resumePart.getSize() > 0) {
                String uploadsDir = getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadFolder = new File(uploadsDir);
                if (!uploadFolder.exists()) {
                    uploadFolder.mkdirs();
                }
                String fileName = candidateId + "_" + jobId + "_" + System.currentTimeMillis() + "_" + getSubmittedFileName(resumePart);
                String filePath = uploadsDir + File.separator + fileName;
                resumePart.write(filePath);
                resumePath = "uploads/" + fileName;
            }

            Application app = new Application();
            app.setJobId(jobId);
            app.setCandidateId(candidateId);
            app.setResumePath(resumePath);
            app.setCoverLetter(coverLetter != null ? coverLetter.trim() : "");

            if (applicationDAO.applyForJob(app)) {
                response.sendRedirect(request.getContextPath() + "/my-applications?applied=true");
            } else {
                request.setAttribute("error", "Failed to submit application.");
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/search-jobs");
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    private String getSubmittedFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition != null) {
            for (String token : contentDisposition.split(";")) {
                token = token.trim();
                if (token.startsWith("filename")) {
                    String fileName = token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
                    return new File(fileName).getName();
                }
            }
        }
        return "resume";
    }
}
