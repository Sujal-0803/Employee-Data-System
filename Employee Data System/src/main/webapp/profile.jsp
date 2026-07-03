<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.eds.model.Employee" %>
<%@ page import="com.eds.model.ActivityLog" %>
<%@ page import="java.util.List" %>

<%
    request.setAttribute("currentPage", "employees");

    Employee emp  = (Employee)request.getAttribute("emp");
    List<ActivityLog> logs = (List<ActivityLog>)request.getAttribute("logs");
%>

<%@ include file="navbar.jsp" %>

<!-- ── Page header ── -->
<div class="sec-head">
    <h3>Employee profile</h3>
    <div class="sec-head-right">
        <% if (emp != null) { %>

        <!-- Edit button -->
        <a href="edit?id=<%= emp.getId() %>"
           class="btn btn-outline btn-sm">
            <i class="ti ti-edit"></i>
            Edit
        </a>

        <!-- Print button -->
        <button class="btn btn-outline btn-sm"
                onclick="printProfile()">
            <i class="ti ti-printer"></i>
            Print
        </button>

        <!-- Delete button -->
        <button class="btn btn-danger btn-sm"
                onclick="showDeleteModal(
                    '<%= emp.getId() %>',
                    '<%= emp.getName() %>',
                    'delete-form')">
            <i class="ti ti-trash"></i>
            Delete
        </button>

        <% } %>
    </div>
</div>

<% if (emp != null) { %>

<!-- ── Profile layout ───────────────────────── -->
<div class="profile-wrap">

    <!-- ── Left card ────────────────────────── -->
    <div class="profile-left">

        <!-- Avatar -->
        <div class="profile-avatar">
            <%= emp.getInitials() %>
        </div>

        <!-- Name and role -->
        <div class="profile-name">
            <%= emp.getName() %>
        </div>
        <div class="profile-role">
            <%= emp.getDesignation() != null
                ? emp.getDesignation() : "-" %>
        </div>

        <!-- Status badge -->
        <form action="toggle-status"
              method="post"
              style="display:inline">
            <input type="hidden"
                   name="id"
                   value="<%= emp.getId() %>">
            <input type="hidden"
                   name="redirectTo"
                   value="profile">
            <button type="submit"
                    class="badge
                    <%= "Active".equals(emp.getStatus())
                        ? "badge-active"
                        : "badge-inactive" %>"
                    title="Click to toggle status">
                <%= emp.getStatus() %>
            </button>
        </form>

        <hr class="divider">

        <!-- Department -->
        <div style="margin-bottom:12px">
            <div style="font-size:10px;
                        color:var(--dim);
                        text-transform:uppercase;
                        letter-spacing:.06em;
                        margin-bottom:4px">
                Department
            </div>
            <div style="font-size:13px;
                        font-weight:600;
                        color:var(--accent)">
                <%= emp.getDeptName() != null
                    ? emp.getDeptName() : "-" %>
            </div>
        </div>

        <!-- Salary -->
        <div style="margin-bottom:16px">
            <div style="font-size:10px;
                        color:var(--dim);
                        text-transform:uppercase;
                        letter-spacing:.06em;
                        margin-bottom:4px">
                Monthly salary
            </div>
            <div style="font-size:18px;
                        font-weight:700;
                        color:var(--accent)">
                ₹<%= String.format("%,.0f", emp.getSalary()) %>
            </div>
        </div>

        <hr class="divider">

        <!-- Employee ID -->
        <div style="font-size:11px;
                    color:var(--dim);
                    margin-bottom:8px">
            <i class="ti ti-hash"></i>
            EMP-<%= String.format("%03d", emp.getId()) %>
        </div>

        <!-- Action buttons -->
        <div style="display:flex;
                    flex-direction:column;
                    gap:6px;
                    margin-top:8px">

            <a href="edit?id=<%= emp.getId() %>"
               class="btn btn-outline btn-sm"
               style="width:100%;
                      justify-content:center">
                <i class="ti ti-edit"></i>
                Edit profile
            </a>

            <button class="btn btn-danger btn-sm"
                    style="width:100%;
                           justify-content:center"
                    onclick="showDeleteModal(
                        '<%= emp.getId() %>',
                        '<%= emp.getName() %>',
                        'delete-form')">
                <i class="ti ti-trash"></i>
                Delete employee
            </button>

        </div>
    </div>

    <!-- ── Right card ───────────────────────── -->
    <div class="profile-right">

        <!-- Section title -->
        <div style="font-size:12px;
                    font-weight:600;
                    color:var(--text);
                    margin-bottom:14px;
                    padding-bottom:10px;
                    border-bottom:1px solid var(--border)">
            Contact &amp; details
        </div>

        <!-- Profile fields grid -->
        <div class="profile-fields">

            <div class="profile-field">
                <label>Email</label>
                <p><%= emp.getEmail() %></p>
            </div>

            <div class="profile-field">
                <label>Phone</label>
                <p><%= emp.getPhone() != null
                        ? emp.getPhone() : "-" %></p>
            </div>

            <div class="profile-field">
                <label>Join date</label>
                <p><%= emp.getJoinDate() != null
                        ? emp.getJoinDate() : "-" %></p>
            </div>

            <div class="profile-field">
                <label>Employee ID</label>
                <p class="accent">
                    #EMP-<%= String.format("%03d", emp.getId()) %>
                </p>
            </div>

            <div class="profile-field"
                 style="grid-column:span 2">
                <label>Address</label>
                <p><%= emp.getAddress() != null
                        && !emp.getAddress().isEmpty()
                        ? emp.getAddress() : "-" %></p>
            </div>

        </div>

        <hr class="divider">

        <!-- Activity log for this employee -->
        <div style="font-size:12px;
                    font-weight:600;
                    color:var(--text);
                    margin-bottom:12px">
            Activity on this employee
        </div>

        <div class="log-feed">
            <% if (logs != null && !logs.isEmpty()) {
                   for (ActivityLog log : logs) { %>
            <div class="log-item">
                <div class="log-dot"
                     style="background:<%= log.getDotColor() %>">
                </div>
                <div class="log-msg">
                    <%= log.getMessage() %>
                </div>
                <div class="log-time">
                    <%= log.getFormattedTime() %>
                </div>
            </div>
            <%     }
               } else { %>
            <div class="empty-state">
                <i class="ti ti-history"></i>
                No activity recorded yet
            </div>
            <% } %>
        </div>

    </div>

</div>

<% } else { %>
<!-- ── Employee not found ────────────────────── -->
<div class="empty-state"
     style="padding:60px">
    <i class="ti ti-user-off"></i>
    Employee not found.
    <a href="employees"
       style="color:var(--accent)">
        Go back to list
    </a>
</div>
<% } %>

<!-- ── Print styles ──────────────────────────── -->
<style>
@media print {
    .sidebar,
    .topbar,
    .sec-head .sec-head-right,
    .log-feed,
    footer,
    .modal-overlay,
    .toast-container {
        display: none !important;
    }
    .profile-wrap {
        grid-template-columns: 200px 1fr;
    }
    body {
        background: white !important;
        color: black !important;
    }
}
</style>

<%@ include file="footer.jsp" %>