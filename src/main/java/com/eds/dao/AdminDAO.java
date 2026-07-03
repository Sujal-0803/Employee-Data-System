package com.eds.dao;

import com.eds.model.Admin;
import java.sql.*;

public class AdminDAO {
    // ── Check login credentials ──────────────────
    public Admin login(String username, String password) throws Exception {
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        String sql = "SELECT * FROM admin " + "WHERE username = ? AND password = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, username);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();
        Admin admin = null;
        if (rs.next()) {
            admin = new Admin();
            admin.setId (rs.getInt("id"));
            admin.setUsername(rs.getString("username"));
            admin.setPassword(rs.getString("password"));
        }
        rs.close(); ps.close(); conn.close();
        return admin;
    }

    // ── Check if username exists ──
    public boolean usernameExists(String username) throws Exception {
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        String sql = "SELECT COUNT(*) FROM admin " + "WHERE username = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        boolean exists = false;
        if (rs.next()) exists = rs.getInt(1) > 0;
        rs.close(); ps.close(); conn.close();
        return exists;
    }
}