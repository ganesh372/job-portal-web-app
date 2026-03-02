package com.jobportal.controller;

import com.jobportal.dao.ApplicationDAO;
import com.jobportal.model.Application;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/manage-applications")
public class ManageApplicationsServlet extends HttpServlet {

    private final ApplicationDAO applicationDAO = new ApplicationDAO();

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

        int employerId = (Integer) session.getAttribute("userId");
        try {
            List<Application> applications = applicationDAO.getApplicationsByEmployer(employerId);
            request.setAttribute("applications", applications);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
        }
        request.getRequestDispatcher("/WEB-INF/views/manage-applications.jsp").forward(request, response);
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

        String appIdStr = request.getParameter("applicationId");
        String status = request.getParameter("status");

        if (appIdStr == null || status == null) {
            response.sendRedirect(request.getContextPath() + "/manage-applications");
            return;
        }

        try {
            int appId = Integer.parseInt(appIdStr);
            applicationDAO.updateApplicationStatus(appId, status);
        } catch (NumberFormatException | SQLException e) {
            // Ignore and redirect
        }
        response.sendRedirect(request.getContextPath() + "/manage-applications?updated=true");
    }
}
