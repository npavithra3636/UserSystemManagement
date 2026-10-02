$(document).ready(function () {

    // Auto-fill demo credentials on clicking the demo box
    $(".demo-credentials-box, .demo-credentials-box code, .demo-credentials-card, .demo-credentials-card code").on("click", function () {
        $("#email").val("admin@userhub.com");
        $("#password").val("admin123");
        $("#loginAlert").addClass("d-none");
    });

    // Toggle Password Visibility
    $("#togglePassword").on("click", function () {
        const passwordField = $("#password");
        const eyeIcon = $("#eyeIcon");

        if (passwordField.attr("type") === "password") {
            passwordField.attr("type", "text");
            eyeIcon.removeClass("bi-eye").addClass("bi-eye-slash");
        } else {
            passwordField.attr("type", "password");
            eyeIcon.removeClass("bi-eye-slash").addClass("bi-eye");
        }
    });

    // Handle Login Submit via AJAX
    $("#loginForm").on("submit", function (e) {
        e.preventDefault();

        const alertBox = $("#loginAlert");
        alertBox.addClass("d-none").removeClass("alert-danger alert-success").text("");

        const email = $("#email").val().trim();
        const password = $("#password").val();

        if (!email || !password) {
            alertBox.removeClass("d-none").addClass("alert-danger").text("Please provide both email and password.");
            return;
        }

        const submitBtn = $("#loginBtn");
        const origHtml = submitBtn.html();
        submitBtn.prop("disabled", true).html('<span class="spinner-border spinner-border-sm me-2"></span> Authenticating...');

        const payload = {
            email: email,
            password: password
        };

        $.ajax({
            url: "api/login",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(payload),
            dataType: "json",
            success: function (response) {
                if (response && response.success) {
                    alertBox.removeClass("d-none").addClass("alert-success").text("Authentication successful. Redirecting to dashboard...");
                    setTimeout(function () {
                        window.location.href = response.redirect || "home.jsp";
                    }, 400);
                } else {
                    submitBtn.prop("disabled", false).html(origHtml);
                    alertBox.removeClass("d-none").addClass("alert-danger").text(response.message || "Invalid email or password.");
                }
            },
            error: function (xhr) {
                submitBtn.prop("disabled", false).html(origHtml);
                let msg = "Invalid email or password.";
                try {
                    const res = JSON.parse(xhr.responseText);
                    if (res && res.message) msg = res.message;
                } catch (e) {}
                alertBox.removeClass("d-none").addClass("alert-danger").text(msg);
            }
        });
    });
});
