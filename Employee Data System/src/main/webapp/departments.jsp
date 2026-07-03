<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.eds.model.Department" %>
<%@ page import="java.util.List" %>

<%
    request.setAttribute("currentPage", "departments");

    List<Department> depts = (List<Department>) request.getAttribute("depts");
%>

<%@ include file="navbar.jsp" %>

<!-- ── Page header ─── -->
<div class="sec-head">
    <h3>Departments</h3>
    <div class="sec-head-right">

        <!-- Add department button -->
        <button class="btn btn-primary btn-sm"
                onclick="toggleAddForm()">
            <i class="ti ti-plus"></i>
            Add department
        </button>

    </div>
</div>

<!-- ── Add department form ───────────────────── -->
<div id="add-dept-form"
     style="display:none;
            margin-bottom:16px">
    <div class="form-card">
        <form action="departments" method="post">
            <input type="hidden" name="action" value="add">

            <div class="form-grid">

                <!-- Name -->
                <div class="form-group">
                    <label>Department name *</label>
                    <input type="text"
                           name="name"
                           id="dept-name"
                           placeholder="e.g. Engineering"
                           required>
                </div>

                <!-- Description -->
                <div class="form-group">
                    <label>Description</label>
                    <input type="text"
                           name="description"
                           placeholder="e.g. Software development team">
                </div>

            </div>

            <div class="form-actions">
                <button type="submit"
                        class="btn btn-primary">
                    <i class="ti ti-check"></i>
                    Save department
                </button>
                <button type="button"
                        class="btn btn-outline"
                        onclick="toggleAddForm()">
                    Cancel
                </button>
            </div>

        </form>
    </div>
</div>

<!-- ── Department cards ─────────────────────── -->
<% String[] accentColors = {
    "#6366F1", "#8B5CF6", "#F59E0B",
    "#F43F5E", "#0EA5E9", "#10B981"
}; %>

<div class="dept-grid">
    <% if (depts != null && !depts.isEmpty()) {
           int colorIdx = 0;
           for (Department dept : depts) {
               String color = accentColors[colorIdx % accentColors.length];
               colorIdx++; %>

    <div class="dept-card"
         style="border-left-color:<%= color %>">

        <!-- Dept name and description -->
        <h4><%= dept.getName() %></h4>
        <p><%= dept.getDescription() != null
               && !dept.getDescription().isEmpty()
               ? dept.getDescription()
               : "No description" %></p>

        <!-- Employee count -->
        <div class="dept-count"
             style="color:<%= color %>">
            <%= dept.getEmployeeCount() %>
        </div>
        <div class="dept-sub">
            employee<%= dept.getEmployeeCount() != 1 ? "s" : "" %>
        </div>

        <!-- Actions -->
        <div class="dept-actions">

            <!-- Edit button -->
            <button class="btn btn-outline btn-sm"
                    onclick="openEditModal(
                        '<%= dept.getId() %>',
                        '<%= dept.getName().replace("'", "\\'") %>',
                        '<%= dept.getDescription() != null
                             ? dept.getDescription().replace("'", "\\'")
                             : "" %>')">
                <i class="ti ti-edit"></i>
                Edit
            </button>

            <!-- Delete button -->
            <button class="btn btn-danger btn-sm"
                    onclick="showDeptDeleteModal(
                        '<%= dept.getId() %>',
                        '<%= dept.getName().replace("'", "\\'") %>',
                        '<%= dept.getEmployeeCount() %>')">
                <i class="ti ti-trash"></i>
                Delete
            </button>

        </div>
    </div>

    <%     }
       } else { %>
    <div class="empty-state"
         style="grid-column:span 3;
                padding:40px">
        <i class="ti ti-building-off"></i>
        No departments found.
        Click Add department to create one.
    </div>
    <% } %>
</div>

