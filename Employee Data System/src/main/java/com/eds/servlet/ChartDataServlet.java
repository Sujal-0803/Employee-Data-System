package com.eds.servlet;

import com.eds.dao.EmployeeDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

public class ChartDataServlet extends HttpServlet {
    // ── GET — return JSON for Chart.js ───────────
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // ── Load salary data from DB ──────────
            EmployeeDAO empDAO = new EmployeeDAO();
            Map <String, double[]> data = empDAO.getSalaryByDept();

            // ── Build JSON manually ───────────────
            StringBuilder labels = new StringBuilder("[");
            StringBuilder salaries = new StringBuilder("[");
            StringBuilder counts = new StringBuilder("[");
            for (Map.Entry<String, double[]> entry : data.entrySet()) {
                labels.append("\"").append(entry.getKey()).append("\",");
                salaries.append(Math.round(entry.getValue()[0])).append(",");
                counts.append((int) entry.getValue()[1]).append(",");
            }

            // ── Remove trailing commas ────────────
            if (labels.length() > 1)
                labels.deleteCharAt(labels.length() - 1);
            if (salaries.length() > 1)
                salaries.deleteCharAt(salaries.length() - 1);
            if (counts.length() > 1)
                counts.deleteCharAt(counts.length() - 1);

            labels.append("]");
            salaries.append("]");
            counts.append("]");

            // ── Also get active/inactive count ────
            int active = empDAO.countByStatus("Active");
            int inactive = empDAO.countByStatus("Inactive");

            // ── Build final JSON string ───────────
            String json = "{" + "\"labels\":"   + labels   + "," + "\"salaries\":" + salaries + "," + "\"counts\":"   + counts   + "," + "\"active\":"   + active   + ","
                + "\"inactive\":" + inactive + "}";

            // ── Set response as JSON ──────────────
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter pw = response.getWriter();
            pw.print(json);
            pw.flush();
            pw.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("application/json");
            response.getWriter().print("{\"error\":\"Failed to load chart data\"}");
        }
    }
}