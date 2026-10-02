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
    <title>Users - UserHub</title>
    
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
                            <a href="users.jsp" class="sidebar-nav-link active">
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
                        <span class="topbar-breadcrumb-label">Directory</span>
                        <span class="topbar-breadcrumb-divider">/</span>
                        <span class="topbar-breadcrumb-label topbar-breadcrumb-active">User Accounts</span>
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
                        <span class="page-eyebrow">User Directory</span>
                        <h1 class="page-title-text">Registered Accounts</h1>
                        <p class="page-subtitle-text">Manage registered users, inspect credentials, and maintain account information.</p>
                    </div>
                    <div>
                        <a href="add-user.jsp" class="btn-primary-product">
                            <i class="bi bi-plus-lg"></i>
                            <span>Add New User</span>
                        </a>
                    </div>
                </div>

                <!-- Centerpiece Data Table Surface -->
                <div class="directory-surface-card">
                    
                    <!-- Search & Counter Toolbar -->
                    <div class="directory-toolbar">
                        <div class="search-field-wrapper">
                            <i class="bi bi-search search-field-icon"></i>
                            <input type="text" class="search-input-element" id="searchInput" placeholder="Search by name, email, phone, or address..." autocomplete="off">
                            <button type="button" class="search-clear-trigger" id="resetSearchBtn" title="Clear search">
                                Clear
                            </button>
                        </div>

                        <div>
                            <span class="directory-count-pill" id="userCountBadge">Loading users...</span>
                        </div>
                    </div>

                    <!-- Enterprise Table -->
                    <div class="table-responsive-pane">
                        <table class="enterprise-table" id="usersTable">
                            <thead>
                                <tr>
                                    <th style="width: 80px;">ID</th>
                                    <th>User Identity</th>
                                    <th>Phone</th>
                                    <th>Address</th>
                                    <th style="width: 160px; text-align: right;">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td colspan="5" class="text-center text-muted py-4">
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

    <!-- Edit User Modal -->
    <div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editUserModalLabel">
                        <i class="bi bi-pencil-square text-primary me-2"></i>Edit User Details
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="editUserForm" novalidate>
                    <div class="modal-body">
                        <div id="editModalAlert" class="alert d-none mb-3" role="alert"></div>
                        <input type="hidden" id="editUserId">

                        <div class="mb-3">
                            <label for="editName" class="form-field-label">Full Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-text-input" id="editName" required>
                        </div>

                        <div class="mb-3">
                            <label for="editEmail" class="form-field-label">Email Address <span class="text-danger">*</span></label>
                            <input type="email" class="form-text-input" id="editEmail" required>
                        </div>

                        <div class="mb-3">
                            <label for="editPhone" class="form-field-label">Phone Number</label>
                            <input type="tel" class="form-text-input" id="editPhone" placeholder="e.g. 9876543210">
                        </div>

                        <div class="mb-3">
                            <label for="editAddress" class="form-field-label">Address</label>
                            <input type="text" class="form-text-input" id="editAddress" placeholder="Street, City, State">
                        </div>

                        <div class="mb-2">
                            <label for="editPassword" class="form-field-label">New Password (optional)</label>
                            <input type="password" class="form-text-input" id="editPassword" placeholder="Leave blank to keep existing password">
                            <div class="form-helper-hint">Only specify if updating user credentials.</div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn-secondary-product" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn-primary-product" id="saveEditBtn">
                            <i class="bi bi-check-lg"></i>
                            <span>Save Changes</span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteUserModal" tabindex="-1" aria-labelledby="deleteUserModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-sm">
            <div class="modal-content">
                <div class="modal-body text-center pt-4 pb-3">
                    <div class="text-danger mb-3">
                        <i class="bi bi-exclamation-triangle" style="font-size: 2.25rem;"></i>
                    </div>
                    <h5 class="fw-bold mb-2">Delete User?</h5>
                    <p class="text-muted small mb-2">
                        Are you sure you want to delete <strong id="deleteUserName" class="text-dark"></strong> <span class="table-id-badge" id="deleteUserIdBadge"></span>?
                    </p>
                    <div class="text-danger small fw-semibold">
                        This action cannot be undone.
                    </div>
                </div>
                <div class="modal-footer justify-content-center border-0 pt-0 pb-4">
                    <button type="button" class="btn-secondary-product" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn-danger-product" id="confirmDeleteBtn">Delete User</button>
                </div>
            </div>
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
