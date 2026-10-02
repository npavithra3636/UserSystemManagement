package com.usermanagement.filter;

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

@WebFilter("/*")
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String contextPath = httpRequest.getContextPath();
        String requestURI = httpRequest.getRequestURI();
        String path = requestURI.substring(contextPath.length());

        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);

        // Static resources
        if (path.startsWith("/css/") || path.startsWith("/js/") || path.endsWith(".css") || path.endsWith(".js")) {
            chain.doFilter(request, response);
            return;
        }

        // Login page and login API
        boolean isAuthPath = path.equals("/login.jsp") || path.equals("/") || path.startsWith("/api/login");

        if (isLoggedIn && (path.equals("/login.jsp") || path.equals("/"))) {
            httpResponse.sendRedirect(contextPath + "/home.jsp");
            return;
        }

        if (isLoggedIn || isAuthPath) {
            chain.doFilter(request, response);
            return;
        }

        // Unauthorized access
        if (path.startsWith("/api/")) {
            httpResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            httpResponse.setContentType("application/json");
            httpResponse.getWriter().write("{\"success\":false,\"message\":\"Unauthorized. Please login.\"}");
        } else {
            httpResponse.sendRedirect(contextPath + "/login.jsp");
        }
    }

    @Override
    public void destroy() {
    }
}
