package com.eds.model;

import java.sql.Timestamp;

public class ActivityLog {

    private int       id;
    private String    action;
    private String    message;
    private String    empName;
    private Timestamp createdAt;

    // ── Constructors ────────────────────────────
    public ActivityLog() {}

    public ActivityLog(int id, String action, String message,
                       String empName, Timestamp createdAt) {
        this.id        = id;
        this.action    = action;
        this.message   = message;
        this.empName   = empName;
        this.createdAt = createdAt;
    }

    // ── Getters ─────────────────────────────────
    public int       getId()        { return id; }
    public String    getAction()    { return action; }
    public String    getMessage()   { return message; }
    public String    getEmpName()   { return empName; }
    public Timestamp getCreatedAt() { return createdAt; }

    // ── Setters ─────────────────────────────────
    public void setId(int id)                  { this.id = id; }
    public void setAction(String action)       { this.action = action; }
    public void setMessage(String message)     { this.message = message; }
    public void setEmpName(String empName)     { this.empName = empName; }
    public void setCreatedAt(Timestamp t)      { this.createdAt = t; }

    // ── Helper — format time for display ────────
    public String getFormattedTime() {
        if (createdAt == null) return "";
        java.text.SimpleDateFormat sdf =
            new java.text.SimpleDateFormat("dd MMM yyyy, hh:mm a");
        return sdf.format(createdAt);
    }

    // ── Helper — dot color based on action ──────
    public String getDotColor() {
        if (action == null) return "#8b949e";
        switch (action.toUpperCase()) {
            case "ADD":    return "#3fb950"; // green
            case "DELETE": return "#f85149"; // red
            case "EDIT":   return "#d29922"; // amber
            default:       return "#8b949e"; // grey
        }
    }
}