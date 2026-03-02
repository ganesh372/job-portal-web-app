package com.jobportal.filter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Enforces session-based authentication for all protected routes.
 *
 * <p>Public paths (login, register, and the application root) are allowed
 * through without a session. Every other request requires a valid
 * {@code userId} attribute in the HTTP session; unauthenticated callers are
 * redirected to the login page.
 */
@WebFilter("/*")
public class AuthFilter implements Filter {

    /** Paths that do not require an active session. */
    private static final String[] PUBLIC_PATHS = {
        "/login", "/register", "/logout"
    };

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Nothing to initialize
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest  req  = (HttpServletRequest)  request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String contextPath = req.getContextPath();          // e.g. "/jobportal"
        String requestURI  = req.getRequestURI();           // e.g. "/jobportal/dashboard"

        // Strip the context path to get the servlet path
        String path = requestURI.substring(contextPath.length());

        // Always allow static resources and public pages
        if (isPublicPath(path)) {
            chain.doFilter(request, response);
            return;
        }

        // Require an authenticated session for everything else
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("userId") != null) {
            chain.doFilter(request, response);
        } else {
            resp.sendRedirect(contextPath + "/login");
        }
    }

    @Override
    public void destroy() {
        // Nothing to clean up
    }

    private boolean isPublicPath(String path) {
        // Allow the welcome page and any static resources (CSS, images, etc.)
        if (path.isEmpty() || "/".equals(path)) {
            return true;
        }
        for (String publicPath : PUBLIC_PATHS) {
            if (path.equals(publicPath) || path.startsWith(publicPath + "/")) {
                return true;
            }
        }
        // Allow .jsp, .css, .js, .png, .jpg, .ico accessed directly
        return path.endsWith(".jsp") || path.endsWith(".css")
                || path.endsWith(".js")  || path.endsWith(".png")
                || path.endsWith(".jpg") || path.endsWith(".ico");
    }
}
