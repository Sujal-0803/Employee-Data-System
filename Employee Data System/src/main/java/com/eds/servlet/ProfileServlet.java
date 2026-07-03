package com.eds.servlet;

import com.eds.dao.ActivityLogDAO;
import com.eds.dao.EmployeeDAO;
import com.eds.model.ActivityLog;
import com.eds.model.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class ProfileServlet extends HttpServlet {
    // ── GET — show employee profile ──────────────
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // ── Get employee ID from URL ──────────
            String idStr = request.getParameter("id");
            int id = Integer.parseInt(idStr);
            // ── Load employee from DB ─────────────
            EmployeeDAO empDAO = new EmployeeDAO();
            Employee emp = empDAO.getById(id);
            if (emp == null) {
                request.getSession().setAttribute("toast_msg", "Employee not found");
                request.getSession().setAttribute("toast_type", "error");
                response.sendRedirect("employees");
                return;
            }

            // ── Load activity log for this employee
            ActivityLogDAO logDAO = new ActivityLogDAO();
            List <ActivityLog> logs = logDAO.getByEmployee(emp.getName(), 5);
            // ── Toast flash message ───────────────
            String toastMsg = (String)request.getSession().getAttribute("toast_msg");
            String toastType = (String)request.getSession().getAttribute("toast_type");
            if (toastMsg != null) {
                request.setAttribute("toast_msg",  toastMsg);
                request.setAttribute("toast_type", toastType);
                request.getSession().removeAttribute("toast_msg");
                request.getSession().removeAttribute("toast_type");
            }

            // ── Set attributes ────────────────────
            request.setAttribute("emp", emp);
            request.setAttribute("logs", logs);
            // ── Forward to JSP ────────────────────
            request.getRequestDispatcher("profile.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}