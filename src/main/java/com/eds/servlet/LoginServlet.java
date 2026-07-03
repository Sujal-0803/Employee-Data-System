package com.eds.servlet;

import com.eds.dao.AdminDAO;
import com.eds.model.Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class LoginServlet extends HttpServlet {
    // ── GET — show login page ──
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // if already logged in → go to dashboard
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("admin") != null) {
                   response.sendRedirect("dashboard");
                   return;
               }

            // show login page
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp");
        }
    }

    // ── POST — process login form ──
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // ── Read form fields ──
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // ── Validate not empty ──
            if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
                request.setAttribute("error","Username and password cannot be empty");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            // ── Check credentials in DB ──
            AdminDAO adminDAO = new AdminDAO();
            Admin admin = adminDAO.login(username.trim(),password.trim());
            if (admin != null) {
                // create session
                HttpSession session = request.getSession();
                session.setAttribute("admin",admin);
                session.setAttribute("username",admin.getUsername());

                // session timeout 30 minutes
                session.setMaxInactiveInterval(30 * 60);

                // redirect to dashboard
                response.sendRedirect("dashboard");

            } else {
                // ── Login failed ──
                request.setAttribute("error","Invalid username or password");
                request.setAttribute("username",username);
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error","Something went wrong. Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}