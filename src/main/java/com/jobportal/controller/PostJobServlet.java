package com.jobportal.controller;

import com.jobportal.dao.JobDAO;
import com.jobportal.model.Job;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/post-job")
public class PostJobServlet extends HttpServlet {

    private final JobDAO jobDAO = new JobDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        if (!"employer".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/views/post-job.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        if (!"employer".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        String title = request.getParameter("title");
        String company = request.getParameter("company");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        String requirements = request.getParameter("requirements");
        String salary = request.getParameter("salary");

        if (title == null || title.trim().isEmpty() || company == null || company.trim().isEmpty()) {
            request.setAttribute("error", "Title and company are required.");
            request.getRequestDispatcher("/WEB-INF/views/post-job.jsp").forward(request, response);
            return;
        }

        Job job = new Job();
        job.setEmployerId((Integer) session.getAttribute("userId"));
        job.setTitle(title.trim());
        job.setCompany(company.trim());
        job.setLocation(location != null ? location.trim() : "");
        job.setDescription(description != null ? description.trim() : "");
        job.setRequirements(requirements != null ? requirements.trim() : "");
        job.setSalary(salary != null ? salary.trim() : "");

        try {
            if (jobDAO.postJob(job)) {
                response.sendRedirect(request.getContextPath() + "/dashboard?posted=true");
            } else {
                request.setAttribute("error", "Failed to post job. Please try again.");
                request.getRequestDispatcher("/WEB-INF/views/post-job.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/post-job.jsp").forward(request, response);
        }
    }
}
