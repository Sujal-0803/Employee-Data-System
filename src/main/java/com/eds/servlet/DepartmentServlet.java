package com.eds.servlet;

import com.eds.dao.ActivityLogDAO;
import com.eds.dao.DepartmentDAO;
import com.eds.model.Department;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class DepartmentServlet extends HttpServlet {
    // ── GET — show all departments ───────────────
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            DepartmentDAO deptDAO = new DepartmentDAO();
            List <Department> depts = deptDAO.getAllWithCount();
            // ── Toast flash message ───────────────
            String toastMsg = (String)request.getSession().getAttribute("toast_msg");
            String toastType = (String)request.getSession().getAttribute("toast_type");
            if (toastMsg != null) {
                request.setAttribute("toast_msg",  toastMsg);
                request.setAttribute("toast_type", toastType);
                request.getSession().removeAttribute("toast_msg");
                request.getSession().removeAttribute("toast_type");
            }
            request.setAttribute("depts", depts);
            request.getRequestDispatcher("departments.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // ── POST — add or delete department ─────────
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            DepartmentDAO deptDAO = new DepartmentDAO();
            ActivityLogDAO logDAO = new ActivityLogDAO();

            // ── Add new department ────────────────
            if ("add".equals(action)) {
                String name = request.getParameter("name");
                String desc = request.getParameter("description");

                // validate name not empty
                if (name == null || name.trim().isEmpty()) {
                    request.getSession().setAttribute("toast_msg", "Department name cannot be empty");
                    request.getSession().setAttribute("toast_type", "error");
                    response.sendRedirect("departments");
                    return;
                }

                // check duplicate name
                if (deptDAO.nameExists(name.trim(), 0)) {
                    request.getSession().setAttribute("toast_msg", "Department " + name + " already exists");
                    request.getSession().setAttribute("toast_type", "error");
                    response.sendRedirect("departments");
                    return;
                }
                boolean added = deptDAO.add( name.trim(), desc != null ? desc.trim() : "");
                if (added) {
                    logDAO.log("ADD", "Department " + name + " was added", name);
                    request.getSession().setAttribute("toast_msg", name + " department added successfully");
                    request.getSession().setAttribute("toast_type", "success");
                } else {
                    request.getSession().setAttribute("toast_msg", "Failed to add department. Try again.");
                    request.getSession().setAttribute("toast_type", "error");
                }
                response.sendRedirect("departments");

            // ── Delete department ─────────────────
            } else if ("delete".equals(action)) {
                String idStr = request.getParameter("id");
                int id = Integer.parseInt(idStr);

                // get dept name before delete
                Department dept = deptDAO.getById(id);
                if (dept == null) {
                    request.getSession().setAttribute("toast_msg", "Department not found");
                    request.getSession().setAttribute("toast_type", "error");
                    response.sendRedirect("departments");
                    return;
                }

                // check if dept has employees
                if (deptDAO.hasEmployees(id)) {
                    request.getSession().setAttribute("toast_msg", dept.getName() + " has employees — " + "reassign them before deleting");
                    request.getSession().setAttribute("toast_type", "warn");
                    response.sendRedirect("departments");
                    return;
                }
                boolean deleted = deptDAO.delete(id);
                if (deleted) {
                    logDAO.log("DELETE", "Department " + dept.getName() + " was deleted", dept.getName());
                    request.getSession().setAttribute("toast_msg", dept.getName() + " department deleted successfully");
                    request.getSession().setAttribute("toast_type", "error");
                } else {
                    request.getSession().setAttribute("toast_msg", "Failed to delete. Try again.");
                    request.getSession().setAttribute("toast_type", "error");
                }
                response.sendRedirect("departments");

            // ── Update department ─────────────────
            } else if ("update".equals(action)) {
                String idStr = request.getParameter("id");
                String name = request.getParameter("name");
                String desc = request.getParameter("description");
                int id = Integer.parseInt(idStr);

                // validate name not empty
                if (name == null || name.trim().isEmpty()) {
                    request.getSession().setAttribute("toast_msg", "Department name cannot be empty");
                    request.getSession().setAttribute("toast_type", "error");
                    response.sendRedirect("departments");
                    return;
                }

                // check duplicate name excluding current
                if (deptDAO.nameExists(name.trim(), id)) {
                    request.getSession().setAttribute("toast_msg", "Department" + name + "already exists");
                    request.getSession().setAttribute("toast_type", "error");
                    response.sendRedirect("departments");
                    return;
                }
                boolean updated = deptDAO.update(id, name.trim(), desc != null ? desc.trim() : "");
                if (updated) {
                    logDAO.log("EDIT", "Department " + name + " was updated", name);
                    request.getSession().setAttribute("toast_msg", name + "department updated successfully");
                    request.getSession().setAttribute("toast_type", "success");
                } else {
                    request.getSession().setAttribute("toast_msg", "Failed to update. Try again.");
                    request.getSession().setAttribute("toast_type", "error");
                }
                response.sendRedirect("departments");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}