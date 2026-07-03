package com.eds.model;

import java.sql.Date;

public class Employee {

    private int id;
    private String name;
    private String email;
    private String phone;
    private int deptId;
    private String deptName;
    private String designation;
    private double salary;
    private Date joinDate;
    private String address;
    private String status;

    // ── Constructors ────────────────────────────
    public Employee() {}

    public Employee(int id, String name, String email, String phone,
                    int deptId, String deptName, String designation,
                    double salary, Date joinDate, String address, String status) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.deptId = deptId;
        this.deptName = deptName;
        this.designation = designation;
        this.salary = salary;
        this.joinDate = joinDate;
        this.address = address;
        this.status = status;
    }

    // ── Getters ─────────────────────────────────
    public int getId() { return id; }
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getPhone() { return phone; }
    public int getDeptId() { return deptId; }
    public String getDeptName() { return deptName; }
    public String getDesignation() { return designation; }
    public double getSalary() { return salary; }
    public Date getJoinDate() { return joinDate; }
    public String getAddress() { return address; }
    public String getStatus() { return status; }

    // ── Setters ─────────────────────────────────
    public void setId(int id) { this.id = id; }
    public void setName(String name) { this.name = name; }
    public void setEmail(String email) { this.email = email; }
    public void setPhone(String phone) { this.phone = phone; }
    public void setDeptId(int deptId) { this.deptId = deptId; }
    public void setDeptName(String deptName) { this.deptName = deptName; }
    public void setDesignation(String d) { this.designation = d; }
    public void setSalary(double salary) { this.salary = salary; }
    public void setJoinDate(Date joinDate) { this.joinDate = joinDate; }
    public void setAddress(String address) { this.address = address; }
    public void setStatus(String status) { this.status = status; }

    // ── Helper — avatar initials ─────────────────
    public String getInitials() {
        if (name == null || name.isEmpty()) return "?";
        String[] parts = name.trim().split("\\s+");
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < Math.min(2, parts.length); i++)
            if (!parts[i].isEmpty()) sb.append(parts[i].charAt(0));
        return sb.toString().toUpperCase();
    }
}