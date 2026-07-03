<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setAttribute("currentPage", "about");
%>

<%@ include file="navbar.jsp" %>

<!-- About page -->
<div class="sec-head">
    <h3>Developer Profile</h3>
</div>

<div style="display:grid;
            grid-template-columns:300px 1fr;
            gap:16px">

    <!-- Left card - profile -->
    <div style="
        background: var(--bg2);
        border: 1px solid var(--border);
        border-radius: 10px;
        overflow: hidden;
        display: flex;
        flex-direction: column;">

        <!-- Gradient banner with overlapping avatar -->
        <div style="
            height: 64px;
            background: linear-gradient(135deg, var(--accent), var(--accent2));
            position: relative;">

            <div style="
                width: 64px;
                height: 64px;
                border-radius: 50%;
                background: var(--bg2);
                border: 3px solid var(--bg2);
                box-shadow: 0 0 0 2px var(--accent);
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 22px;
                font-weight: 700;
                color: var(--accent);
                position: absolute;
                left: 20px;
                bottom: -32px;">
                SM
            </div>
        </div>

        <div style="padding: 40px 22px 22px; text-align: left">

            <!-- Name -->
            <div style="font-size:16px;
                        font-weight:700;
                        color:var(--text);
                        margin-bottom:3px">
                Sujal Maru
            </div>

            <!-- Role -->
            <div style="font-size:12.3px;
                        color:var(--accent);
                        margin-bottom:10px">
                Java Full Stack Developer
            </div>

            <!-- Location -->
            <div style="font-size:11px;
                        color:var(--dim);
                        margin-bottom:18px">
                <i class="ti ti-map-pin"></i>
                Pune, Maharashtra, India
            </div>

            <hr style="border:none;
                       border-top:1px solid var(--border);
                       margin-bottom:16px">

            <!-- Email - full width link row -->
            <a href="mailto:sujalmaru2004@gmail.com"
               style="display:flex;
                      align-items:center;
                      justify-content:center;
                      gap:8px;
                      font-size:11px;
                      color:var(--muted);
                      text-decoration:none;
                      padding:9px 12px;
                      background:var(--bg);
                      border:1px solid var(--border);
                      border-radius:6px;
                      margin-bottom:10px;
                      transition:all .15s"
               onmouseover="this.style.borderColor='var(--accent)';
                            this.style.color='var(--accent)'"
               onmouseout="this.style.borderColor='var(--border)';
                           this.style.color='var(--muted)'">
                <i class="ti ti-mail" style="font-size:14px"></i>
                Email me
            </a>

            <!-- GitHub + LinkedIn - side by side buttons -->
            <div style="display:grid;
                        grid-template-columns:1fr 1fr;
                        gap:8px;
                        margin-bottom:18px">

                <a href="https://github.com/Sujal-0803"
                   target="_blank"
                   style="display:flex;
                          align-items:center;
                          justify-content:center;
                          gap:6px;
                          font-size:11px;
                          font-weight:600;
                          color:var(--muted);
                          text-decoration:none;
                          padding:9px 10px;
                          background:var(--bg);
                          border:1px solid var(--border);
                          border-radius:6px;
                          transition:all .15s"
                   onmouseover="this.style.borderColor='var(--accent)';
                            this.style.color='var(--accent)'"
                   onmouseout="this.style.borderColor='var(--border)';
                           this.style.color='var(--muted)'">
                    <i class="ti ti-brand-github" style="font-size:15px"></i>
                    GitHub
                </a>

                <a href="https://linkedin.com/in/sujalmaru0803"
                   target="_blank"
                   style="display:flex;
                          align-items:center;
                          justify-content:center;
                          gap:6px;
                          font-size:11px;
                          font-weight:600;
                          color:var(--muted);
                          text-decoration:none;
                          padding:9px 10px;
                          background:var(--bg);
                          border:1px solid var(--border);
                          border-radius:6px;
                          transition:all .15s"
                   onmouseover="this.style.borderColor='#0A66C2';
                            this.style.color='#0A66C2'"
                   onmouseout="this.style.borderColor='var(--border)';
                           this.style.color='var(--muted)'">
                    <i class="ti ti-brand-linkedin" style="font-size:15px"></i>
                    LinkedIn
                </a>

            </div>

            <!-- Quick stats fill -->
            <div style="display:grid;
                        grid-template-columns:1fr 1fr;
                        gap:8px;
                        margin-bottom:14px">

                <div style="background:var(--bg);
                            border:1px solid var(--border);
                            border-radius:6px;
                            padding:12px 10px;
                            text-align:center">
                    <div style="font-size:18px;
                                font-weight:700;
                                color:var(--accent)">
                        320+
                    </div>
                    <div style="font-size:9px;
                                color:var(--dim);
                                text-transform:uppercase;
                                letter-spacing:.05em;
                                margin-top:2px">
                        LeetCode Problems solved
                    </div>
                </div>

                <div style="background:var(--bg);
                            border:1px solid var(--border);
                            border-radius:6px;
                            padding:12px 10px;
                            text-align:center">
                    <div style="font-size:18px;
                                font-weight:700;
                                color:var(--accent)">
                        6+
                    </div>
                    <div style="font-size:9px;
                                color:var(--dim);
                                text-transform:uppercase;
                                letter-spacing:.05em;
                                margin-top:2px">
                        Projects
                    </div>
                </div>

            </div>

            <!-- Education + availability fill -->
            <div style="background:var(--bg);
                        border:1px solid var(--border);
                        border-radius:6px;
                        padding:12px;
                        font-size:11px;
                        color:var(--muted);
                        line-height:1.9">
                <div>
                    <i class="ti ti-school" style="color:var(--accent);width:16px;display:inline-block"></i>
                    B.E. – E&TC Engineering
                </div>
                <div>
                    <i class="ti ti-briefcase" style="color:var(--green);width:16px;display:inline-block"></i>
                    Open to opportunities
                </div>
                <div>
                    <i class="ti ti-clock" style="color:var(--blue);width:16px;display:inline-block"></i>
                    Available immediately
                </div>
            </div>

        </div>
    </div>

    
    <!-- Right side -->
    <div style="display:flex;
                flex-direction:column;
                gap:14px">

        <!-- About project -->
        <div style="
            background: var(--bg2);
            border: 1px solid var(--border);
            border-radius: 10px;
            padding: 20px">

            <div style="font-size:12px;
                        font-weight:600;
                        color:var(--text);
                        margin-bottom:14px;
                        padding-bottom:10px;
                        border-bottom:1px solid var(--border);
                        display:flex;
                        align-items:center;
                        gap:8px">
                <i class="ti ti-info-circle"
                   style="color:var(--accent)"></i>
                Project Overview
            </div>

            <p style="font-size:12px;
                      color:var(--muted);
                      line-height:1.8;
                      margin-bottom:14px">
                Employee Data System is a full-stack Java web application developed to 
                manage employee records efficiently. It includes secure authentication, 
                department management, complete CRUD operations, dashboard analytics, 
                activity logging, search & pagination, and CSV export within a 
                responsive dark-themed interface.
            </p>

            <div style="display:grid;
                        grid-template-columns:1fr 1fr;
                        gap:10px">

                <div style="background:var(--bg);
                            border:1px solid var(--border);
                            border-radius:6px;
                            padding:10px 12px">
                    <div style="font-size:9px;
                                color:var(--dim);
                                text-transform:uppercase;
                                letter-spacing:.06em;
                                margin-bottom:4px">
                        Project Name 
                    </div>
                    <div style="font-size:12px;
                                color:var(--text)">
                        Employee Data System
                    </div>
                </div>
                <div style="background:var(--bg);
                            border:1px solid var(--border);
                            border-radius:6px;
                            padding:10px 12px">
                    <div style="font-size:9px;
                                color:var(--dim);
                                text-transform:uppercase;
                                letter-spacing:.06em;
                                margin-bottom:4px">
                        Version
                    </div>
                    <div style="font-size:12px;
                                color:var(--accent)">
                        v1.0.0
                    </div>
                </div>
                <div style="background:var(--bg);
                            border:1px solid var(--border);
                            border-radius:6px;
                            padding:10px 12px">
                    <div style="font-size:9px;
                                color:var(--dim);
                                text-transform:uppercase;
                                letter-spacing:.06em;
                                margin-bottom:4px">
                        Year
                    </div>
                    <div style="font-size:12px;
                                color:var(--text)">
                        2025
                    </div>
                </div>
                <div style="background:var(--bg);
                            border:1px solid var(--border);
                            border-radius:6px;
                            padding:10px 12px">
                    <div style="font-size:9px;
                                color:var(--dim);
                                text-transform:uppercase;
                                letter-spacing:.06em;
                                margin-bottom:4px">
                        Type
                    </div>
                    <div style="font-size:12px;
                                color:var(--text)">
                        Personal Project
                    </div>
                </div>
            </div>
        </div>

        <!-- Tech stack -->
        <div style="
            background: var(--bg2);
            border: 1px solid var(--border);
            border-radius: 10px;
            padding: 20px">

            <div style="font-size:12px;
                        font-weight:600;
                        color:var(--text);
                        margin-bottom:14px;
                        padding-bottom:10px;
                        border-bottom:1px solid var(--border);
                        display:flex;
                        align-items:center;
                        gap:8px">
                <i class="ti ti-stack"
                   style="color:var(--accent)"></i>
                Tech stack used
            </div>

            <div style="display:flex;
                        flex-wrap:wrap;
                        gap:8px">

                <% String[] techs = {
                    "Java", "JSP", "Servlets", "JDBC", "MySQL", "Apache Tomcat", "HTML5", "CSS3", "JavaScript", "Git"
                };
                String[] colors = {
                    "#f89820", "#6366F1", "#8B5CF6", "#0EA5E9", "#00758F", "#F59E0B", "#E44D26", "#264DE4", "#F7DF1E", "#000000"
                };
                for (int i = 0; i < techs.length; i++) { %>
                <span style="
                    background: rgba(99,102,241,0.1);
                    border: 1px solid rgba(99,102,241,0.3);
                    border-radius: 20px;
                    padding: 4px 12px;
                    font-size: 11px;
                    color: var(--accent)">
                    <%= techs[i] %>
                </span>
                <% } %>

            </div>
        </div>

        <!-- Features -->
        <div style="
            background: var(--bg2);
            border: 1px solid var(--border);
            border-radius: 10px;
            padding: 20px">

            <div style="font-size:12px;
                        font-weight:600;
                        color:var(--text);
                        margin-bottom:14px;
                        padding-bottom:10px;
                        border-bottom:1px solid var(--border);
                        display:flex;
                        align-items:center;
                        gap:8px">
                <i class="ti ti-list-check"
                   style="color:var(--accent)"></i>
                Key features
            </div>

            <div style="display:grid;
                        grid-template-columns:1fr 1fr;
                        gap:8px">
                <% String[] features = {
                    "Admin login & session management",
                    "Employee CRUD operations",
                    "Department management",
                    "Search, filter & pagination",
                    "Sort by column",
                    "Toggle Active / Inactive status",
                    "Live dashboard charts",
                    "Activity log / audit trail",
                    "Export to CSV",
                    "Server-side validation",
                    "Toast notifications",
                    "Light / dark mode toggle"
                };
                for (String feature : features) { %>
                <div style="display:flex;
                            align-items:center;
                            gap:7px;
                            font-size:11px;
                            color:var(--muted)">
                    <i class="ti ti-circle-check"
                       style="color:var(--green);
                              font-size:13px;
                              flex-shrink:0"></i>
                    <%= feature %>
                </div>
                <% } %>
            </div>
        </div>

    </div>
</div>