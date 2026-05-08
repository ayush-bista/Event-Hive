<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/favicon.png">
    <title>My Profile &mdash; Event Hive</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="page-wrapper">
    <%@ include file="../includes/sidebar.jsp" %>
    <div class="main-content">
        <div class="top-bar">
            <div class="top-bar-title">My Profile</div>
            <div class="top-bar-actions">
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline btn-sm">Sign Out</a>
            </div>
        </div>

        <div class="page-body">
            <c:if test="${not empty error}">
                <div class="alert alert-error mb-16">! ${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success mb-16">${success}</div>
            </c:if>

            <div style="display:grid; grid-template-columns:1fr 1fr; gap:20px;">

                <!-- Profile Image -->
                <div class="card profile-image-card">
                    <h3 style="font-size:1rem; margin-bottom:20px;">Profile Image</h3>
                    <div class="profile-photo-row">
                        <div class="profile-photo-preview">
                            <c:choose>
                                <c:when test="${not empty sessionScope.loggedInUser.profilePic}">
                                    <img src="${pageContext.request.contextPath}/uploads/profiles/${sessionScope.loggedInUser.profilePic}"
                                         alt="${sessionScope.loggedInUser.fullName} profile image">
                                </c:when>
                                <c:otherwise>
                                    <span>${fn:substring(sessionScope.loggedInUser.fullName, 0, 1)}</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div>
                            <div class="profile-photo-title">Add or update your profile image</div>
                            <div class="profile-photo-copy">Choose an image, adjust the square crop, then apply it.</div>
                        </div>
                    </div>

                    <form method="post" action="${pageContext.request.contextPath}/student/profile" id="profileImageForm">
                        <input type="hidden" name="action" value="updateProfileImage">
                        <input type="hidden" name="croppedImage" id="croppedImage">
                        <div class="form-group">
                            <label class="form-label">Image</label>
                            <input type="file" id="profileImageInput" class="form-control" accept="image/png,image/jpeg,image/jpg">
                        </div>
                        <div class="crop-panel" id="cropPanel">
                            <canvas id="cropCanvas" width="260" height="260" aria-label="Profile image crop preview"></canvas>
                            <div class="form-group mt-16">
                                <label class="form-label">Zoom</label>
                                <input type="range" id="cropZoom" min="1" max="3" step="0.01" value="1" class="form-control">
                            </div>
                            <button type="button" class="btn btn-primary" id="applyCropBtn">Apply Profile Image</button>
                        </div>
                    </form>
                </div>

                <!-- Update Profile -->
                <div class="card">
                    <h3 style="font-size:1rem; margin-bottom:20px;">Personal Information</h3>
                    <form method="post" action="${pageContext.request.contextPath}/student/profile">
                        <input type="hidden" name="action" value="updateProfile">
                        <div class="form-group">
                            <label class="form-label">Full Name</label>
                            <input type="text" name="fullName" class="form-control"
                                   value="${sessionScope.loggedInUser.fullName}" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Email <span class="text-muted">(read only)</span></label>
                            <input type="email" class="form-control"
                                   value="${sessionScope.loggedInUser.email}" readonly
                                   style="opacity:0.5; cursor:not-allowed;">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Phone</label>
                            <input type="text" name="phone" class="form-control"
                                   value="${sessionScope.loggedInUser.phone}" maxlength="10">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Date of Birth</label>
                            <input type="date" name="dateOfBirth" class="form-control"
                                   value="${sessionScope.loggedInUser.dateOfBirth}">
                        </div>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </form>
                </div>

                <!-- Change Password -->
                <div class="card">
                    <h3 style="font-size:1rem; margin-bottom:20px;">Change Password</h3>
                    <form method="post" action="${pageContext.request.contextPath}/student/profile">
                        <input type="hidden" name="action" value="changePassword">
                        <div class="form-group">
                            <label class="form-label">Current Password</label>
                            <input type="password" name="currentPassword" class="form-control"
                                   placeholder="Enter current password" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">New Password</label>
                            <input type="password" name="newPassword" class="form-control"
                                   placeholder="Min 8 chars, 1 upper, 1 digit, 1 special" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Confirm New Password</label>
                            <input type="password" name="confirmPassword" class="form-control"
                                   placeholder="Repeat new password" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Update Password</button>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>
<style>
    .profile-image-card {
        grid-column: 1 / -1;
    }
    .profile-photo-row {
        display: flex;
        align-items: center;
        gap: 16px;
        margin-bottom: 20px;
    }
    .profile-photo-preview {
        width: 88px;
        height: 88px;
        border-radius: 50%;
        background: linear-gradient(135deg, var(--violet), var(--cyan));
        color: #ffffff;
        display: flex;
        align-items: center;
        justify-content: center;
        font-family: 'Manrope', sans-serif;
        font-size: 2rem;
        font-weight: 800;
        overflow: hidden;
        flex: 0 0 auto;
    }
    .profile-photo-preview img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    .profile-photo-title {
        font-weight: 700;
        margin-bottom: 2px;
    }
    .profile-photo-copy {
        color: var(--text-muted);
        font-size: 0.9rem;
    }
    .crop-panel {
        display: none;
        align-items: flex-start;
        gap: 18px;
        flex-wrap: wrap;
        margin-top: 16px;
    }
    .crop-panel.is-open {
        display: flex;
    }
    #cropCanvas {
        width: 260px;
        height: 260px;
        border-radius: 12px;
        border: 1px solid var(--border);
        background: #f3f4f6;
        cursor: move;
        touch-action: none;
    }
    @media (max-width: 700px) {
        .page-body > div { grid-template-columns: 1fr !important; }
        .profile-photo-row { align-items: flex-start; }
        #cropCanvas { width: 220px; height: 220px; }
    }
