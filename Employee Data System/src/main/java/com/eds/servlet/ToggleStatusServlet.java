package com.eds.servlet;

import com.eds.dao.ActivityLogDAO;
import com.eds.dao.EmployeeDAO;
import com.eds.model.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class ToggleStatusServlet extends HttpServlet {
    // ── POST — toggle employee status ────────────
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // ── Read employee ID and redirect URL ─
            String idStr = request.getParameter("id");
            String redirectTo = request.getParameter("redirectTo");
            int id = Integer.parseInt(idStr);

            // ── Load employee to get name ─────────
            EmployeeDAO empDAO = new EmployeeDAO();
            Employee emp = empDAO.getById(id);
            if (emp == null) {
                request.getSession().setAttribute("toast_msg", "Employee not found");
                request.getSession().setAttribute("toast_type", "error");
                response.sendRedirect("employees");
                return;
            }

            // ── Toggle status in DB ───────────────
            boolean toggled = empDAO.toggleStatus(id);
            if (toggled) {
                // get new status after toggle
                String oldStatus = emp.getStatus();
                String newStatus = oldStatus.equals("Active") ? "Inactive" : "Active";
                // ── Log the action ────────────────
                ActivityLogDAO logDAO = new ActivityLogDAO();
                logDAO.log("EDIT", "Employee " + emp.getName() + " status changed to " + newStatus, emp.getName());

                // ── Toast message ─────────────────
                String toastType = newStatus.equals("Active") ? "success" : "warn";
                request.getSession().setAttribute("toast_msg", emp.getName() + " marked as " + newStatus);
                request.getSession().setAttribute("toast_type", toastType);
            } else {
                request.getSession().setAttribute("toast_msg", "Failed to update status. Try again.");
                request.getSession().setAttribute("toast_type", "error");
            }

            // ── Redirect back to where user was ───
            if (redirectTo != null && redirectTo.equals("profile")) {
                response.sendRedirect("profile?id=" + id);
            } else {
                response.sendRedirect("employees");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
    // ── GET — redirect to employees ──────────────
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("employees");
    }
}