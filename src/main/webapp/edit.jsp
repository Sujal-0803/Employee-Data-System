<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.eds.model.Department" %>
<%@ page import="com.eds.model.Employee" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<%
    request.setAttribute("currentPage", "employees");

    List<Department>   depts  = (List<Department>)   request.getAttribute("depts");
    Employee           emp    = (Employee)            request.getAttribute("emp");
    Map<String,String> errors = (Map<String,String>)  request.getAttribute("errors");

    // field values
    String nameVal = emp != null && emp.getName() != null ? emp.getName() : "";
    String emailVal = emp != null && emp.getEmail() != null ? emp.getEmail() : "";
    String phoneVal = emp != null && emp.getPhone() != null ? emp.getPhone() : "";
    String desigVal = emp != null && emp.getDesignation() != null ? emp.getDesignation() : "";
    String addrVal = emp != null && emp.getAddress() != null ? emp.getAddress() : "";
    String salVal = emp != null && emp.getSalary() > 0  ? String.valueOf((int) emp.getSalary()) : "";
    String dateVal = emp != null && emp.getJoinDate() != null ? emp.getJoinDate().toString()  : "";
    String statVal = emp != null && emp.getStatus() != null ? emp.getStatus() : "Active";
    int deptVal = emp != null ? emp.getDeptId() : 0;
    int empId = emp != null ? emp.getId() : 0;
%>

<%@ include file="navbar.jsp" %>

<!-- ── Page header ──────────────────────────── -->
<div class="sec-head">
    <h3>Edit employee</h3>
    <div class="sec-head-right">
        <% if (emp != null) { %>
        <a href="profile?id=<%= empId %>"
           class="btn btn-outline btn-sm">
            <i class="ti ti-eye"></i>
            View profile
        </a>
        <% } %>
        <a href="employees"
           class="btn btn-outline btn-sm">
            <i class="ti ti-arrow-left"></i>
            Back to list
        </a>
    </div>
</div>

<!-- ── Employee info banner ─────────────────── -->
<% if (emp != null) { %>
<div style="
    background:    var(--bg2);
    border:        1px solid var(--border);
    border-left:   3px solid var(--accent);
    border-radius: 8px;
    padding:       12px 16px;
    margin-bottom: 16px;
    display:       flex;
    align-items:   center;
    gap:           12px">
    <div style="
        width:           36px;
        height:          36px;
        border-radius:   50%;
        background:      rgba(99,102,241,0.15);
        border:          1px solid var(--accent);
        display:         flex;
        align-items:     center;
        justify-content: center;
        font-size:       12px;
        font-weight:     700;
        color:           var(--accent);
        flex-shrink:     0">
        <%= emp.getInitials() %>
    </div>
    <div>
        <div style="font-size:13px;
                    font-weight:600;
                    color:var(--text)">
            Editing: <%= emp.getName() %>
        </div>
        <div style="font-size:11px;
                    color:var(--muted);
                    margin-top:2px">
            ID: #EMP-<%= String.format("%03d", empId) %>
            &nbsp;·&nbsp;
            Joined: <%= dateVal %>
        </div>
    </div>
    <span class="badge
        <%= "Active".equals(statVal) ? "badge-active" : "badge-inactive" %>"
        style="margin-left:auto">
        <%= statVal %>
    </span>
</div>
<% } %>

<!-- ── Validation summary ────────────────────── -->
<% if (errors != null && !errors.isEmpty()) { %>
<div class="val-summary show">
    <div class="val-summary-title">
        <i class="ti ti-circle-x"></i>
        Fix <%= errors.size() %> error<%= errors.size() > 1 ? "s" : "" %> before saving
    </div>
    <% for (Map.Entry<String,String> err : errors.entrySet()) { %>
    <p>
        <i class="ti ti-arrow-right"></i>
        <%= err.getValue() %>
    </p>
    <% } %>
</div>
<% } %>

