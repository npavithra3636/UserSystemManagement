/**
 * UserHub - Enterprise User Management JavaScript
 */

let deleteTargetId = null;

$(document).ready(function () {

    // Mobile Sidebar Drawer Toggle
    $("#sidebarToggle").on("click", function () {
        $("#appSidebar").toggleClass("show");
    });

    // Close sidebar when clicking outside on mobile screens
    $(document).on("click", function (e) {
        if ($(window).width() < 992) {
            if (!$(e.target).closest("#appSidebar, #sidebarToggle").length) {
                $("#appSidebar").removeClass("show");
            }
        }
    });

    // 1. Dashboard Initialization
    if ($("#dashboardUsersTable").length > 0) {
        loadDashboard();
    }

    // 2. Users Table Initialization
    if ($("#usersTable").length > 0) {
        loadUsers("");

        // Debounced Live Search
        let searchTimeout;
        $("#searchInput").on("input", function () {
            clearTimeout(searchTimeout);
            const query = $(this).val();
            searchTimeout = setTimeout(function () {
                loadUsers(query);
            }, 200);
        });

        // Clear / Reset Search
        $("#resetSearchBtn").on("click", function () {
            $("#searchInput").val("").focus();
            loadUsers("");
        });
    }

    // 3. Add User Form
    $("#addUserForm").on("submit", function (e) {
        e.preventDefault();
        saveUser();
    });

    // 4. Edit User Form
    $("#editUserForm").on("submit", function (e) {
        e.preventDefault();
        updateUser();
    });

    // 5. Delete Confirmation Action
    $("#confirmDeleteBtn").on("click", function () {
        if (deleteTargetId) {
            executeDelete(deleteTargetId);
        }
    });

    // 6. Logout Modal Trigger (Always opens confirmation dialog first)
    $(".btn-logout").on("click", function (e) {
        e.preventDefault();
        openLogoutModal();
    });

    // 7. Confirmed Logout Execution
    $("#confirmLogoutBtn").on("click", function () {
        executeLogout();
    });
});

/**
 * Loads Dashboard Metrics and Recent Users from Database
 */
function loadDashboard() {
    $.ajax({
        url: "api/users",
        type: "GET",
        dataType: "json",
        success: function (users) {
            const list = users || [];
            $("#totalUsersCount").text(list.length);

            const tbody = $("#dashboardUsersTable tbody");
            tbody.empty();

            if (list.length === 0) {
                tbody.append(`
                    <tr>
                        <td colspan="4">
                            <div class="empty-state-box">
                                <div class="empty-state-icon-circle"><i class="bi bi-people"></i></div>
                                <h6 class="fw-bold mb-1">No users registered yet</h6>
                                <p class="text-muted small mb-0">Get started by creating the first user in the database.</p>
                            </div>
                        </td>
                    </tr>
                `);
                return;
            }

            const recent = list.slice(0, 5);
            recent.forEach(function (user) {
                const initials = user.name ? user.name.charAt(0).toUpperCase() : "U";
                tbody.append(`
                    <tr>
                        <td><span class="table-id-badge">#${user.id}</span></td>
                        <td>
                            <div class="user-identity-cell">
                                <div class="user-avatar-circle">${initials}</div>
                                <div>
                                    <div class="user-name-primary">${escapeHtml(user.name)}</div>
                                    <div class="user-email-secondary">${escapeHtml(user.email)}</div>
                                </div>
                            </div>
                        </td>
                        <td><span class="text-secondary small fw-medium">${escapeHtml(user.phone || "-")}</span></td>
                        <td><span class="text-muted small">${escapeHtml(user.address || "-")}</span></td>
                    </tr>
                `);
            });
        },
        error: function (xhr) {
            if (xhr.status === 401) {
                window.location.href = "login.jsp";
            }
        }
    });
}

/**
 * Loads and renders users directory with live search filtering
 */
