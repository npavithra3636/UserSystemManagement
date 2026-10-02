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
    <title>Add User - UserHub</title>
    
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
                            <a href="home.jsp" class="sidebar-nav-link">
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
                            <a href="add-user.jsp" class="sidebar-nav-link active">
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
                        <span class="topbar-breadcrumb-label">Directory</span>
                        <span class="topbar-breadcrumb-divider">/</span>
                        <a href="users.jsp" class="topbar-breadcrumb-label text-decoration-none">Users</a>
                        <span class="topbar-breadcrumb-divider">/</span>
                        <span class="topbar-breadcrumb-label topbar-breadcrumb-active">New Account</span>
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

                <!-- Page Header -->
                <div class="d-flex flex-column flex-sm-row justify-content-between align-items-sm-center gap-3 mb-4">
                    <div>
                        <span class="page-eyebrow">User Management</span>
                        <h1 class="page-title-text">Create New User</h1>
                        <p class="page-subtitle-text">Add a new user record with credentials to the central database.</p>
                    </div>
                    <div>
                        <a href="users.jsp" class="btn-secondary-product">
                            <i class="bi bi-arrow-left"></i>
                            <span>Back to Directory</span>
                        </a>
                    </div>
                </div>

                <!-- Editorial Form Split Grid -->
                <div class="form-split-grid">

                    <!-- Left: Main Form Surface Card -->
                    <div class="form-surface-card">
                        <div class="form-surface-header">
                            <h2>User Information & Credentials</h2>
                            <span class="small text-muted"><span class="text-danger">*</span> Required fields</span>
                        </div>

                        <div class="form-surface-body">
                            <!-- Feedback Alert -->
                            <div id="formAlert" class="alert d-none mb-4" role="alert"></div>

                            <form id="addUserForm" novalidate>
                                <div class="row g-3">
                                    <div class="col-12 col-md-6">
                                        <label for="addName" class="form-field-label">Full Name <span class="text-danger">*</span></label>
                                        <input type="text" class="form-text-input" id="addName" placeholder="e.g. Ravi Kumar" required autofocus>
                                    </div>

                                    <div class="col-12 col-md-6">
                                        <label for="addEmail" class="form-field-label">Email Address <span class="text-danger">*</span></label>
                                        <input type="email" class="form-text-input" id="addEmail" placeholder="e.g. ravi.kumar@example.com" required>
                                    </div>

                                    <div class="col-12 col-md-6">
                                        <label for="addPhone" class="form-field-label">Phone Number</label>
                                        <input type="tel" class="form-text-input" id="addPhone" placeholder="e.g. 9848012345">
                                    </div>

                                    <div class="col-12 col-md-6">
                                        <label for="addPassword" class="form-field-label">Password <span class="text-danger">*</span></label>
                                        <input type="password" class="form-text-input" id="addPassword" placeholder="Create a secure password" required>
                                    </div>

                                    <div class="col-12">
                                        <label for="addAddress" class="form-field-label">Address</label>
                                        <textarea class="form-text-input" id="addAddress" rows="2" placeholder="e.g. 12-4-56, Banjara Hills, Hyderabad, Telangana"></textarea>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-end gap-2 mt-4 pt-3 border-top">
                                    <a href="users.jsp" class="btn-secondary-product">Cancel</a>
                                    <button type="submit" class="btn-primary-product px-4" id="saveUserBtn">
                                        <i class="bi bi-check-lg"></i>
                                        <span>Save User</span>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Right: Guidance & Security Standards Card -->
                    <div class="form-guidance-card">
                        <div class="guidance-title">
                            <i class="bi bi-shield-check text-success fs-5"></i>
                            <span>Data Integrity Standards</span>
                        </div>
                        <ul class="guidance-list">
                            <li class="guidance-item-bullet">
                                <strong>Unique Identity:</strong> Every registered user must maintain a distinct, unique email address in MySQL.
                            </li>
                            <li class="guidance-item-bullet">
                                <strong>SQL Safety:</strong> All inputs are executed via JDBC <code>PreparedStatement</code> parameters with full sanitization.
                            </li>
                            <li class="guidance-item-bullet">
                                <strong>Instant Persistence:</strong> Newly created user accounts are queryable across the directory immediately.
                            </li>
                        </ul>
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
