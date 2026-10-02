<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("userEmail");
    if (userName == null) {
        userName = "Administrator";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - UserHub</title>
    
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

    <div class="app-shell">

        <!-- Deep Midnight Navy Sidebar Navigation Rail -->
        <aside class="app-sidebar" id="appSidebar">
            <div>
                <a href="home.jsp" class="sidebar-brand-block">
                    <div class="sidebar-brand-icon">
                        <i class="bi bi-people-fill"></i>
                    </div>
                    <div>
                        <div class="sidebar-brand-title">UserHub</div>
                        <div class="sidebar-brand-tag">Directory Console</div>
                    </div>
                </a>

                <div class="sidebar-nav-container">
                    <div class="sidebar-nav-heading">Main Navigation</div>
                    <ul class="sidebar-nav-list">
                        <li>
                            <a href="home.jsp" class="sidebar-nav-link active">
                                <i class="bi bi-grid-1x2"></i>
                                <span>Dashboard</span>
                            </a>
                        </li>
                        <li>
                            <a href="users.jsp" class="sidebar-nav-link">
                                <i class="bi bi-person-lines-fill"></i>
                                <span>Users</span>
                            </a>
                        </li>
                        <li>
                            <a href="add-user.jsp" class="sidebar-nav-link">
                                <i class="bi bi-person-plus"></i>
                                <span>Add User</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="sidebar-footer-block">
                <div class="sidebar-status-pill">
                    <div class="status-dot-pulse"></div>
                    <span>MySQL Connected &bull; v1.0</span>
                </div>
            </div>
        </aside>

        <!-- Main Workspace Area -->
        <div class="app-main-area">

            <!-- Top Application Header -->
            <header class="app-topbar">
                <div class="topbar-left">
                    <button class="btn btn-sm btn-outline-secondary d-lg-none" id="sidebarToggle" type="button" aria-label="Toggle navigation">
                        <i class="bi bi-list fs-5"></i>
                    </button>
                    <div class="d-none d-md-flex align-items-center gap-2">
                        <span class="topbar-breadcrumb-label">Console</span>
                        <span class="topbar-breadcrumb-divider">/</span>
                        <span class="topbar-breadcrumb-label topbar-breadcrumb-active">Dashboard</span>
                    </div>
                </div>

                <div class="topbar-right">
                    <div class="user-profile-capsule d-none d-sm-flex">
                        <div class="user-capsule-avatar">
                            <%= userName.substring(0, 1).toUpperCase() %>
                        </div>
                        <div>
                            <div class="user-capsule-name"><%= userName %></div>
                            <div class="user-capsule-email"><%= userEmail != null ? userEmail : "Administrator" %></div>
                        </div>
                    </div>
                    <button class="btn-secondary-product btn-logout" title="Sign Out">
                        <i class="bi bi-box-arrow-right"></i>
                        <span class="d-none d-md-inline">Logout</span>
                    </button>
                </div>
            </header>

            <!-- Page Body -->
            <main class="app-page-body">

                <!-- Editorial Header -->
                <div class="mb-4">
                    <span class="page-eyebrow">User Management</span>
                    <h1 class="page-title-text">Dashboard</h1>
                    <p class="page-subtitle-text">A centralized data management console for system user accounts.</p>
                </div>

                <!-- Editorial Asymmetric Summary Area -->
                <div class="dashboard-hero-layout">

                    <!-- Dominant Hero Metric Block -->
                    <div class="hero-metric-card">
                        <div>
                            <div class="hero-metric-header">
                                <span class="hero-metric-label">Total Users</span>
                                <span class="hero-metric-badge">
                                    <i class="bi bi-arrow-repeat"></i>
                                    Live Sync
                                </span>
                            </div>
                            <div class="hero-metric-number" id="totalUsersCount">--</div>
                        </div>
                        <p class="hero-metric-subtext">
                            <i class="bi bi-check2-circle text-success"></i>
                            Active user records queried directly from MySQL database.
                        </p>
                    </div>

                    <!-- Stacked Status Modules -->
                    <div class="status-modules-stack">
                        <div class="status-module-card">
                            <div class="status-module-info">
                                <div class="status-module-icon status-icon-emerald">
                                    <i class="bi bi-database-check"></i>
                                </div>
                                <div>
                                    <div class="status-module-title">Persistence Engine</div>
                                    <div class="status-module-value">MySQL Database</div>
                                </div>
                            </div>
                            <span class="status-indicator-tag indicator-active">
                                <i class="bi bi-dot" style="font-size: 1.5rem; line-height: 0;"></i>
                                Connected
                            </span>
                        </div>

                        <div class="status-module-card">
                            <div class="status-module-info">
                                <div class="status-module-icon status-icon-navy">
                                    <i class="bi bi-shield-check"></i>
                                </div>
                                <div>
                                    <div class="status-module-title">Session State</div>
                                    <div class="status-module-value">Authenticated Guard</div>
                                </div>
                            </div>
                            <span class="status-indicator-tag indicator-session">
                                Active Session
                            </span>
                        </div>
                    </div>

                </div>

                <!-- Recently Registered Users Data Surface -->
                <div class="directory-surface-card">
                    <div class="directory-surface-header">
                        <div class="surface-title-group">
                            <h2>Recently Registered Users</h2>
                            <p>Latest records from the user directory</p>
                        </div>
                        <a href="users.jsp" class="btn-secondary-product py-1 px-3" style="font-size: 0.8rem;">
                            <span>View All Users</span>
                            <i class="bi bi-arrow-right ms-1"></i>
                        </a>
                    </div>

                    <div class="table-responsive-pane">
                        <table class="enterprise-table" id="dashboardUsersTable">
                            <thead>
                                <tr>
                                    <th style="width: 80px;">ID</th>
                                    <th>User</th>
                                    <th>Phone</th>
                                    <th>Address</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td colspan="4" class="text-center text-muted py-4">
                                        <span class="spinner-border spinner-border-sm me-2 text-primary" role="status"></span>
                                        Loading directory data...
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

            </main>
        </div>

    </div>

    <!-- Logout Confirmation Modal -->
    <div class="modal fade" id="logoutConfirmModal" tabindex="-1" aria-labelledby="logoutConfirmModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-sm">
            <div class="modal-content">
                <div class="modal-body text-center pt-4 pb-3">
                    <div class="mb-3">
                        <i class="bi bi-box-arrow-right text-dark" style="font-size: 2.25rem;"></i>
                    </div>
                    <h5 class="fw-bold mb-2">Sign out?</h5>
                    <p class="text-muted small mb-0">
                        Are you sure you want to sign out of your UserHub session?
                    </p>
                </div>
                <div class="modal-footer justify-content-center border-0 pt-0 pb-4">
                    <button type="button" class="btn-secondary-product" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn-primary-product" id="confirmLogoutBtn">Sign Out</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/users.js"></script>
</body>
</html>
