<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.eds.model.Employee" %>
<%@ page import="com.eds.model.ActivityLog" %>
<%@ page import="java.util.List" %>

<%
    // set current page for sidebar highlight
    request.setAttribute("currentPage", "dashboard");

    // get data from DashboardServlet
    int totalEmp = (Integer)request.getAttribute("totalEmp");
    int activeEmp = (Integer)request.getAttribute("activeEmp");
    int inactiveEmp = (Integer)request.getAttribute("inactiveEmp");
    int totalDept = (Integer)request.getAttribute("totalDept");

    List <Employee> recentEmps = (List<Employee>)request.getAttribute("recentEmps");
    List <ActivityLog> recentLogs = (List<ActivityLog>)request.getAttribute("recentLogs");
%>

<%@ include file="navbar.jsp" %>

<!-- ── Page header ── -->
<div class="sec-head">
    <h3>Dashboard</h3>
    <div class="sec-head-right">
        <a href="add" class="btn btn-primary btn-sm">
            <i class="ti ti-plus"></i> Add employee
        </a>
    </div>
</div>

<!-- ── Stat cards ── -->
<div class="stats-grid">

    <div class="stat-card">
        <div class="stat-value accent"><%= totalEmp %></div>
        <div class="stat-label">Total employees</div>
        <div class="stat-sub green">
            <i class="ti ti-trending-up"></i>
            All departments
        </div>
    </div>

    <div class="stat-card">
        <div class="stat-value"><%= totalDept %></div>
        <div class="stat-label">Departments</div>
        <div class="stat-sub green">
            <i class="ti ti-building"></i>
            All active
        </div>
    </div>

    <div class="stat-card">
        <div class="stat-value"><%= activeEmp %></div>
        <div class="stat-label">Active employees</div>
        <div class="stat-sub green">
            <i class="ti ti-circle-check"></i>
            Currently working
        </div>
    </div>

    <div class="stat-card">
        <div class="stat-value"><%= inactiveEmp %></div>
        <div class="stat-label">Inactive employees</div>
        <div class="stat-sub amber">
            <i class="ti ti-alert-circle"></i>
            Review needed
        </div>
    </div>

</div>

<!-- ── Charts row ── -->
<div class="charts-row">

    <!-- Bar chart -->
    <div class="chart-card">
        <div class="chart-head">
            <span class="chart-title">
                Avg salary by department
            </span>
            <span class="chart-sub">
                Active employees · live data
            </span>
        </div>
        <canvas id="salaryChart" height="130"></canvas>
    </div>

    <!-- Donut chart -->
    <div class="chart-card">
        <div class="chart-head">
            <span class="chart-title">Employee status</span>
            <span class="chart-sub">Active vs Inactive</span>
        </div>
        <canvas id="statusChart" height="130"></canvas>
    </div>

</div>

