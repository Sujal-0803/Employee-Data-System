package com.eds.dao;

import com.eds.model.Employee;
import com.eds.util.DBConnection;
import java.sql.*;
import java.util.*;

public class EmployeeDAO {
    // ── Get all employees ──
    public List<Employee> getAll() throws Exception {
        List<Employee> list = new ArrayList<>();
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        String sql = "SELECT e.*, d.name AS dept_name " + "FROM employees e " + "LEFT JOIN departments d ON e.dept_id = d.id " + "ORDER BY e.created_at DESC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) list.add(mapRow(rs));
        rs.close(); ps.close(); conn.close();
        return list;
    }

    // ── Get single employee by ID ──
    public Employee getById(int id) throws Exception {
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        String sql = "SELECT e.*, d.name AS dept_name " + "FROM employees e " + "LEFT JOIN departments d ON e.dept_id = d.id " + "WHERE e.id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        Employee e = null;
        if (rs.next()) e = mapRow(rs);
        rs.close(); ps.close(); conn.close();
        return e;
    }

    // ── Add new employee ──
    public boolean add(Employee e) throws Exception {
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        String sql = "INSERT INTO employees" + "(name, email, phone, dept_id, designation," + "salary, join_date, address, status)" + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, e.getName());
        ps.setString(2, e.getEmail());
        ps.setString(3, e.getPhone());
        ps.setInt(4, e.getDeptId());
        ps.setString(5, e.getDesignation());
        ps.setDouble(6, e.getSalary());
        ps.setDate(7, e.getJoinDate());
        ps.setString(8, e.getAddress());
        ps.setString(9, e.getStatus());
        int result = ps.executeUpdate();
        ps.close(); conn.close();
        return result > 0;
    }

    // ── Update employee ───
    public boolean update(Employee e) throws Exception {
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        String sql = "UPDATE employees SET " + "name=?, email=?, phone=?, dept_id=?, designation=?, " + "salary=?, join_date=?, address=?, status=? " + "WHERE id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, e.getName());
        ps.setString(2, e.getEmail());
        ps.setString(3, e.getPhone());
        ps.setInt(4, e.getDeptId());
        ps.setString(5, e.getDesignation());
        ps.setDouble(6, e.getSalary());
        ps.setDate(7, e.getJoinDate());
        ps.setString(8, e.getAddress());
        ps.setString(9, e.getStatus());
        ps.setInt(10, e.getId());
        int result = ps.executeUpdate();
        ps.close(); conn.close();
        return result > 0;
    }

    // ── Delete employee ───
    public boolean delete(int id) throws Exception {
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        String sql = "DELETE FROM employees WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        int result = ps.executeUpdate();
        ps.close(); conn.close();
        return result > 0;
    }

    // ── Search + filter + paginate ──
    public List<Employee> search(String keyword, String dept, String status, int page, int perPage) throws Exception {
        List<Employee> list = new ArrayList<>();
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        StringBuilder sql = new StringBuilder("SELECT e.*, d.name AS dept_name " + "FROM employees e " + "LEFT JOIN departments d ON e.dept_id = d.id WHERE 1=1 ");
        if (keyword != null && !keyword.isEmpty())
            sql.append("AND (e.name LIKE ? OR e.email LIKE ?) ");
        if (dept != null && !dept.isEmpty())
            sql.append("AND d.name = ? ");
        if (status != null && !status.isEmpty())
            sql.append("AND e.status = ? ");
        sql.append("ORDER BY e.created_at DESC LIMIT ? OFFSET ?");
        PreparedStatement ps = conn.prepareStatement(sql.toString());
        int i = 1;
        if (keyword != null && !keyword.isEmpty()) {
            ps.setString(i++, "%" + keyword + "%");
            ps.setString(i++, "%" + keyword + "%");
        }
        if (dept != null && !dept.isEmpty()) ps.setString(i++, dept);
        if (status != null && !status.isEmpty()) ps.setString(i++, status);
        ps.setInt(i++, perPage);
        ps.setInt(i, (page - 1) * perPage);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) list.add(mapRow(rs));
        rs.close(); ps.close(); conn.close();
        return list;
    }

    // ── Count for pagination ──
    public int count(String keyword, String dept, String status) throws Exception {
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM employees e " + "LEFT JOIN departments d ON e.dept_id = d.id WHERE 1=1 ");
        if (keyword != null && !keyword.isEmpty())
            sql.append("AND (e.name LIKE ? OR e.email LIKE ?) ");
        if (dept != null && !dept.isEmpty())
            sql.append("AND d.name = ? ");
        if (status != null && !status.isEmpty())
            sql.append("AND e.status = ? ");
        PreparedStatement ps = conn.prepareStatement(sql.toString());
        int i = 1;
        if (keyword != null && !keyword.isEmpty()) {
            ps.setString(i++, "%" + keyword + "%");
            ps.setString(i++, "%" + keyword + "%");
        }
        if (dept != null && !dept.isEmpty()) ps.setString(i++, dept);
        if (status != null && !status.isEmpty()) ps.setString(i++, status);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        if (rs.next()) count = rs.getInt(1);
        rs.close(); ps.close(); conn.close();
        return count;
    }

    // ── Count by status for dashboard ──
    public int countByStatus(String status) throws Exception {
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        String sql = "SELECT COUNT(*) FROM employees WHERE status = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, status);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        if (rs.next()) count = rs.getInt(1);
        rs.close(); ps.close(); conn.close();
        return count;
    }

    // ── Toggle Active / Inactive ──
    public boolean toggleStatus(int id) throws Exception {
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        String sql = "UPDATE employees SET status = " + "CASE WHEN status='Active' THEN 'Inactive' " + "ELSE 'Active' END WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        int result = ps.executeUpdate();
        ps.close(); conn.close();
        return result > 0;
    }

    // ── Email exists check ──
    public boolean emailExists(String email, int excludeId) throws Exception {
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        String sql = "SELECT COUNT(*) FROM employees " + "WHERE email = ? AND id != ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, email);
        ps.setInt(2, excludeId);
        ResultSet rs = ps.executeQuery();
        boolean exists = false;
        if (rs.next()) exists = rs.getInt(1) > 0;
        rs.close(); ps.close(); conn.close();
        return exists;
    }

    // ── Salary by dept for chart ──
    public Map<String, double[]> getSalaryByDept() throws Exception {
        Map<String, double[]> result = new LinkedHashMap<>();
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        String sql = "SELECT d.name, " + "COALESCE(AVG(e.salary), 0) AS avg_sal, " + "COUNT(e.id) AS cnt " + "FROM departments d " + "LEFT JOIN employees e ON d.id = e.dept_id " + "GROUP BY d.name ORDER BY d.name";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            result.put(rs.getString("name"),
                new double[]{
                    rs.getDouble("avg_sal"),
                    rs.getInt("cnt")
                });
        }
        rs.close(); ps.close(); conn.close();
        return result;
    }

    // ── Recent employees for dashboard ──
    public List<Employee> getRecent(int limit) throws Exception {
        List<Employee> list = new ArrayList<>();
        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_db", "root", "Root@1234");
        String sql = "SELECT e.*, d.name AS dept_name " + "FROM employees e " + "LEFT JOIN departments d ON e.dept_id = d.id " + "ORDER BY e.created_at DESC LIMIT ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, limit);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) list.add(mapRow(rs));
        rs.close(); ps.close(); conn.close();
        return list;
    }

    // ── Map row to Employee object ──
    private Employee mapRow(ResultSet rs) throws Exception {
        Employee e = new Employee();
        e.setId(rs.getInt("id"));
        e.setName(rs.getString("name"));
        e.setEmail(rs.getString("email"));
        e.setPhone(rs.getString("phone"));
        e.setDeptId(rs.getInt("dept_id"));
        e.setDeptName(rs.getString("dept_name"));
        e.setDesignation(rs.getString("designation"));
        e.setSalary(rs.getDouble("salary"));
        e.setJoinDate(rs.getDate("join_date"));
        e.setAddress(rs.getString("address"));
        e.setStatus(rs.getString("status"));
        return e;
    }
}