<!-- ── Edit department modal ─────────────────── -->
<div class="modal-overlay" id="edit-dept-modal">
    <div class="modal">
        <div class="modal-head">
            <i class="ti ti-edit"
               style="color:var(--accent)"></i>
            <span class="modal-title">Edit department</span>
        </div>

        <form action="departments" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" id="edit-dept-id">

            <div class="form-group"
                 style="margin-bottom:12px">
                <label>Department name *</label>
                <input type="text"
                       name="name"
                       id="edit-dept-name"
                       required>
            </div>

            <div class="form-group"
                 style="margin-bottom:16px">
                <label>Description</label>
                <input type="text"
                       name="description"
                       id="edit-dept-desc">
            </div>

            <div class="modal-actions">
                <button type="button"
                        class="modal-cancel"
                        onclick="closeEditModal()">
                    Cancel
                </button>
                <button type="submit"
                        class="btn btn-primary btn-sm">
                    <i class="ti ti-check"></i>
                    Update
                </button>
            </div>
        </form>
    </div>
</div>

<!-- ── Dept delete confirm modal ─────────────── -->
<div class="modal-overlay" id="dept-delete-modal">
    <div class="modal">
        <div class="modal-head">
            <i class="ti ti-alert-triangle"></i>
            <span class="modal-title">Delete department</span>
        </div>
        <p class="modal-msg" id="dept-delete-msg">
            Are you sure you want to delete this department?
        </p>
        <div class="modal-actions">
            <button class="modal-cancel"
                    onclick="closeDeptDeleteModal()">
                Cancel
            </button>
            <button class="modal-delete"
                    id="dept-delete-btn"
                    onclick="confirmDeptDelete()">
                <i class="ti ti-trash"></i>
                Delete
            </button>
        </div>
    </div>
</div>

<!-- ── Hidden dept delete form ───────────────── -->
<form id="dept-delete-form"
      action="departments"
      method="post"
      style="display:none">
    <input type="hidden" name="action" value="delete">
    <input type="hidden" id="dept-del-id" name="id">
</form>

<!-- ── JavaScript ───────────────────────────── -->
<script>
// ── Toggle add form ───────────────────────────
function toggleAddForm() {
    var form = document.getElementById('add-dept-form');
    if (form.style.display === 'none') {
        form.style.display = 'block';
        document.getElementById('dept-name').focus();
    } else {
        form.style.display = 'none';
    }
}

// ── Edit modal ────────────────────────────────
function openEditModal(id, name, desc) {
    document.getElementById('edit-dept-id').value = id;
    document.getElementById('edit-dept-name').value = name;
    document.getElementById('edit-dept-desc').value = desc;
    document.getElementById('edit-dept-modal').classList.add('show');
}

function closeEditModal() {
    document.getElementById('edit-dept-modal').classList.remove('show');
}

// ── Dept delete modal ─────────────────────────
var pendingDeptId = null;
var pendingDeptName = null;

function showDeptDeleteModal(id, name, count) {
    pendingDeptId = id;
    pendingDeptName = name;

    var msg = document.getElementById('dept-delete-msg');
    var btn = document.getElementById('dept-delete-btn');

    if (parseInt(count) > 0) {
        // has employees — warn and disable delete
        msg.innerHTML =
            '<span style="color:var(--amber)">' +
            '<i class="ti ti-alert-triangle"></i> ' +
            'Cannot delete <strong>' + name + '</strong>. ' +
            'It has <strong>' + count + ' employee(s)</strong>. ' +
            'Reassign them before deleting.' +
            '</span>';
        btn.style.display = 'none';
    } else {
        // no employees — safe to delete
        msg.innerHTML =
            'Are you sure you want to delete <strong>' +
            name + '</strong> department? ' +
            '<br><span style="color:var(--red);font-size:10px">' +
            '⚠ This action cannot be undone.</span>';
        btn.style.display = 'inline-flex';
    }
    document.getElementById('dept-delete-modal').classList.add('show');
}

function closeDeptDeleteModal() {
    document.getElementById('dept-delete-modal').classList.remove('show');
    pendingDeptId = null;
    pendingDeptName = null;
}

function confirmDeptDelete() {
    if (!pendingDeptId) return;
    document.getElementById('dept-del-id').value = pendingDeptId;
    document.getElementById('dept-delete-form').submit();
    closeDeptDeleteModal();
}

// close modals on outside click
document.addEventListener('click', function(e) {
    var editModal = document.getElementById('edit-dept-modal');
    var deleteModal = document.getElementById('dept-delete-modal');
    if (e.target === editModal)closeEditModal();
    if (e.target === deleteModal)closeDeptDeleteModal();
});

// close on Escape key
document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') {
        closeEditModal();
        closeDeptDeleteModal();
    }
});
</script>

<%@ include file="footer.jsp" %>