<!-- ── Bottom row ── -->
<div style="display:grid;
            grid-template-columns:3fr 2fr;
            gap:12px">

    <!-- Recent employees table -->
    <div class="table-card">
        <div class="table-toolbar">
            <span class="chart-title">Recent employees</span>
            <a href="employees"
               class="btn btn-outline btn-sm">
                View all
            </a>
        </div>
        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Department</th>
                    <th>Designation</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <% if (recentEmps != null && !recentEmps.isEmpty()) {
                       for (Employee emp : recentEmps) { %>
                <tr>
                    <td>
                        <span class="avatar">
                            <%= emp.getInitials() %>
                        </span>
                        <%= emp.getName() %>
                    </td>
                    <td class="text-muted">
                        <%= emp.getDeptName() != null
                            ? emp.getDeptName() : "-" %>
                    </td>
                    <td class="text-muted">
                        <%= emp.getDesignation() != null
                            ? emp.getDesignation() : "-" %>
                    </td>
                    <td>
                        <span class="badge
                            <%= "Active".equals(emp.getStatus()) ? "badge-active" : "badge-inactive" %>">
                            <%= emp.getStatus() %>
                        </span>
                    </td>
                </tr>
                <%     }
                   } else { %>
                <tr>
                    <td colspan="4" class="empty-state">
                        <i class="ti ti-users"></i>
                        No employees found
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <!-- Activity log -->
    <div class="chart-card">
        <div class="chart-head">
            <span class="chart-title">Activity log</span>
            <span class="chart-sub">Recent actions</span>
        </div>
        <div class="log-feed">
            <% if (recentLogs != null && !recentLogs.isEmpty()) {
                   for (ActivityLog log : recentLogs) { %>
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
                No activity yet
            </div>
            <% } %>
        </div>
    </div>

</div>

<!-- ── Chart.js script ── -->
<script>
var isDark = !document.body.classList.contains('light-mode');
function getChartColors() {
    return {
        grid: isDark ? '#252836' : '#E2E8F0',
        tick: isDark ? '#94A3B8' : '#475569',
        tbg: isDark ? '#1A1D27' : '#ffffff',
        tbdr: isDark ? '#252836' : '#E2E8F0',
        ttl: isDark ? '#E2E8F0' : '#0F172A',
        tbody: isDark ? '#94A3B8' : '#475569'
    };
}

var salaryChart = null;
var statusChart = null;

function buildCharts(data) {
    var c = getChartColors();

    // destroy old charts if exist
    if (salaryChart)salaryChart.destroy();
    if (statusChart)statusChart.destroy();

    // ── Bar chart — salary by dept ──
    salaryChart = new Chart(
        document.getElementById('salaryChart'), {
        type: 'bar',
        data: {
            labels: data.labels,
            datasets: [{
                label:           'Avg Salary',
                data:            data.salaries,
                backgroundColor: 'rgba(99,102,241,0.15)',
                borderColor:     '#6366F1',
                borderWidth:     1.5,
                borderRadius:    4,
                yAxisID:         'y'
            }, {
                label:                'Headcount',
                data:                 data.counts,
                type:                 'line',
                borderColor:          '#8B5CF6',
                backgroundColor:      'rgba(139,92,246,0.1)',
                borderWidth:          1.5,
                tension:              0.4,
                pointBackgroundColor: '#8B5CF6',
                pointRadius:          4,
                yAxisID:              'y1'
            }]
        },
        options: {
            responsive: true,
            interaction: {
                mode:      'index',
                intersect: false
            },
            plugins: {
                legend: { display: false },
                tooltip: {
                    backgroundColor: c.tbg,
                    borderColor:     c.tbdr,
                    borderWidth:     1,
                    titleColor:      c.ttl,
                    bodyColor:       c.tbody,
                    callbacks: {
                        label: function(ctx) {
                            if (ctx.datasetIndex === 0)
                                return ' ₹' + ctx.parsed.y
                                    .toLocaleString('en-IN');
                            return ' ' + ctx.parsed.y +
                                   ' employees';
                        }
                    }
                }
            },
            scales: {
                x: {
                    grid:  { color: c.grid },
                    ticks: { color: c.tick, font: { size: 10 } }
                },
                y: {
                    grid:  { color: c.grid },
                    ticks: {
                        color:    c.tick,
                        font:     { size: 10 },
                        callback: function(v) {
                            return '₹' + (v/1000) + 'k';
                        }
                    },
                    position: 'left'
                },
                y1: {
                    grid:  { drawOnChartArea: false },
                    ticks: {
                        color: '#8B5CF6',
                        font:  { size: 10 }
                    },
                    position: 'right'
                }
            }
        }
    });

    // ── Donut chart — status ──
    statusChart = new Chart(
        document.getElementById('statusChart'), {
        type: 'doughnut',
        data: {
            labels: ['Active', 'Inactive'],
            datasets: [{
                data: [data.active, data.inactive],
                backgroundColor: [
                    'rgba(16,185,129,0.2)',
                    'rgba(244,63,94,0.2)'
                ],
                borderColor: [
                    '#10B981',
                    '#F43F5E'
                ],
                borderWidth: 1.5
            }]
        },
        options: {
            cutout: '72%',
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        color:    c.tick,
                        font:     { size: 10 },
                        boxWidth: 10,
                        padding:  10
                    }
                },
                tooltip: {
                    backgroundColor: c.tbg,
                    borderColor:     c.tbdr,
                    borderWidth:     1,
                    titleColor:      c.ttl,
                    bodyColor:       c.tbody
                }
            }
        }
    });
}

// update chart colors on theme toggle
function updateChartColors() {
    isDark = !document.body.classList.contains('light-mode');
    fetch('chart-data').then(function(r) { 
    	return r.json(); 
    }).then(function(data) {
    	buildCharts(data); 
    }).catch(function(err) {
            console.error('Chart error:', err);
        });
}

// load chart data on page load
document.addEventListener('DOMContentLoaded', function () {
    fetch('chart-data').then(function(r) { 
    	return r.json(); 
    }).then(function(data) { 
    	buildCharts(data); 
    }).catch(function(err) {
            console.error('Chart data error:', err);
        });
});
</script>

<%@ include file="footer.jsp" %>