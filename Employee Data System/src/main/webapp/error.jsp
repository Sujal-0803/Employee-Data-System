<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isErrorPage="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error | Employee Data System</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@2.44.0/tabler-icons.min.css">
    <style>
        * { 
            box-sizing: border-box; 
            margin: 0; 
            padding: 0; 
        }

        body {
            font-family: 'JetBrains Mono', monospace, sans-serif;
            background: #0F1117;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #E2E8F0;
        }

        .error-wrap {
            text-align: center;
            padding: 40px 20px;
            max-width: 500px;
        }

        .error-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: rgba(244, 63, 94, 0.12);
            border: 1px solid rgba(244, 63, 94, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 32px;
            color: #F43F5E;
        }

        .error-code {
            font-size: 48px;
            font-weight: 700;
            color: #6366F1;
            margin-bottom: 8px;
        }

        .error-title {
            font-size: 18px;
            font-weight: 600;
            color: #E2E8F0;
            margin-bottom: 10px;
        }

        .error-msg {
            font-size: 12px;
            color: #94A3B8;
            line-height: 1.7;
            margin-bottom: 28px;
        }

        .error-actions {
            display: flex;
            gap: 10px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn-home {
            background: #6366F1;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 700;
            font-family: inherit;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: opacity .2s;
        }

        .btn-home:hover { 
            opacity: .88; 
        }

        .btn-back {
            background: none;
            border: 1px solid #252836;
            color: #94A3B8;
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 12px;
            font-family: inherit;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all .2s;
        }

        .btn-back:hover {
            border-color: #6366F1;
            color: #6366F1;
        }

        .divider {
            border: none;
            border-top: 1px solid #252836;
            margin: 24px 0;
        }

        .error-detail {
            background: #1A1D27;
            border: 1px solid #252836;
            border-radius: 8px;
            padding: 12px 16px;
            font-size: 11px;
            color: #64748B;
            text-align: left;
            line-height: 1.7;
        }

        .error-detail strong {
            color: #94A3B8;
        }
    </style>
</head>
<body>

<div class="error-wrap">

    <!-- Icon -->
    <div class="error-icon">
        <i class="ti ti-alert-triangle"></i>
    </div>

    <!-- Error code -->
    <%
        Integer statusCode = (Integer)request.getAttribute("jakarta.servlet.error.status_code");
        String errorMsg = (String)request.getAttribute("jakarta.servlet.error.message");
        String errorUri = (String)request.getAttribute("jakarta.servlet.error.request_uri");

        int code = (statusCode != null) ? statusCode : 500;
    %>

    <div class="error-code"><%= code %></div>

    <!-- Title based on code -->
    <div class="error-title">
        <% if (code == 404) { %>
            Page not found
        <% } else if (code == 403) { %>
            Access denied
        <% } else if (code == 500) { %>
            Internal server error
        <% } else { %>
            Something went wrong
        <% } %>
    </div>

    <!-- Message -->
    <div class="error-msg">
        <% if (code == 404) { %>
            The page you are looking for does not exist
            or has been moved.
        <% } else if (code == 403) { %>
            You do not have permission to access this page.
            Please login with valid credentials.
        <% } else { %>
            An unexpected error occurred.
            Please try again or contact the administrator.
        <% } %>
    </div>

    <!-- Action buttons -->
    <div class="error-actions">
        <a href="dashboard" class="btn-home">
            <i class="ti ti-layout-dashboard"></i>
            Go to dashboard
        </a>
        <a href="javascript:history.back()"
           class="btn-back">
            <i class="ti ti-arrow-left"></i>
            Go back
        </a>
    </div>

    <!-- Error details -->
    <% if (errorMsg != null || errorUri != null) { %>
    <hr class="divider">
    <div class="error-detail">
        <% if (errorUri != null) { %>
        <div>
            <strong>URL:</strong> <%= errorUri %>
        </div>
        <% } %>
        <% if (errorMsg != null && !errorMsg.isEmpty()) { %>
        <div>
            <strong>Message:</strong> <%= errorMsg %>
        </div>
        <% } %>
        <div>
            <strong>Time:</strong>
            <%= new java.util.Date() %>
        </div>
    </div>
    <% } %>

</div>

</body>
</html>