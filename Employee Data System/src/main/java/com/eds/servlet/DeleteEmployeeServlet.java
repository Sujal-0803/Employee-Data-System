package com.eds.servlet;

import com.eds.dao.ActivityLogDAO;
import com.eds.dao.EmployeeDAO;
import com.eds.model.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class DeleteEmployeeServlet extends HttpServlet {
    // ── POST — delete employee ───────────────────
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // ── Get employee ID from form ─────────
            String idStr = request.getParameter("id");
            int id = Integer.parseInt(idStr);

            // ── Get employee name before delete ───
            EmployeeDAO empDAO = new EmployeeDAO();
            Employee emp = empDAO.getById(id);
            if (emp == null) {
                request.getSession().setAttribute("toast_msg", "Employee not found");
                request.getSession().setAttribute("toast_type", "error");
                response.sendRedirect("employees");
                return;
            }
            String empName = emp.getName();
            
            // ── Delete from database ──────────────
            boolean deleted = empDAO.delete(id);
            if (deleted) {
                // ── Log the action ────────────────
                ActivityLogDAO logDAO = new ActivityLogDAO();
                logDAO.log("DELETE", "Employee " + empName + " was deleted", empName);

                // ── Toast success ─────────────────
                request.getSession().setAttribute("toast_msg", empName + " deleted successfully");
                request.getSession().setAttribute("toast_type", "error"); // red toast for delete
                response.sendRedirect("employees");
            } else {
                // ── Toast error ───────────────────
                request.getSession().setAttribute("toast_msg", "Failed to delete. Try again.");
                request.getSession().setAttribute("toast_type", "error");
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