<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Employee Data System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@2.44.0/tabler-icons.min.css">
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
        }

        .login-wrap {
            width: 100%;
            max-width: 400px;
            padding: 20px;
        }

        /* ── Logo ── */
        .logo {
            text-align: center;
            margin-bottom: 28px;
        }

        .logo-icon {
            width: 56px;
            height: 56px;
            border-radius: 14px;
            background: rgba(99,102,241,0.12);
            border: 1px solid rgba(99,102,241,0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 12px;
            font-size: 24px;
            color: #6366F1;
            animation: pulse-glow 2.5s ease-in-out infinite,
                       fadeIn 0.5s ease forwards;
        }

        .logo-title {
            font-size: 18px;
            font-weight: 700;
            color: #E2E8F0;
            margin-bottom: 4px;
            opacity: 0;
            animation: fadeIn 0.6s ease forwards 0.2s;
        }

        .logo-sub {
            font-size: 11px;
            color: #64748B;
            opacity: 0;
            animation: fadeIn 0.6s ease forwards 0.4s;
        }

        /* ── Animations ── */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(6px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes pulse-glow {
            0%, 100% {
                box-shadow: 0 0 0px rgba(99,102,241,0);
            }
            50% {
                box-shadow: 0 0 14px rgba(99,102,241,0.4);
            }
        }

        /* ── Card ── */
        .card {
            background: #1A1D27;
            border: 1px solid #252836;
            border-radius: 12px;
            padding: 28px;
            opacity: 0;
            animation: fadeIn 0.6s ease forwards 0.5s;
        }

        /* ── Error message ── */
        .error-box {
            background: rgba(244,63,94,0.08);
            border: 1px solid rgba(244,63,94,0.3);
            border-radius: 6px;
            padding: 10px 14px;
            font-size: 12px;
            color: #F43F5E;
            margin-bottom: 18px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* ── Form fields ── */
        .form-group {
            margin-bottom: 16px;
        }
        .form-group label {
            display: block;
            font-size: 11px;
            color: #94A3B8;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin-bottom: 6px;
        }
        .input-wrap {
            position: relative;
        }
        .input-wrap i.left-icon {
            position: absolute;
            left: 11px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 15px;
            color: #64748B;
        }
        .form-group input {
            width: 100%;
            background: #0F1117;
            border: 1px solid #252836;
            border-radius: 6px;
            padding: 10px 36px 10px 36px;
            color: #E2E8F0;
            font-size: 13px;
            font-family: inherit;
            outline: none;
            transition: border-color 0.2s;
        }
        .form-group input:focus {
            border-color: #6366F1;
        }
        .form-group input::placeholder {
            color: #64748B;
        }

        /* ── Show password toggle ── */
        .toggle-pw {
            position: absolute;
            right: 11px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 15px;
            color: #64748B;
            cursor: pointer;
            transition: color 0.2s;
            display: none;
        }
        .toggle-pw:hover {
            color: #6366F1;
        }

        /* ── Login button ── */
        .btn-login {
            width: 100%;
            background: #6366F1;
            color: #ffffff;
            border: none;
            border-radius: 6px;
            padding: 11px;
            font-size: 13px;
            font-weight: 700;
            font-family: inherit;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin-top: 20px;
            transition: background 0.2s;
        }
        .btn-login:hover {
            background: #8B5CF6;
        }

        /* ── Divider ── */
        .divider {
            border: none;
            border-top: 1px solid #252836;
            margin: 20px 0;
        }

        /* ── Demo Login ── */
        .demo-title {
            text-align: center;
            font-size: 11px;
            color: #94A3B8;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            margin-bottom: 10px;
            font-weight: 600;
        }

        /* ── Hint ── */
        .hint {
            text-align: center;
            font-size: 11px;
            color: #64748B;
        }
        .hint span {
            color: #6366F1;
        }

        /* ── Footer ── */
        .footer {
            text-align: center;
            margin-top: 20px;
            font-size: 10px;
            color: #64748B;
            opacity: 0;
            animation: fadeIn 0.6s ease forwards 0.7s;
        }
    </style>
</head>
<body>

<div class="login-wrap">

    <!-- ── Logo ── -->
    <div class="logo">
        <div class="logo-icon">
            <i class="ti ti-users"></i>
        </div>
        <div class="logo-title">Employee Data System</div>
        <div class="logo-sub">Admin Portal • Authorized Access Only</div>
    </div>

    <!-- ── Login card ── -->
    <div class="card">

        <!-- ── Error message ── -->
        <% if (request.getAttribute("error") != null) { %>
        <div class="error-box">
            <i class="ti ti-circle-x"></i>
            <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <!-- ── Login form ── -->
        <form action="login" method="post">

            <!-- Username -->
            <div class="form-group">
                <label>Username</label>
                <div class="input-wrap">
                    <i class="ti ti-user left-icon"></i>
                    <input type="text"
                           name="username"
                           placeholder="Enter username"
                           value="<%= request.getAttribute("username") != null
                                     ? request.getAttribute("username") : "" %>"
                           required autofocus>
                </div>
            </div>

            <!-- Password -->
            <div class="form-group">
                <label>Password</label>
                <div class="input-wrap">
                    <i class="ti ti-lock left-icon"></i>
                    <input type="password"
                           name="password"
                           id="password"
                           placeholder="Enter password"
                           required>
                    <i class="ti ti-eye toggle-pw"
                       id="togglePw"
                       onclick="togglePassword()"
                       title="Show/hide password"></i>
                </div>
            </div>

            <!-- Login button -->
            <button type="submit" class="btn-login">
                <i class="ti ti-login"></i>
                Login
            </button>

        </form>

        <hr class="divider">
        <div class="demo-title">Demo Credentials</div>
        <div class="hint">Username: <span>admin</span></div>
        <div class="hint">Password: <span>admin123</span></div>

    </div>

    <!-- ── Footer ── -->
    <div class="footer">
        © 2026 Employee Data System • Developed by Sujal Maru
    </div>

</div>

<script>
    var passwordInput = document.getElementById('password');
    var toggleIcon    = document.getElementById('togglePw');

    // ── Show eye icon only when user types something ──
    passwordInput.addEventListener('input', function () {
        if (passwordInput.value.length > 0) {
            toggleIcon.style.display = 'block';
        } else {
            toggleIcon.style.display = 'none';
            passwordInput.type = 'password';
            toggleIcon.className = 'ti ti-eye toggle-pw';
        }
    });

    // ── Toggle show/hide password ──
    function togglePassword() {
        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            toggleIcon.className = 'ti ti-eye-off toggle-pw';
        } else {
            passwordInput.type = 'password';
            toggleIcon.className = 'ti ti-eye toggle-pw';
        }
    }
</script>

</body>
</html>