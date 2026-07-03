<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

        <!-- ── Footer bar ───────────────────────── -->
        <div style="
            background:    var(--bg3);
            border-top:    1px solid var(--border);
            padding:       16px 20px;
            margin-top:    24px;
            display:       flex;
            align-items:   center;
            justify-content: space-between;
            font-size:     11px;
            color:         var(--dim);
            border-radius: 8px;">

            <span>© 2024 Employee Data System · All rights reserved</span>

            <span>
                Designed &amp; Developed by
                <a href="about"
                   style="color:var(--accent);
                          text-decoration:none;
                          font-weight:600">
                    Sujal Maru
                </a>
                &nbsp;·&nbsp;
                <a href="https://github.com/Sujal-0803"
                   target="_blank"
                   style="color:var(--muted);
                          text-decoration:none">
                    <i class="ti ti-brand-github"></i>
                    GitHub
                </a>
                &nbsp;·&nbsp;
                <a href="https://linkedin.com/in/sujalmaru0803"
                   target="_blank"
                   style="color:var(--muted);
                          text-decoration:none">
                    <i class="ti ti-brand-linkedin"></i>
                    LinkedIn
                </a>
            </span>

        </div>

        </div>
        <!-- end content -->

    </div>
    <!-- end body-wrap -->

</div>
<!-- end app -->

<!-- ── Main JS ──────────────────────────────── -->
<script src="js/main.js"></script>

<!-- ── Chart.js CDN ─────────────────────────── -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.min.js"></script>

<!-- ── Auto fire toast from session ─────────── -->
<% if (request.getAttribute("toast_msg") != null) { %>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        showToast(
            '<%= request.getAttribute("toast_msg") %>',
            '<%= request.getAttribute("toast_type") %>'
        );
    });
</script>
<% } %>

</body>
</html>