<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="header.jsp" />

<div class="row justify-content-center">
    <div class="col-md-8 col-lg-6">
        <div class="card shadow">
            <div class="card-header bg-success text-white text-center">
                <h4 class="mb-0">
                    <i class="fas fa-user-plus me-2"></i>Create Account
                </h4>
            </div>
            <div class="card-body">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>${error}
                    </div>
                </c:if>
                
                <form id="registerForm" method="post" action="/api/auth/register">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="username" class="form-label">Username *</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-user"></i>
                                </span>
                                <input type="text" class="form-control" id="username" name="username" 
                                       required minlength="3" maxlength="50" 
                                       pattern="[a-zA-Z0-9_]+" title="Username can only contain letters, numbers, and underscores">
                            </div>
                            <div class="form-text">3-50 characters, letters, numbers, and underscores only</div>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="name" class="form-label">Full Name *</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-id-card"></i>
                                </span>
                                <input type="text" class="form-control" id="name" name="name" 
                                       required minlength="2" maxlength="100">
                            </div>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="email" class="form-label">Email Address *</label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-envelope"></i>
                            </span>
                            <input type="email" class="form-control" id="email" name="email" 
                                   required>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="password" class="form-label">Password *</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-lock"></i>
                                </span>
                                <input type="password" class="form-control" id="password" name="password" 
                                       required minlength="8" 
                                       pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
                                       title="Password must be at least 8 characters and contain uppercase, lowercase, number, and special character">
                            </div>
                            <div class="form-text">Minimum 8 characters with uppercase, lowercase, number, and special character</div>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="confirmPassword" class="form-label">Confirm Password *</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-lock"></i>
                                </span>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                                       required>
                            </div>
                            <div id="passwordMatch" class="form-text"></div>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="termsAccepted" required>
                            <label class="form-check-label" for="termsAccepted">
                                I agree to the <a href="#" data-bs-toggle="modal" data-bs-target="#termsModal">Terms and Conditions</a>
                            </label>
                        </div>
                    </div>
                    
                    <div class="d-grid">
                        <button type="submit" class="btn btn-success btn-lg" id="submitBtn" disabled>
                            <i class="fas fa-user-plus me-2"></i>Create Account
                        </button>
                    </div>
                </form>
                
                <hr class="my-4">
                
                <div class="text-center">
                    <p class="mb-0">Already have an account?</p>
                    <a href="/login" class="btn btn-outline-primary btn-sm">
                        <i class="fas fa-sign-in-alt me-1"></i>Login Now
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Terms and Conditions Modal -->
<div class="modal fade" id="termsModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Terms and Conditions</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <h6>Municipal Complaint System - Terms of Use</h6>
                <p>By using this system, you agree to:</p>
                <ul>
                    <li>Provide accurate and truthful information</li>
                    <li>Use the system for legitimate complaint reporting only</li>
                    <li>Respect the privacy and rights of others</li>
                    <li>Not misuse or attempt to compromise system security</li>
                    <li>Follow all applicable laws and regulations</li>
                </ul>
                <p>The municipality reserves the right to suspend or terminate access for violations.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script>
// Password confirmation validation
document.getElementById('confirmPassword').addEventListener('input', function() {
    const password = document.getElementById('password').value;
    const confirmPassword = this.value;
    const matchDiv = document.getElementById('passwordMatch');
    const submitBtn = document.getElementById('submitBtn');
    
    if (confirmPassword === '') {
        matchDiv.textContent = '';
        matchDiv.className = 'form-text';
    } else if (password === confirmPassword) {
        matchDiv.textContent = 'Passwords match';
        matchDiv.className = 'form-text text-success';
    } else {
        matchDiv.textContent = 'Passwords do not match';
        matchDiv.className = 'form-text text-danger';
    }
    
    // Enable/disable submit button based on form validity
    const form = document.getElementById('registerForm');
    const termsAccepted = document.getElementById('termsAccepted').checked;
    submitBtn.disabled = !form.checkValidity() || !termsAccepted;
});

// Form validation
document.getElementById('registerForm').addEventListener('input', function() {
    const submitBtn = document.getElementById('submitBtn');
    const termsAccepted = document.getElementById('termsAccepted').checked;
    submitBtn.disabled = !this.checkValidity() || !termsAccepted;
});

document.getElementById('termsAccepted').addEventListener('change', function() {
    const submitBtn = document.getElementById('submitBtn');
    const form = document.getElementById('registerForm');
    submitBtn.disabled = !form.checkValidity() || !this.checked;
});

// Form submission
document.getElementById('registerForm').addEventListener('submit', async function(e) {
    e.preventDefault();
    
    const formData = new FormData(this);
    const registerData = {
        username: formData.get('username'),
        name: formData.get('name'),
        email: formData.get('email'),
        password: formData.get('password'),
        confirmPassword: formData.get('confirmPassword')
    };
    
    try {
        const response = await fetch('/api/auth/register', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(registerData)
        });
        
        if (response.ok) {
            const result = await response.json();
            showNotification('Registration successful! Please login.', 'success');
            
            // Redirect to login page after 2 seconds
            setTimeout(() => {
                window.location.href = '/login';
            }, 2000);
        } else {
            const errorData = await response.json();
            showNotification(errorData.message || 'Registration failed', 'danger');
        }
    } catch (error) {
        console.error('Registration error:', error);
        showNotification('An error occurred during registration', 'danger');
    }
});
</script>

<jsp:include page="footer.jsp" />