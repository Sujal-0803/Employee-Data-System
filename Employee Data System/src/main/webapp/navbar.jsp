<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.eds.model.Admin"%>

<%
Admin loggedAdmin = (Admin) session.getAttribute("admin");
String adminName = (loggedAdmin != null) ? loggedAdmin.getUsername() : "Admin";
String currentPage = (String) request.getAttribute("currentPage");
if (currentPage == null)
	currentPage = "";
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Employee Data System</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@2.44.0/tabler-icons.min.css">
<link rel="stylesheet" href="css/style.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link
	href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;600;700&display=swap"
	rel="stylesheet">

<script>
	/* Apply saved theme immediately — before page renders to avoid flash */
	(function() {
		const saved = localStorage.getItem('theme');
		if (saved === 'light')
			document.documentElement.setAttribute('data-theme', 'light');
	})();
</script>
</head>

<body>

	<script>
		function toggleTheme() {
			const html = document.documentElement;
			const isLight = html.getAttribute('data-theme') === 'light';

			if (isLight) {
				html.removeAttribute('data-theme');
				localStorage.setItem('theme', 'dark');
				document.getElementById('theme-icon').className = 'ti ti-sun';
				document.getElementById('theme-label').textContent = 'Light mode';
			} else {
				html.setAttribute('data-theme', 'light');
				localStorage.setItem('theme', 'light');
				document.getElementById('theme-icon').className = 'ti ti-moon';
				document.getElementById('theme-label').textContent = 'Dark mode';
			}
		}

		/* Sync icon + label on every page load */
		document
				.addEventListener(
						'DOMContentLoaded',
						function() {
							const isLight = document.documentElement
									.getAttribute('data-theme') === 'light';
							if (isLight) {
								document.getElementById('theme-icon').className = 'ti ti-moon';
								document.getElementById('theme-label').textContent = 'Dark mode';
							}
						});
	</script>

	<!-- ── Toast container ── -->
	<div class="toast-container" id="toast-container"></div>

	<!-- ── Delete modal ── -->
	<div class="modal-overlay" id="delete-modal">
		<div class="modal">
			<div class="modal-head">
				<i class="ti ti-alert-triangle"></i> <span class="modal-title">Confirm
					delete</span>
			</div>
			<p class="modal-msg">
				Are you sure you want to delete <strong id="modal-emp-name"
					style="color: var(--text)"></strong>? <br> <span
					style="color: var(--red); font-size: 10px"> ⚠ This action
					cannot be undone. </span>
			</p>
			<div class="modal-actions">
				<button class="modal-cancel" onclick="closeDeleteModal()">
					Cancel</button>
				<button class="modal-delete" onclick="confirmDelete()">
					<i class="ti ti-trash"></i> Delete
				</button>
			</div>
		</div>
	</div>

	<!-- ── Hidden delete form ── -->
	<form id="delete-form" action="delete" method="post"
		style="display: none">
		<input type="hidden" id="delete-emp-id" name="id">
	</form>

	<!-- ── Hidden dept delete form ── -->
	<form id="delete-dept-form" action="departments" method="post"
		style="display: none">
		<input type="hidden" name="action" value="delete"> <input
			type="hidden" id="delete-dept-id" name="id">
	</form>

	<div class="app">

		<!-- ── Topbar ── -->
		<div class="topbar">
			<span class="topbar-title"> Employee Data System </span>
			<div class="topbar-right">

				<!-- Theme toggle -->
				<button class="theme-btn" onclick="toggleTheme()">
					<i class="ti ti-sun" id="theme-icon"></i> <span id="theme-label">Light
						mode</span>
				</button>

				<!-- Admin name -->
				<div class="topbar-user">
					<i class="ti ti-user-circle" style="font-size: 16px"></i> <span><%=adminName%></span>
				</div>

				<!-- Logout -->
				<a href="logout" class="btn btn-outline btn-sm"
					style="border-color: var(--red); color: var(--red)"> <i
					class="ti ti-logout"></i> Logout
				</a>

			</div>
		</div>

		<!-- ── Body wrap ── -->
		<div class="body-wrap">

			<!-- ── Sidebar ── -->
			<div class="sidebar">
				<div class="sidebar-logo">
					<div class="sidebar-logo-name">EDS</div>
					<div class="sidebar-logo-sub">Employee Data System</div>
				</div>

				<div class="nav-section">Main</div>

				<a href="dashboard"
					class="nav-item <%="dashboard".equals(currentPage) ? "active" : ""%>">
					<i class="ti ti-layout-dashboard"></i> Dashboard
				</a> 
				<a href="employees"
					class="nav-item <%="employees".equals(currentPage) ? "active" : ""%>">
					<i class="ti ti-users"></i> Employees
				</a>
				 <a href="departments"
					class="nav-item <%="departments".equals(currentPage) ? "active" : ""%>">
					<i class="ti ti-building"></i> Departments
				</a>

				<div class="nav-section">Actions</div>

				<a href="add"
					class="nav-item <%="add".equals(currentPage) ? "active" : ""%>">
					<i class="ti ti-user-plus"></i> Add employee
				</a> <a href="export-csv" class="nav-item"> <i
					class="ti ti-download"></i> Export CSV
				</a>

				<div class="sidebar-footer">
					<div class="online-dot"></div>
					employee_db · MySQL
				</div>

			</div>
			<!-- end sidebar -->

			<!-- ── Page content starts here ── -->
			<div class="content">