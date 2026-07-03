package com.eds.servlet;

import com.eds.dao.EmployeeDAO;
import com.eds.model.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class ExportCSVServlet extends HttpServlet {
    // ── GET — download employee list as CSV ──────
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // ── Read filter params ────────────────
            String keyword = request.getParameter("keyword");
            String dept = request.getParameter("dept");
            String status = request.getParameter("status");

            // ── Clean up params ───────────────────
            if (keyword != null && keyword.trim().isEmpty())
                keyword = null;
            if (dept != null && dept.trim().isEmpty())
                dept = null;
            if (status != null && status.trim().isEmpty())
                status = null;

            // ── Load all matching employees ───────
            EmployeeDAO empDAO = new EmployeeDAO();
            int totalCount = empDAO.count(keyword, dept, status);
            List <Employee> employees = empDAO.search(keyword, dept, status, 1, totalCount);

            // ── Set response headers for download ─
            response.setContentType("text/csv");
            response.setCharacterEncoding("UTF-8");
            response.setHeader("Content-Disposition", "attachment; filename=\"employees.csv\"");

            // ── Write CSV content ─────────────────
            PrintWriter pw = response.getWriter();
            pw.println("ID,Name,Email,Phone,Department," + "Designation,Salary,Join Date," + "Address,Status");
            // data rows
            for (Employee emp : employees) {
                pw.println(emp.getId() + "," + escapeCsv(emp.getName()) + "," + escapeCsv(emp.getEmail()) + "," + escapeCsv(emp.getPhone()) + "," + 
                escapeCsv(emp.getDeptName()) + "," + escapeCsv(emp.getDesignation()) + "," + emp.getSalary() + "," + emp.getJoinDate() + "," + escapeCsv(emp.getAddress()) + "," + escapeCsv(emp.getStatus()));
            }
            pw.flush();
            pw.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // ── Escape special CSV characters ────────────
    private String escapeCsv(String value) {
        if (value == null) 
        	return "";
        if (value.contains(",") || value.contains("\"") || value.contains("\n")) { value = value.replace("\"", "\"\"");
            return "\"" + value + "\"";
        }
        return value;
    }
}