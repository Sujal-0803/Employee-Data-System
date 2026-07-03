<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.eds.model.Employee"%>
<%@ page import="com.eds.model.Department"%>
<%@ page import="java.util.List"%>

<%
request.setAttribute("currentPage", "employees");

List<Employee> employees = (List<Employee>) request.getAttribute("employees");
List<Department> depts = (List<Department>) request.getAttribute("depts");

int totalCount = request.getAttribute("totalCount") != null ? (Integer) request.getAttribute("totalCount") : 0;
int totalPages = request.getAttribute("totalPages") != null ? (Integer) request.getAttribute("totalPages") : 1;
int pageNum = request.getAttribute("pageNum") != null ? (Integer) request.getAttribute("pageNum") : 1;
String keyword = request.getAttribute("keyword") != null ? (String) request.getAttribute("keyword") : "";
String selDept = request.getAttribute("selectedDept") != null ? (String) request.getAttribute("selectedDept") : "";
String selStatus = request.getAttribute("selectedStatus") != null ? (String) request.getAttribute("selectedStatus")
		: "";

if (keyword == null)
	keyword = "";
if (selDept == null)
	selDept = "";
if (selStatus == null)
	selStatus = "";
%>

<%@ include file="navbar.jsp"%>

<!-- ── Page header ──────────────────────────── -->
<div class="sec-head">
	<h3>
		All employees <span
			style="font-size: 11px; color: var(--dim); font-weight: 400; margin-left: 8px">
			<%=totalCount%> found
		</span>
	</h3>
	<div class="sec-head-right">
		<button class="btn btn-outline btn-sm" onclick="exportCSV()">
			<i class="ti ti-download"></i> Export CSV
		</button>
		<a href="add" class="btn btn-primary btn-sm"> <i
			class="ti ti-plus"></i> Add employee
		</a>
	</div>
</div>

