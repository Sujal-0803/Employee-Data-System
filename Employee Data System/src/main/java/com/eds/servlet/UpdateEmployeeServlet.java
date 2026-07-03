package com.eds.servlet;

import com.eds.dao.ActivityLogDAO;
import com.eds.dao.DepartmentDAO;
import com.eds.dao.EmployeeDAO;
import com.eds.model.Department;
import com.eds.model.Employee;
import com.eds.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.util.List;
import java.util.Map;

public class UpdateEmployeeServlet extends HttpServlet {
    // ── GET — show edit form pre-filled ─────────
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // ── Get employee ID from URL ──────────
            int id = Integer.parseInt(request.getParameter("id"));
            // ── Load employee from DB ─────────────
            EmployeeDAO empDAO = new EmployeeDAO();
            Employee emp = empDAO.getById(id);
            if (emp == null) {
                response.sendRedirect("employees");
                return;
            }

            // ── Load departments for dropdown ─────
            DepartmentDAO deptDAO = new DepartmentDAO();
            List<Department> depts = deptDAO.getAll();
            request.setAttribute("emp", emp);
            request.setAttribute("depts", depts);
            request.getRequestDispatcher("edit.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // ── POST — save updated employee ─────────────
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // ── Read form fields ─────────────────
            String idStr = request.getParameter("id");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String deptIdStr = request.getParameter("deptId");
            String designation = request.getParameter("designation");
            String salaryStr = request.getParameter("salary");
            String joinDateStr = request.getParameter("joinDate");
            String address = request.getParameter("address");
            String status = request.getParameter("status");

            // ── Build Employee object ─────────────
            Employee emp = new Employee();
            emp.setName(name != null ? name.trim() : "");
            emp.setEmail(email != null ? email.trim() : "");
            emp.setPhone(phone != null ? phone.trim() : "");
            emp.setDesignation(designation != null ? designation.trim() : "");
            emp.setAddress(address != null ? address.trim() : "");
            emp.setStatus(status != null ? status : "Active");

            // ── Parse ID ──────────────────────────
            try {
                emp.setId(Integer.parseInt(idStr));
            } catch (NumberFormatException ex) {
                emp.setId(0);
            }

            // ── Parse dept ID ─────────────────────
            try {
                emp.setDeptId(Integer.parseInt(deptIdStr));
            } catch (NumberFormatException ex) {
                emp.setDeptId(0);
            }

            // ── Parse salary ──────────────────────
            try {
                emp.setSalary(Double.parseDouble(salaryStr));
            } catch (NumberFormatException ex) {
                emp.setSalary(0);
            }

            // ── Parse join date ───────────────────
            try {
                emp.setJoinDate(Date.valueOf(joinDateStr));
            } catch (Exception ex) {
                emp.setJoinDate(null);
            }

            // ── Server side validation ────────────
            Map<String, String> errors = ValidationUtil.validate(emp, true);
            if (!errors.isEmpty()) {
                // send errors back to edit.jsp
                DepartmentDAO deptDAO = new DepartmentDAO();
                List<Department> depts = deptDAO.getAll();
                request.setAttribute("depts", depts);
                request.setAttribute("errors", errors);
                request.setAttribute("emp", emp);
                request.getRequestDispatcher("edit.jsp").forward(request, response);
                return;
            }

            // ── Update in database ────────────────
            EmployeeDAO empDAO = new EmployeeDAO();
            boolean updated = empDAO.update(emp);
            if (updated) {
                // ── Log the action ────────────────
                ActivityLogDAO logDAO = new ActivityLogDAO();
                logDAO.log("EDIT", "Employee"+ emp.getName() + "was updated", emp.getName());
                // ── Toast success ─────────────────
                request.getSession().setAttribute("toast_msg", emp.getName() + "updated successfully");
                request.getSession().setAttribute("toast_type", "success");
                response.sendRedirect("employees");
            } else {
                // ── Toast error ───────────────────
                request.getSession().setAttribute("toast_msg", "Failed to update. Try again.");
                request.getSession().setAttribute("toast_type", "error");
                response.sendRedirect("edit?id=" + emp.getId());
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}