package com.jobportal.controller;

import com.jobportal.dao.JobDAO;
import com.jobportal.model.Job;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/search-jobs")
public class SearchJobsServlet extends HttpServlet {

    private final JobDAO jobDAO = new JobDAO();

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

        String keyword = request.getParameter("keyword");
        List<Job> jobs;
        try {
            if (keyword != null && !keyword.trim().isEmpty()) {
                jobs = jobDAO.searchJobs(keyword.trim());
                request.setAttribute("keyword", keyword.trim());
            } else {
                jobs = jobDAO.getAllJobs();
            }
            request.setAttribute("jobs", jobs);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
        }
        request.getRequestDispatcher("/WEB-INF/views/search-jobs.jsp").forward(request, response);
    }
}
