package com.eds.dao;

import com.eds.model.Department;
import java.sql.*;
import java.util.*;

public class DepartmentDAO {
    // ── Get all departments ──
    public List<Department> getAll() throws Exception {
        List<Department> list = new ArrayList<>();
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        String sql = "SELECT * FROM departments ORDER BY name";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) list.add(mapRow(rs));
        rs.close(); ps.close(); conn.close();
        return list;
    }

    // ── Get all departments with employee count ──
    public List<Department> getAllWithCount() throws Exception {
        List<Department> list = new ArrayList<>();
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        String sql = "SELECT d.*, COUNT(e.id) AS emp_count " + "FROM departments d " + "LEFT JOIN employees e ON d.id = e.dept_id " + "GROUP BY d.id ORDER BY d.name";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Department dept = mapRow(rs);
            dept.setEmployeeCount(rs.getInt("emp_count"));
            list.add(dept);
        }
        rs.close(); ps.close(); conn.close();
        return list;
    }

    // ── Get single department by ID ──
    public Department getById(int id) throws Exception {
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        String sql = "SELECT * FROM departments WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        Department dept = null;
        if (rs.next()) dept = mapRow(rs);
        rs.close(); ps.close(); conn.close();
        return dept;
    }

    // ── Add new department ──
    public boolean add(String name, String description) throws Exception {
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        String sql = "INSERT INTO departments (name, description) VALUES (?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, name);
        ps.setString(2, description);
        int result = ps.executeUpdate();
        ps.close(); conn.close();
        return result > 0;
    }

    // ── Update department ──
    public boolean update(int id, String name, String description) throws Exception {
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        String sql = "UPDATE departments SET name=?, description=? WHERE id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, name);
        ps.setString(2, description);
        ps.setInt   (3, id);
        int result = ps.executeUpdate();
        ps.close(); conn.close();
        return result > 0;
    }

    // ── Delete department ──
    public boolean delete(int id) throws Exception {
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        String sql = "DELETE FROM departments WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        int result = ps.executeUpdate();
        ps.close(); conn.close();
        return result > 0;
    }

    // ── Check if department has employees ──
    public boolean hasEmployees(int id) throws Exception {
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        String sql = "SELECT COUNT(*) FROM employees WHERE dept_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        boolean has = false;
        if (rs.next()) has = rs.getInt(1) > 0;
        rs.close(); ps.close(); conn.close();
        return has;
    }

    // ── Check if department name already exists ──
    public boolean nameExists(String name, int excludeId) throws Exception {
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        String sql = "SELECT COUNT(*) FROM departments " + "WHERE name = ? AND id != ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, name);
        ps.setInt   (2, excludeId);
        ResultSet rs = ps.executeQuery();
        boolean exists = false;
        if (rs.next()) exists = rs.getInt(1) > 0;
        rs.close(); ps.close(); conn.close();
        return exists;
    }

    // ── Count total departments ──
    public int count() throws Exception {
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        String sql = "SELECT COUNT(*) FROM departments";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        if (rs.next()) count = rs.getInt(1);
        rs.close(); ps.close(); conn.close();
        return count;
    }

    // ── Map row to Department object ──
    private Department mapRow(ResultSet rs) throws Exception {
        Department dept = new Department();
        dept.setId(rs.getInt("id"));
        dept.setName(rs.getString("name"));
        dept.setDescription(rs.getString("description"));
        return dept;
    }
}