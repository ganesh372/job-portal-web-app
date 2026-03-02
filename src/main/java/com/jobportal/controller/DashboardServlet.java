package com.jobportal.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String role = (String) session.getAttribute("userRole");
        if ("employer".equals(role)) {
            request.getRequestDispatcher("/WEB-INF/views/employer-dashboard.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/WEB-INF/views/candidate-dashboard.jsp").forward(request, response);
        }
    }
}