<!-- ── Edit form ─────────────────────────────── -->
<div class="form-card">
    <form action="edit" method="post">

        <!-- Hidden employee ID -->
        <input type="hidden" name="id" value="<%= empId %>">

        <div class="form-grid">

            <!-- Name -->
            <div class="form-group">
                <label>Full name *</label>
                <input type="text"
                       name="name"
                       placeholder="e.g. Ravi Sharma"
                       value="<%= nameVal %>"
                       class="<%= errors != null && errors.containsKey("name") ? "field-error" : "" %>"
                       oninput="liveValidate(this, 'name')">
                <% if (errors != null && errors.containsKey("name")) { %>
                <div class="field-err-msg show">
                    <i class="ti ti-circle-x" style="font-size:11px"></i>
                    <%= errors.get("name") %>
                </div>
                <% } %>
            </div>

            <!-- Email -->
            <div class="form-group">
                <label>Email *</label>
                <input type="text"
                       name="email"
                       placeholder="e.g. ravi@company.com"
                       value="<%= emailVal %>"
                       class="<%= errors != null && errors.containsKey("email") ? "field-error" : "" %>"
                       oninput="liveValidate(this, 'email')">
                <% if (errors != null && errors.containsKey("email")) { %>
                <div class="field-err-msg show">
                    <i class="ti ti-circle-x" style="font-size:11px"></i>
                    <%= errors.get("email") %>
                </div>
                <% } %>
            </div>

            <!-- Phone -->
            <div class="form-group">
                <label>Phone *</label>
                <input type="text"
                       name="phone"
                       placeholder="10-digit mobile"
                       value="<%= phoneVal %>"
                       class="<%= errors != null && errors.containsKey("phone") ? "field-error" : "" %>"
                       oninput="liveValidate(this, 'phone')">
                <% if (errors != null && errors.containsKey("phone")) { %>
                <div class="field-err-msg show">
                    <i class="ti ti-circle-x" style="font-size:11px"></i>
                    <%= errors.get("phone") %>
                </div>
                <% } %>
            </div>

            <!-- Department -->
            <div class="form-group">
                <label>Department *</label>
                <select name="deptId"
                        class="<%= errors != null && errors.containsKey("dept") ? "field-error" : "" %>">
                    <option value="">-- Select department --</option>
                    <% if (depts != null) {
                           for (Department d : depts) { %>
                    <option value="<%= d.getId() %>"
                        <%= d.getId() == deptVal ? "selected" : "" %>>
                        <%= d.getName() %>
                    </option>
                    <%     }
                       } %>
                </select>
                <% if (errors != null && errors.containsKey("dept")) { %>
                <div class="field-err-msg show">
                    <i class="ti ti-circle-x" style="font-size:11px"></i>
                    <%= errors.get("dept") %>
                </div>
                <% } %>
            </div>

            <!-- Designation -->
            <div class="form-group">
                <label>Designation *</label>
                <input type="text"
                       name="designation"
                       placeholder="e.g. Senior Developer"
                       value="<%= desigVal %>"
                       class="<%= errors != null && errors.containsKey("designation") ? "field-error" : "" %>"
                       oninput="liveValidate(this, 'designation')">
                <% if (errors != null && errors.containsKey("designation")) { %>
                <div class="field-err-msg show">
                    <i class="ti ti-circle-x" style="font-size:11px"></i>
                    <%= errors.get("designation") %>
                </div>
                <% } %>
            </div>

            <!-- Salary -->
            <div class="form-group">
                <label>Salary (₹) *</label>
                <input type="text"
                       name="salary"
                       placeholder="e.g. 85000"
                       value="<%= salVal %>"
                       class="<%= errors != null && errors.containsKey("salary") ? "field-error" : "" %>"
                       oninput="liveValidate(this, 'salary')">
                <% if (errors != null && errors.containsKey("salary")) { %>
                <div class="field-err-msg show">
                    <i class="ti ti-circle-x" style="font-size:11px"></i>
                    <%= errors.get("salary") %>
                </div>
                <% } %>
            </div>

            <!-- Join Date -->
            <div class="form-group">
                <label>Join date *</label>
                <input type="date"
                       name="joinDate"
                       value="<%= dateVal %>"
                       class="<%= errors != null && errors.containsKey("joinDate") ? "field-error" : "" %>">
                <% if (errors != null && errors.containsKey("joinDate")) { %>
                <div class="field-err-msg show">
                    <i class="ti ti-circle-x" style="font-size:11px"></i>
                    <%= errors.get("joinDate") %>
                </div>
                <% } %>
            </div>

            <!-- Status -->
            <div class="form-group">
                <label>Status</label>
                <select name="status">
                    <option value="Active"
                        <%= "Active".equals(statVal) ? "selected" : "" %>>
                        Active
                    </option>
                    <option value="Inactive"
                        <%= "Inactive".equals(statVal) ? "selected" : "" %>>
                        Inactive
                    </option>
                </select>
            </div>

            <!-- Address -->
            <div class="form-group" style="grid-column:span 2">
                <label>Address</label>
                <textarea name="address"
                          placeholder="City, State"
                          rows="2"><%= addrVal %></textarea>
            </div>

        </div>

        <!-- ── Form actions ──────────────────── -->
        <div class="form-actions">
            <button type="submit"
                    class="btn btn-primary">
                <i class="ti ti-check"></i>
                Update employee
            </button>
            <% if (emp != null) { %>
            <a href="profile?id=<%= empId %>"
               class="btn btn-outline">
                Cancel
            </a>
            <% } else { %>
            <a href="employees"
               class="btn btn-outline">
                Cancel
            </a>
            <% } %>
        </div>

    </form>
</div>

<!-- ── Client side live validation ──────────── -->
<script>
function liveValidate(input, field) {
    var val = input.value.trim();
    var err = null;

    if (field === 'name') {
        if (!val)                err = 'Name cannot be empty';
        else if (val.length < 2) err = 'Min 2 characters';
        else if (!/^[a-zA-Z\s]+$/.test(val))
                                 err = 'Letters and spaces only';
    }
    else if (field === 'email') {
        if (!val) err = 'Email cannot be empty';
        else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(val))
                  err = 'Enter a valid email';
    }
    else if (field === 'phone') {
        if (!val) err = 'Phone cannot be empty';
        else if (!/^\d{10}$/.test(val))
                  err = 'Must be exactly 10 digits';
        else if (!/^[6-9]/.test(val))
                  err = 'Must start with 6, 7, 8 or 9';
    }
    else if (field === 'designation') {
        if (!val) err = 'Designation cannot be empty';
    }
    else if (field === 'salary') {
        if (!val)            err = 'Salary cannot be empty';
        else if (isNaN(val)) err = 'Must be a valid number';
        else if (parseFloat(val) <= 0)
                             err = 'Must be greater than 0';
    }

    var parent  = input.parentNode;
    var errDiv  = parent.querySelector('.field-err-msg');
    var errSpan = errDiv ? errDiv.querySelector('span') : null;

    if (err) {
        input.classList.add('field-error');
        input.classList.remove('field-ok');
        if (errDiv) {
            errDiv.classList.add('show');
            if (errSpan) errSpan.textContent = err;
        }
    } else {
        input.classList.remove('field-error');
        input.classList.add('field-ok');
        if (errDiv) errDiv.classList.remove('show');
    }
}
</script>

<%@ include file="footer.jsp" %>