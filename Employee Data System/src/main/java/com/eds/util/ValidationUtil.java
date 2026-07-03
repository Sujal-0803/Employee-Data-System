package com.eds.util;

import com.eds.dao.EmployeeDAO;
import com.eds.model.Employee;
import java.util.*;

public class ValidationUtil {
    // ── Validate employee form fields ────────────
    public static Map<String, String> validate(Employee e, boolean isUpdate) {
        Map<String, String> errors = new LinkedHashMap<>();
        // ── Name ──────────────────────────────────
        if (e.getName() == null || e.getName().trim().isEmpty()) {
            errors.put("name", "Name cannot be empty");
        } else if (e.getName().trim().length() < 2) {
            errors.put("name", "Name must be at least 2 characters");
        } else if (e.getName().trim().length() > 100) {
            errors.put("name", "Name must be less than 100 characters");
        } else if (!e.getName().trim().matches("[a-zA-Z ]+")) {
            errors.put("name", "Name can only contain letters and spaces");
        }

        // ── Email ─────────────────────────────────
        if (e.getEmail() == null || e.getEmail().trim().isEmpty()) {
              errors.put("email", "Email cannot be empty");
        } else if (!e.getEmail().trim().matches("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")) {
              errors.put("email", "Enter a valid email address");
        } else {
            // check duplicate email in DB
            try {
                EmployeeDAO dao = new EmployeeDAO();
                int excludeId = isUpdate ? e.getId() : 0;
                if (dao.emailExists(e.getEmail().trim(), excludeId)) {
                    errors.put("email", "This email already exists");
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }

        // ── Phone ─────────────────────────────────
        if (e.getPhone() == null || e.getPhone().trim().isEmpty()) {
            errors.put("phone", "Phone cannot be empty");
        } else if (!e.getPhone().trim().matches("\\d{10}")) {
            errors.put("phone", "Phone must be exactly 10 digits");
        } else if (!e.getPhone().trim().matches("[6-9]\\d{9}")) {
            errors.put("phone", "Phone must start with 6, 7, 8 or 9");
        }

        // ── Department ────────────────────────────
        if (e.getDeptId() <= 0) {
            errors.put("dept", "Please select a department");
        }

        // ── Designation ───────────────────────────
        if (e.getDesignation() == null ||
            e.getDesignation().trim().isEmpty()) {
            errors.put("designation", "Designation cannot be empty");
        } else if (e.getDesignation().trim().length() > 100) {
            errors.put("designation", "Designation must be less than 100 characters");
        }

        // ── Salary ────────────────────────────────
        if (e.getSalary() <= 0) {
            errors.put("salary", "Salary must be greater than 0");
        } else if (e.getSalary() > 9999999) {
            errors.put("salary", "Salary value is too high");
        }

        // ── Join Date ─────────────────────────────
        if (e.getJoinDate() == null) {
            errors.put("joinDate", "Join date cannot be empty");
        } else {
            java.util.Date today = new java.util.Date();
            if (e.getJoinDate().after(today)) {
                errors.put("joinDate", "Join date cannot be in the future");
            }
            java.util.Calendar cal = java.util.Calendar.getInstance();
            cal.set(2000, 0, 1);
            if (e.getJoinDate().before(cal.getTime())) {
                errors.put("joinDate", "Join date cannot be before year 2000");
            }
        }
        return errors;
    }
}