package com.eds.servlet;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class AuthFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req =(HttpServletRequest) request;
        HttpServletResponse res =(HttpServletResponse) response;

        // ── Get request URL ──
        String uri = req.getRequestURI();

        // ── Pages that do NOT need login ──
        boolean isLoginPage = uri.endsWith("/login");
        boolean isLoginJsp = uri.endsWith("login.jsp");
        boolean isCss = uri.contains("/css/");
        boolean isJs = uri.contains("/js/");
        boolean isImages = uri.contains("/images/");
        boolean isErrorPage = uri.endsWith("error.jsp");

        // ── Allow these without login ──
        if (isLoginPage || isLoginJsp || isCss || isJs || isImages || isErrorPage) {
            chain.doFilter(request, response);
            return;
        }

        // ── Check session ─────────────────────────
        HttpSession session = req.getSession(false);
        boolean loggedIn = (session != null && session.getAttribute("admin") != null);

        if (loggedIn) {
            // ── Logged in → allow access ──────────
            chain.doFilter(request, response);
        } else {
            // ── Not logged in → go to login ───────
            res.sendRedirect(req.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {}
}