function loadUsers(searchQuery) {
    let url = "api/users";
    if (searchQuery && searchQuery.trim() !== "") {
        url += "?search=" + encodeURIComponent(searchQuery.trim());
    }

    $.ajax({
        url: url,
        type: "GET",
        dataType: "json",
        success: function (users) {
            const list = users || [];
            const tbody = $("#usersTable tbody");
            tbody.empty();

            $("#userCountBadge").text(list.length + (list.length === 1 ? " user registered" : " users registered"));

            if (list.length === 0) {
                tbody.append(`
                    <tr>
                        <td colspan="5">
                            <div class="empty-state-box">
                                <div class="empty-state-icon-circle"><i class="bi bi-search"></i></div>
                                <h6 class="fw-bold mb-1">No matching users found</h6>
                                <p class="text-muted small mb-0">Try adjusting your search criteria or add a new user.</p>
                            </div>
                        </td>
                    </tr>
                `);
                return;
            }

            list.forEach(function (user) {
                const initials = user.name ? user.name.charAt(0).toUpperCase() : "U";
                tbody.append(`
                    <tr>
                        <td><span class="table-id-badge">#${user.id}</span></td>
                        <td>
                            <div class="user-identity-cell">
                                <div class="user-avatar-circle">${initials}</div>
                                <div>
                                    <div class="user-name-primary">${escapeHtml(user.name)}</div>
                                    <div class="user-email-secondary">${escapeHtml(user.email)}</div>
                                </div>
                            </div>
                        </td>
                        <td><span class="text-secondary small fw-medium">${escapeHtml(user.phone || "-")}</span></td>
                        <td><span class="text-muted small">${escapeHtml(user.address || "-")}</span></td>
                        <td class="text-end">
                            <div class="table-action-group">
                                <button type="button" class="action-btn-pill action-btn-edit" onclick="openEditModal(${user.id})" title="Edit User">
                                    <i class="bi bi-pencil-square"></i>
                                    <span>Edit</span>
                                </button>
                                <button type="button" class="action-btn-pill action-btn-delete" onclick="openDeleteModal(${user.id}, '${escapeHtml(user.name).replace(/'/g, "\\'")}')" title="Delete User">
                                    <i class="bi bi-trash"></i>
                                    <span>Delete</span>
                                </button>
                            </div>
                        </td>
                    </tr>
                `);
            });
        },
        error: function (xhr) {
            if (xhr.status === 401) {
                window.location.href = "login.jsp";
            }
        }
    });
}

/**
 * Creates a new user record via AJAX POST /api/users
 */
function saveUser() {
    const alertBox = $("#formAlert");
    alertBox.addClass("d-none").removeClass("alert-danger alert-success").text("");

    const name = $("#addName").val().trim();
    const email = $("#addEmail").val().trim();
    const phone = $("#addPhone").val().trim();
    const address = $("#addAddress").val().trim();
    const password = $("#addPassword").val().trim();

    if (!name || !email || !password) {
        alertBox.removeClass("d-none").addClass("alert-danger").text("Full Name, email address, and password are required.");
        return;
    }

    const saveBtn = $("#saveUserBtn");
    const origHtml = saveBtn.html();
    saveBtn.prop("disabled", true).html('<span class="spinner-border spinner-border-sm me-1"></span> Saving...');

    const payload = {
        name: name,
        email: email,
        phone: phone,
        address: address,
        password: password
    };

    $.ajax({
        url: "api/users",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(payload),
        dataType: "json",
        success: function (response) {
            saveBtn.prop("disabled", false).html(origHtml);
            if (response && response.success) {
                showToast("User registered successfully.", "success");
                alertBox.removeClass("d-none").addClass("alert-success").text("User registered successfully! Redirecting to directory...");
                setTimeout(function () {
                    window.location.href = "users.jsp";
                }, 600);
            } else {
                alertBox.removeClass("d-none").addClass("alert-danger").text(response.message || "Failed to create user.");
                showToast(response.message || "Failed to create user.", "danger");
            }
        },
        error: function (xhr) {
            saveBtn.prop("disabled", false).html(origHtml);
            let msg = "Failed to add user.";
            try {
                const res = JSON.parse(xhr.responseText);
                if (res && res.message) msg = res.message;
            } catch (e) {}
            alertBox.removeClass("d-none").addClass("alert-danger").text(msg);
            showToast(msg, "danger");
        }
    });
}

/**
 * Opens Edit User Modal with pre-loaded details
 */
function openEditModal(id) {
    const alertBox = $("#editModalAlert");
    alertBox.addClass("d-none").removeClass("alert-danger alert-success").text("");

    $.ajax({
        url: "api/users/" + id,
        type: "GET",
        dataType: "json",
        success: function (user) {
            if (user) {
                $("#editUserId").val(user.id);
                $("#editName").val(user.name);
                $("#editEmail").val(user.email);
                $("#editPhone").val(user.phone || "");
                $("#editAddress").val(user.address || "");
                $("#editPassword").val("");

                const modal = new bootstrap.Modal(document.getElementById("editUserModal"));
                modal.show();
            }
        },
        error: function () {
            showToast("Failed to fetch user details for editing.", "danger");
        }
    });
}

/**
 * Submits updated user data via AJAX PUT /api/users/{id}
 */
