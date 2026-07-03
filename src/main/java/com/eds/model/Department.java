package com.eds.model;

public class Department {

    private int    id;
    private String name;
    private String description;
    private int    employeeCount;

    // ── Constructors ────────────────────────────
    public Department() {}

    public Department(int id, String name, String description, int employeeCount) {
        this.id            = id;
        this.name          = name;
        this.description   = description;
        this.employeeCount = employeeCount;
    }

    // ── Getters ─────────────────────────────────
    public int    getId()            { return id; }
    public String getName()          { return name; }
    public String getDescription()   { return description; }
    public int    getEmployeeCount() { return employeeCount; }

    // ── Setters ─────────────────────────────────
    public void setId(int id)                      { this.id = id; }
    public void setName(String name)               { this.name = name; }
    public void setDescription(String description) { this.description = description; }
    public void setEmployeeCount(int count)        { this.employeeCount = count; }
}