package com.eds.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class LogoutServlet extends HttpServlet {
    // ── GET — logout admin ──
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // ── Get current session ──
            HttpSession session = request.getSession(false);

            if (session != null) {
                // ── Remove all session attributes ─
                session.removeAttribute("admin");
                session.removeAttribute("username");
                session.removeAttribute("toast_msg");
                session.removeAttribute("toast_type");

                // ── Destroy session completely ──
                session.invalidate();
            }

            // ── Redirect to login page ──
            response.sendRedirect("login");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login");
        }
    }

    // ── POST — also handle post logout ──
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}