<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In - UserHub</title>
    
    <!-- Google Fonts: Plus Jakarta Sans & Inter & JetBrains Mono -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@500;600&display=swap" rel="stylesheet">
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Enterprise Design System -->
    <link href="css/style.css" rel="stylesheet">
</head>
<body>

    <div class="login-viewport">
        
        <!-- Left Section: Dark Midnight Navy Brand Panel -->
        <div class="login-brand-panel">
            <div class="login-brand-top">
                <div class="sidebar-brand-icon">
                    <i class="bi bi-people-fill"></i>
                </div>
                <div>
                    <div class="sidebar-brand-title">UserHub</div>
                    <div class="sidebar-brand-tag">Directory Console</div>
                </div>
            </div>

            <div class="login-brand-body">
                <span class="login-tagline-badge">Enterprise Console</span>
                <h1>Centralized User Management</h1>
                <p>
                    A unified directory platform designed to manage user records, maintain system credentials, and perform real-time administrative operations securely.
                </p>

                <ul class="login-features-list">
                    <li class="login-feature-item">
                        <i class="bi bi-shield-check"></i>
                        <span>Session-based authentication with Servlet Filter guards</span>
                    </li>
                    <li class="login-feature-item">
                        <i class="bi bi-database-check"></i>
                        <span>Direct MySQL persistence using parameterized JDBC queries</span>
                    </li>
                    <li class="login-feature-item">
                        <i class="bi bi-arrow-repeat"></i>
                        <span>Asynchronous RESTful CRUD and live search operations</span>
                    </li>
                </ul>
            </div>

            <div class="login-brand-bottom">
                <span>UserHub &bull; Java EE / Jersey REST / JDBC / MySQL</span>
            </div>
        </div>

        <!-- Right Section: Elevated Warm White Form Panel -->
        <div class="login-form-panel">
            <div class="login-form-container">
                <div class="login-header-group">
                    <h2>Sign In</h2>
                    <p>Enter your credentials to access the management portal</p>
                </div>

                <!-- Alert Feedback Box -->
                <div id="loginAlert" class="alert d-none mb-3" role="alert"></div>

                <form id="loginForm" novalidate>
                    <div class="mb-3">
                        <label for="email" class="form-field-label">Email Address</label>
                        <div class="input-group">
                            <span class="input-group-text bg-white text-muted border-end-0">
                                <i class="bi bi-envelope"></i>
                            </span>
                            <input type="email" class="form-control form-text-input border-start-0 ps-0" id="email" placeholder="admin@userhub.com" required autofocus>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="password" class="form-field-label">Password</label>
                        <div class="input-group">
                            <span class="input-group-text bg-white text-muted border-end-0">
                                <i class="bi bi-lock"></i>
                            </span>
                            <input type="password" class="form-control form-text-input border-start-0 border-end-0 ps-0" id="password" placeholder="••••••••" required>
                            <button class="btn btn-outline-secondary border-start-0 bg-white" type="button" id="togglePassword" title="Show/Hide Password">
                                <i class="bi bi-eye" id="eyeIcon"></i>
                            </button>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary-product w-100 py-2 justify-content-center" id="loginBtn">
                        <span>Sign In</span>
                        <i class="bi bi-arrow-right ms-1"></i>
                    </button>
                </form>

                <div class="demo-credentials-box" title="Click to auto-fill demo credentials">
                    <div class="fw-semibold text-dark mb-1">
                        <i class="bi bi-key-fill text-muted me-1"></i> Demo Credentials (Click to fill):
                    </div>
                    <div>Email: <code>admin@userhub.com</code></div>
                    <div class="mt-1">Password: <code>admin123</code></div>
                </div>
            </div>
        </div>

    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/login.js"></script>
</body>
</html>
