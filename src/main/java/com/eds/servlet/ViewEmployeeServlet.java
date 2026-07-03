package com.eds.servlet;

import com.eds.dao.DepartmentDAO;
import com.eds.dao.EmployeeDAO;
import com.eds.model.Department;
import com.eds.model.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class ViewEmployeeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // ── Read search and filter params ─────
            String keyword = request.getParameter("keyword");
            String dept    = request.getParameter("dept");
            String status  = request.getParameter("status");
            String pageStr = request.getParameter("page");

            // ── Clean up params ───────────────────
            if (keyword != null) keyword = keyword.trim();
            if (dept   != null && dept.isEmpty())   dept   = null;
            if (status != null && status.isEmpty()) status = null;

            // ── Pagination ────────────────────────
            int perPage = 5;
            int page    = 1;
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1;
            } catch (NumberFormatException ex) {
                page = 1;
            }

            // ── Load employees from DB ────────────
            EmployeeDAO    empDAO = new EmployeeDAO();
            List<Employee> employees = empDAO.search(
                    keyword, dept, status, page, perPage);

            // ── Total count for pagination ────────
            int totalCount = empDAO.count(keyword, dept, status);
            int totalPages = (int) Math.ceil(
                    (double) totalCount / perPage);
            if (totalPages < 1) totalPages = 1;

            // ── Load departments for filter ───────
            DepartmentDAO    deptDAO = new DepartmentDAO();
            List<Department> depts   = deptDAO.getAll();

            // ── Toast flash message ───────────────
            String toastMsg  = (String) request.getSession()
                                .getAttribute("toast_msg");
            String toastType = (String) request.getSession()
                                .getAttribute("toast_type");
            if (toastMsg != null) {
                request.setAttribute("toast_msg",  toastMsg);
                request.setAttribute("toast_type", toastType);
                request.getSession().removeAttribute("toast_msg");
                request.getSession().removeAttribute("toast_type");
            }

            // ── Set all attributes ────────────────
            request.setAttribute("employees",       employees);
            request.setAttribute("depts",           depts);
            request.setAttribute("totalCount",      totalCount);
            request.setAttribute("totalPages",      totalPages);
            request.setAttribute("pageNum",         page);      // ← pageNum
            request.setAttribute("keyword",         keyword);
            request.setAttribute("selectedDept",    dept);
            request.setAttribute("selectedStatus",  status);

            // ── Forward to JSP ────────────────────
            request.getRequestDispatcher("employees.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}