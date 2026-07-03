package com.eds.dao;

import com.eds.model.ActivityLog;
import java.sql.*;
import java.util.*;

public class ActivityLogDAO {
    // ── Add a new log entry ──────────────────────
    public boolean log(String action, String message,
                       String empName) throws Exception {
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        String sql = "INSERT INTO activity_log " + "(action, message, emp_name) VALUES (?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, action);
        ps.setString(2, message);
        ps.setString(3, empName);
        int result = ps.executeUpdate();
        ps.close(); conn.close();
        return result > 0;
    }

    // ── Get recent logs for dashboard ────────────
    public List<ActivityLog> getRecent(int limit) throws Exception {
        List<ActivityLog> list = new ArrayList<>();
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        String sql = "SELECT * FROM activity_log " + "ORDER BY created_at DESC LIMIT ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, limit);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) list.add(mapRow(rs));
        rs.close(); ps.close(); conn.close();
        return list;
    }

    // ── Get logs for a specific employee ─────────
    public List<ActivityLog> getByEmployee(String empName,
                                           int limit) throws Exception {
        List<ActivityLog> list = new ArrayList<>();
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        String sql = "SELECT * FROM activity_log " + "WHERE emp_name = ? " + "ORDER BY created_at DESC LIMIT ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, empName);
        ps.setInt   (2, limit);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) list.add(mapRow(rs));
        rs.close(); ps.close(); conn.close();
        return list;
    }

    // ── Map row to ActivityLog object ──
    private ActivityLog mapRow(ResultSet rs) throws Exception {
        ActivityLog log = new ActivityLog();
        log.setId(rs.getInt("id"));
        log.setAction(rs.getString("action"));
        log.setMessage(rs.getString("message"));
        log.setEmpName(rs.getString("emp_name"));
        log.setCreatedAt(rs.getTimestamp("created_at"));
        return log;
    }
}