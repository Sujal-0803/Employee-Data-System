package com.eds.servlet;

import com.eds.dao.ActivityLogDAO;
import com.eds.dao.DepartmentDAO;
import com.eds.dao.EmployeeDAO;
import com.eds.model.ActivityLog;
import com.eds.model.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class DashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            EmployeeDAO empDAO = new EmployeeDAO();
            DepartmentDAO deptDAO = new DepartmentDAO();
            ActivityLogDAO logDAO = new ActivityLogDAO();

            // ── Stat cards ───────────────────────
            int totalEmp = empDAO.countByStatus("Active") + empDAO.countByStatus("Inactive");
            int activeEmp = empDAO.countByStatus("Active");
            int inactiveEmp = empDAO.countByStatus("Inactive");
            int totalDept = deptDAO.count();

            // ── Recent employees ─────────────────
            List<Employee> recentEmps = empDAO.getRecent(5);

            // ── Activity log ─────────────────────
            List<ActivityLog> recentLogs = logDAO.getRecent(5);

            // ── Set attributes ───────────────────
            request.setAttribute("totalEmp", totalEmp);
            request.setAttribute("activeEmp", activeEmp);
            request.setAttribute("inactiveEmp", inactiveEmp);
            request.setAttribute("totalDept", totalDept);
            request.setAttribute("recentEmps", recentEmps);
            request.setAttribute("recentLogs", recentLogs);

            // ── Toast flash message ───────────────
            String toastMsg = (String)request.getSession().getAttribute("toast_msg");
            String toastType = (String)request.getSession().getAttribute("toast_type");
            if (toastMsg != null) {
                request.setAttribute("toast_msg", toastMsg);
                request.setAttribute("toast_type", toastType);
                request.getSession().removeAttribute("toast_msg");
                request.getSession().removeAttribute("toast_type");
            }

            // ── Forward to JSP ───────────────────
            request.getRequestDispatcher("index.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}