function updateUser() {
    const alertBox = $("#editModalAlert");
    alertBox.addClass("d-none").removeClass("alert-danger alert-success").text("");

    const id = $("#editUserId").val();
    const name = $("#editName").val().trim();
    const email = $("#editEmail").val().trim();
    const phone = $("#editPhone").val().trim();
    const address = $("#editAddress").val().trim();
    const password = $("#editPassword").val().trim();

    if (!name || !email) {
        alertBox.removeClass("d-none").addClass("alert-danger").text("Full Name and email address are required.");
        return;
    }

    const saveBtn = $("#saveEditBtn");
    const origHtml = saveBtn.html();
    saveBtn.prop("disabled", true).html('<span class="spinner-border spinner-border-sm me-1"></span> Saving...');

    const payload = {
        name: name,
        email: email,
        phone: phone,
        address: address
    };
    if (password) {
        payload.password = password;
    }

    $.ajax({
        url: "api/users/" + id,
        type: "PUT",
        contentType: "application/json",
        data: JSON.stringify(payload),
        dataType: "json",
        success: function (response) {
            saveBtn.prop("disabled", false).html(origHtml);
            if (response && response.success) {
                const modalEl = document.getElementById("editUserModal");
                const modal = bootstrap.Modal.getInstance(modalEl);
                if (modal) modal.hide();

                showToast("User details updated successfully.", "success");
                loadUsers($("#searchInput").val() || "");
            } else {
                alertBox.removeClass("d-none").addClass("alert-danger").text(response.message || "Update failed.");
                showToast(response.message || "Update failed.", "danger");
            }
        },
        error: function (xhr) {
            saveBtn.prop("disabled", false).html(origHtml);
            let msg = "Failed to update user.";
            try {
                const res = JSON.parse(xhr.responseText);
                if (res && res.message) msg = res.message;
            } catch (e) {}
            alertBox.removeClass("d-none").addClass("alert-danger").text(msg);
            showToast(msg, "danger");
        }
    });
}

/**
 * Opens Delete Confirmation Modal
 */
function openDeleteModal(id, name) {
    deleteTargetId = id;
    $("#deleteUserName").text(name);
    $("#deleteUserIdBadge").text("#" + id);
    const modal = new bootstrap.Modal(document.getElementById("deleteUserModal"));
    modal.show();
}

/**
 * Executes user deletion via AJAX DELETE /api/users/{id}
 */
function executeDelete(id) {
    const confirmBtn = $("#confirmDeleteBtn");
    const origHtml = confirmBtn.html();
    confirmBtn.prop("disabled", true).html('<span class="spinner-border spinner-border-sm me-1"></span> Deleting...');

    $.ajax({
        url: "api/users/" + id,
        type: "DELETE",
        dataType: "json",
        success: function (response) {
            confirmBtn.prop("disabled", false).html(origHtml);
            const modalEl = document.getElementById("deleteUserModal");
            const modal = bootstrap.Modal.getInstance(modalEl);
            if (modal) modal.hide();

            showToast("User record deleted successfully.", "success");
            loadUsers($("#searchInput").val() || "");
            deleteTargetId = null;
        },
        error: function () {
            confirmBtn.prop("disabled", false).html(origHtml);
            showToast("Failed to delete user record.", "danger");
            deleteTargetId = null;
        }
    });
}

/**
 * Opens Logout Confirmation Modal
 */
function openLogoutModal() {
    const modal = new bootstrap.Modal(document.getElementById("logoutConfirmModal"));
    modal.show();
}

/**
 * Confirms and executes logout via AJAX POST /api/login/logout
 */
function executeLogout() {
    const logoutBtn = $("#confirmLogoutBtn");
    logoutBtn.prop("disabled", true).html('<span class="spinner-border spinner-border-sm me-1"></span> Signing out...');

    $.ajax({
        url: "api/login/logout",
        type: "POST",
        dataType: "json",
        success: function (res) {
            window.location.href = (res && res.redirect) ? res.redirect : "login.jsp";
        },
        error: function () {
            window.location.href = "login.jsp";
        }
    });
}

/**
 * Enterprise Floating Toast Notification
 */
function showToast(message, type) {
    let container = $("#toastContainer");
    if (container.length === 0) {
        container = $('<div id="toastContainer" class="toast-container-custom"></div>');
        $("body").append(container);
    }

    const icon = type === "success" ? "bi-check-circle-fill text-success" : (type === "danger" ? "bi-exclamation-triangle-fill text-danger" : (type === "warning" ? "bi-exclamation-circle-fill text-warning" : "bi-info-circle-fill text-primary"));
    const toast = $(`
        <div class="toast-custom toast-${type}">
            <div class="d-flex align-items-center gap-2">
                <i class="bi ${icon} fs-5"></i>
                <span class="small fw-semibold text-dark">${escapeHtml(message)}</span>
            </div>
            <button type="button" class="btn-close btn-sm" aria-label="Close"></button>
        </div>
    `);

    toast.find(".btn-close").on("click", function () {
        toast.fadeOut(200, function () { toast.remove(); });
    });

    container.append(toast);

    setTimeout(function () {
        toast.fadeOut(300, function () { toast.remove(); });
    }, 4000);
}

function escapeHtml(str) {
    if (!str) return "";
    return $("<div>").text(str).html();
}