<!-- ── Table card ───────────────────────────── -->
<div class="table-card">

	<!-- ── Toolbar ──────────────────────────── -->
	<div class="table-toolbar">
		<div class="table-toolbar-left">

			<!-- Search box -->
			<div class="search-box">
				<i class="ti ti-search"></i> <input type="text" id="search-input"
					placeholder="Search name, email..." value="<%=keyword%>"
					onkeydown="searchOnEnter(event,'search-input')">
			</div>

			<!-- Filter by status -->
			<div class="filter-row">
				<button
					class="filter-btn <%=selStatus.isEmpty() ? "active" : ""%>"
					onclick="setFilter('',this,'status')">All</button>
				<button
					class="filter-btn <%="Active".equals(selStatus) ? "active" : ""%>"
					onclick="setFilter('Active',this,'status')">Active</button>
				<button
					class="filter-btn <%="Inactive".equals(selStatus) ? "active" : ""%>"
					onclick="setFilter('Inactive',this,'status')">Inactive</button>
			</div>

			<!-- Filter by department -->
			<div class="filter-row">
				<%
				if (depts != null) {
					for (Department dept : depts) {
				%>
				<button
					class="filter-btn <%=dept.getName().equals(selDept) ? "active" : ""%>"
					onclick="setFilter('<%=dept.getName()%>',this,'dept')">
					<%=dept.getName()%>
				</button>
				<%
				}
				}
				%>
			</div>

		</div>
		<span style="font-size: 11px; color: var(--dim)"> Page <%=pageNum%>
			of <%=totalPages%>
		</span>
	</div>

	<!-- ── Table ────────────────────────────── -->
	<table id="emp-table">
		<thead>
			<tr>
				<th onclick="sortTable(0,'emp-table')">Name<span
					class="sort-icon">↕</span>
				</th>
				<th onclick="sortTable(1,'emp-table')">Email<span
					class="sort-icon">↕</span>
				</th>
				<th onclick="sortTable(2,'emp-table')">Department<span
					class="sort-icon">↕</span>
				</th>
				<th onclick="sortTable(3,'emp-table')">Designation<span
					class="sort-icon">↕</span>
				</th>
				<th onclick="sortTable(4,'emp-table')">Salary<span
					class="sort-icon">↕</span>
				</th>
				<th onclick="sortTable(5,'emp-table')">Join date<span
					class="sort-icon">↕</span>
				</th>
				<th>Status</th>
				<th>Actions</th>
			</tr>
		</thead>
		<tbody>
			<%
			if (employees != null && !employees.isEmpty()) {
				for (Employee emp : employees) {
			%>
			<tr>
				<td><span class="avatar"> <%=emp.getInitials()%>
				</span> <%=emp.getName()%></td>
				<td class="text-muted" style="font-size: 11px"><%=emp.getEmail()%>
				</td>
				<td><%=emp.getDeptName() != null ? emp.getDeptName() : "-"%></td>
				<td class="text-muted"><%=emp.getDesignation() != null ? emp.getDesignation() : "-"%></td>
				<td class="text-accent">₹<%=String.format("%,.0f", emp.getSalary())%>
				</td>
				<td class="text-muted" style="font-size: 11px"><%=emp.getJoinDate()%>
				</td>
				<td>
					<form action="toggle-status" method="post" style="display: inline">
						<input type="hidden" name="id" value="<%=emp.getId()%>">
						<input type="hidden" name="redirectTo" value="employees">
						<button type="submit"
							class="badge <%="Active".equals(emp.getStatus()) ? "badge-active" : "badge-inactive"%>"
							title="Click to toggle">
							<%=emp.getStatus()%>
						</button>
					</form>
				</td>
				<td style="white-space: nowrap">
					<!-- View --> <a href="profile?id=<%=emp.getId()%>"
					class="btn btn-outline btn-sm"
					style="display: inline-flex; margin-right: 3px"> <i
						class="ti ti-eye"></i>
				</a> <!-- Edit --> <a href="edit?id=<%=emp.getId()%>"
					class="btn btn-outline btn-sm"
					style="display: inline-flex; margin-right: 3px"> <i
						class="ti ti-edit"></i>
				</a> <!-- Delete -->
					<button class="btn btn-danger btn-sm" style="display: inline-flex"
						onclick="showDeleteModal('<%=emp.getId()%>','<%=emp.getName()%>','delete-form')">
						<i class="ti ti-trash"></i>
					</button>
				</td>
			</tr>
			<%
			}
			} else {
			%>
			<tr>
				<td colspan="8">
					<div class="empty-state">
						<i class="ti ti-users"></i> No employees found
					</div>
				</td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>

	<!-- ── Pagination ───────────────────────── -->
	<div class="pagination">
		<span> Showing <%=employees != null ? employees.size() : 0%>
			of <%=totalCount%> employees
		</span>
		<div class="page-buttons">

			<!-- Previous -->
			<%
			if (pageNum > 1) {
			%>
			<a
				href="employees?page=<%=pageNum - 1%>&keyword=<%=keyword%>&dept=<%=selDept%>&status=<%=selStatus%>"
				class="page-btn">← Prev</a>
			<%
			}
			%>

			<!-- Page numbers -->
			<%
			for (int i = 1; i <= totalPages; i++) {
			%>
			<a
				href="employees?page=<%=i%>&keyword=<%=keyword%>&dept=<%=selDept%>&status=<%=selStatus%>"
				class="page-btn <%=i == pageNum ? "active" : ""%>"> <%=i%>
			</a>
			<%
			}
			%>

			<!-- Next -->
			<%
			if (pageNum < totalPages) {
			%>
			<a
				href="employees?page=<%=pageNum + 1%>&keyword=<%=keyword%>&dept=<%=selDept%>&status=<%=selStatus%>"
				class="page-btn">Next →</a>
			<%
			}
			%>

		</div>
	</div>

</div>

<%@ include file="footer.jsp"%>