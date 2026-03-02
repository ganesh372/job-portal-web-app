package com.jobportal.controller;

import com.jobportal.dao.ApplicationDAO;
import com.jobportal.model.Application;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/my-applications")
public class MyApplicationsServlet extends HttpServlet {

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

        int candidateId = (Integer) session.getAttribute("userId");
        try {
            List<Application> applications = applicationDAO.getApplicationsByCandidate(candidateId);
            request.setAttribute("applications", applications);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
        }
        request.getRequestDispatcher("/WEB-INF/views/my-applications.jsp").forward(request, response);
    }
}