</style>
<script>
    (() => {
        const input = document.getElementById('profileImageInput');
        const panel = document.getElementById('cropPanel');
        const canvas = document.getElementById('cropCanvas');
        const zoomInput = document.getElementById('cropZoom');
        const applyBtn = document.getElementById('applyCropBtn');
        const output = document.getElementById('croppedImage');
        const form = document.getElementById('profileImageForm');
        const ctx = canvas.getContext('2d');

        let image = null;
        let zoom = 1;
        let offsetX = 0;
        let offsetY = 0;
        let dragging = false;
        let lastX = 0;
        let lastY = 0;

        const clampOffsets = () => {
            if (!image) return;
            const base = Math.max(canvas.width / image.width, canvas.height / image.height);
            const drawW = image.width * base * zoom;
            const drawH = image.height * base * zoom;
            const maxX = Math.max(0, (drawW - canvas.width) / 2);
            const maxY = Math.max(0, (drawH - canvas.height) / 2);
            offsetX = Math.max(-maxX, Math.min(maxX, offsetX));
            offsetY = Math.max(-maxY, Math.min(maxY, offsetY));
        };

        const drawCrop = () => {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.fillStyle = '#f3f4f6';
            ctx.fillRect(0, 0, canvas.width, canvas.height);
            if (!image) return;

            clampOffsets();
            const base = Math.max(canvas.width / image.width, canvas.height / image.height);
            const drawW = image.width * base * zoom;
            const drawH = image.height * base * zoom;
            const x = (canvas.width - drawW) / 2 + offsetX;
            const y = (canvas.height - drawH) / 2 + offsetY;

            ctx.save();
            ctx.beginPath();
            ctx.rect(0, 0, canvas.width, canvas.height);
            ctx.clip();
            ctx.drawImage(image, x, y, drawW, drawH);
            ctx.restore();
        };

        input.addEventListener('change', () => {
            const file = input.files && input.files[0];
            if (!file) return;
            if (!file.type.startsWith('image/')) return;

            const reader = new FileReader();
            reader.onload = () => {
                image = new Image();
                image.onload = () => {
                    zoom = 1;
                    offsetX = 0;
                    offsetY = 0;
                    zoomInput.value = '1';
                    panel.classList.add('is-open');
                    drawCrop();
                };
                image.src = reader.result;
            };
            reader.readAsDataURL(file);
        });

        zoomInput.addEventListener('input', () => {
            zoom = Number(zoomInput.value);
            drawCrop();
        });

        canvas.addEventListener('pointerdown', (event) => {
            if (!image) return;
            dragging = true;
            lastX = event.clientX;
            lastY = event.clientY;
            canvas.setPointerCapture(event.pointerId);
        });

        canvas.addEventListener('pointermove', (event) => {
            if (!dragging) return;
            offsetX += event.clientX - lastX;
            offsetY += event.clientY - lastY;
            lastX = event.clientX;
            lastY = event.clientY;
            drawCrop();
        });

        canvas.addEventListener('pointerup', () => { dragging = false; });
        canvas.addEventListener('pointercancel', () => { dragging = false; });

        applyBtn.addEventListener('click', () => {
            if (!image) return;
            output.value = canvas.toDataURL('image/png');
            form.submit();
        });
    })();
</script>
</body>
</html>
