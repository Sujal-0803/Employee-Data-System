// ── Toast Notification System ──
function showToast(message, type) {
    var icons = {
        success: 'ti-circle-check',
        error: 'ti-circle-x',
        info: 'ti-info-circle',
        warn: 'ti-alert-triangle'
    };

    var container = document.getElementById('toast-container');
    if (!container) return;
	
    var toast = document.createElement('div');
    toast.className = 'toast ' + type;
    toast.innerHTML = '<i class="ti ' + icons[type] + '" ' + 'style="font-size:15px"></i>' + message;
    container.appendChild(toast);

    // auto remove after 3 seconds
    setTimeout(function () {
        toast.style.animation = 'toastOut 0.4s ease forwards';
        setTimeout(function () {
            if (toast.parentNode) toast.parentNode.removeChild(toast);
        }, 400);
    }, 2800);
}

// ── Delete Modal ──
var pendingDeleteId = null;
var pendingDeleteName = null;
var pendingDeleteForm = null;

function showDeleteModal(id, name, formId) {
    pendingDeleteId = id;
    pendingDeleteName = name;
    pendingDeleteForm = formId || 'delete-form';
    // set name in modal
    var nameEl = document.getElementById('modal-emp-name');
    if (nameEl) nameEl.textContent = name;
    // show modal
    var overlay = document.getElementById('delete-modal');
    if (overlay) overlay.classList.add('show');
}

function closeDeleteModal() {
    var overlay = document.getElementById('delete-modal');
    if (overlay) overlay.classList.remove('show');
    pendingDeleteId = null;
    pendingDeleteName = null;
    pendingDeleteForm = null;
}

function confirmDelete() {
    if (!pendingDeleteId) return;
    // set hidden form values
    var idInput = document.getElementById('delete-emp-id');
    if (idInput) idInput.value = pendingDeleteId;
    // submit form
    var form = document.getElementById(pendingDeleteForm);
    if (form) form.submit();
    closeDeleteModal();
}

// close modal when clicking outside
document.addEventListener('click', function (e) {
    var overlay = document.getElementById('delete-modal');
    if (overlay && e.target === overlay) {
        closeDeleteModal();
    }
});

// close modal on Escape key
document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') closeDeleteModal();
});

// ── Light / Dark Mode Toggle ──
function toggleTheme() {
    var body = document.body;
    var icon = document.getElementById('theme-icon');
    var label = document.getElementById('theme-label');
    var isDark = !body.classList.contains('light-mode');
    if (isDark) {
        // switch to light
        body.classList.add('light-mode');
        if (icon) icon.className  = 'ti ti-moon';
        if (label) label.textContent = 'Dark mode';
        localStorage.setItem('theme', 'light');
    } else {
        // switch to dark
        body.classList.remove('light-mode');
        if (icon) icon.className  = 'ti ti-sun';
        if (label) label.textContent = 'Light mode';
        localStorage.setItem('theme', 'dark');
    }

    // update charts if they exist
    if (typeof updateChartColors === 'function') {
        updateChartColors();
    }
    showToast(isDark ? 'Light mode on' : 'Dark mode on', 'info');
}

// ── Load saved theme on page load ──
document.addEventListener('DOMContentLoaded', function () {
    var savedTheme = localStorage.getItem('theme');
    var icon = document.getElementById('theme-icon');
    var label = document.getElementById('theme-label');

    if (savedTheme === 'light') {
        document.body.classList.add('light-mode');
        if(icon) icon.className = 'ti ti-moon';
        if(label) label.textContent = 'Dark mode';
    }
});

// ── Sort Table Columns ──
var sortDirections = {};

function sortTable(colIndex, tableId) {
    var table = document.getElementById(tableId || 'emp-table');
    if (!table) return;

    var tbody = table.querySelector('tbody');
    var rows = Array.from(tbody.querySelectorAll('tr'));

    // toggle direction
    sortDirections[colIndex] = !sortDirections[colIndex];
    var asc = sortDirections[colIndex];

    // update sort icon
    var headers = table.querySelectorAll('th');
    headers.forEach(function (th, i) {
        th.classList.remove('sorted');
        var si = th.querySelector('.sort-icon');
        if (si) si.textContent = '↕';
    });

    var currentTh = headers[colIndex];
    if (currentTh) {
        currentTh.classList.add('sorted');
        var si = currentTh.querySelector('.sort-icon');
        if (si) si.textContent = asc ? '↑' : '↓';
    }

    // sort rows
    rows.sort(function (a, b) {
        var aVal = a.cells[colIndex] ? a.cells[colIndex].textContent.replace(/[₹,]/g, '').trim(): '';
        var bVal = b.cells[colIndex] ? b.cells[colIndex].textContent.replace(/[₹,]/g, '').trim() : '';
        var aNum = parseFloat(aVal);
        var bNum = parseFloat(bVal);

        if (!isNaN(aNum) && !isNaN(bNum)) {
            return asc ? aNum - bNum : bNum - aNum;
        }
        return asc ? aVal.localeCompare(bVal) : bVal.localeCompare(aVal);
    });

    // re-append sorted rows
    rows.forEach(function (row) {
        tbody.appendChild(row);
    });
}

// ── Filter Buttons ───
function setFilter(value, btn, param) {
    // update active button
    var filterRow = btn.closest('.filter-row');
    if (filterRow) {
        filterRow.querySelectorAll('.filter-btn').forEach(function (b) {
                     b.classList.remove('active');
                 });
    }
    btn.classList.add('active');

    // build new URL with filter param
    var url = new URL(window.location.href);
    var params = url.searchParams;

    if (value === 'All' || value === '') {
        params.delete(param);
    } else {
        params.set(param, value);
    }

    // reset to page 1
    params.delete('page');
    window.location.href = url.toString();
}

// ── Search on Enter key ──
function searchOnEnter(e, inputId) {
    if (e.key === 'Enter') {
        var input = document.getElementById(inputId);
        if(!input) return;
        var url = new URL(window.location.href);
        var params = url.searchParams;
        if (input.value.trim() === '') {
            params.delete('keyword');
        } else {
            params.set('keyword', input.value.trim());
        }
        params.delete('page');
        window.location.href = url.toString();
    }
}

// ── Confirm before submit ──
function confirmAction(message) {
    return confirm(message);
}

// ── Print profile page ──
function printProfile() {
    window.print();
    showToast('Print dialog opened', 'info');
}

// ── Auto hide flash messages ──
document.addEventListener('DOMContentLoaded', function () {
    // check for toast data attributes on body
    var body = document.body;
    var toastMsg = body.getAttribute('data-toast-msg');
    var toastType = body.getAttribute('data-toast-type');

    if (toastMsg && toastType) {
        setTimeout(function () {
            showToast(toastMsg, toastType);
        }, 300);
    }
});

// ── Export CSV link ──
function exportCSV() {
    var url = new URL(window.location.href);
    var params = url.searchParams;

    var keyword = params.get('keyword') || '';
    var dept = params.get('dept') || '';
    var status = params.get('status') || '';

    var exportUrl = 'export-csv?keyword=' + keyword + '&dept='    + dept + '&status='  + status;

    window.location.href = exportUrl;
    showToast('Downloading CSV...', 'info');
}

// ── Format currency ──
function formatSalary(amount) {
    return '₹' + parseFloat(amount).toLocaleString('en-IN');
}