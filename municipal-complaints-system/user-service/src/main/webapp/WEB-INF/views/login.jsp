<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="header.jsp" />

<div class="row justify-content-center">
    <div class="col-md-6 col-lg-4">
        <div class="card shadow">
            <div class="card-header bg-primary text-white text-center">
                <h4 class="mb-0">
                    <i class="fas fa-sign-in-alt me-2"></i>Login
                </h4>
            </div>
            <div class="card-body">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>${error}
                    </div>
                </c:if>
                
                <form id="loginForm" method="post" action="/api/auth/login">
                    <div class="mb-3">
                        <label for="username" class="form-label">Username</label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-user"></i>
                            </span>
                            <input type="text" class="form-control" id="username" name="username" 
                                   required minlength="3" maxlength="50">
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-lock"></i>
                            </span>
                            <input type="password" class="form-control" id="password" name="password" 
                                   required minlength="6">
                        </div>
                    </div>
                    
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary btn-lg">
                            <i class="fas fa-sign-in-alt me-2"></i>Login
                        </button>
                    </div>
                </form>
                
                <hr class="my-4">
                
                <div class="text-center">
                    <p class="mb-0">Don't have an account?</p>
                    <a href="/register" class="btn btn-outline-secondary btn-sm">
                        <i class="fas fa-user-plus me-1"></i>Register Now
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
document.getElementById('loginForm').addEventListener('submit', async function(e) {
    e.preventDefault();
    
    const formData = new FormData(this);
    const loginData = {
        username: formData.get('username'),
        password: formData.get('password')
    };
    
    try {
        const response = await fetch('/api/auth/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(loginData)
        });
        
        if (response.ok) {
            const result = await response.json();
            showNotification('Login successful! Redirecting...', 'success');
            
            // Redirect based on user role
            setTimeout(() => {
                if (result.user && result.user.role) {
                    switch (result.user.role) {
                        case 'ROLE_CITIZEN':
                            window.location.href = '/citizen/home';
                            break;
                        case 'ROLE_STAFF':
                            window.location.href = '/staff/home';
                            break;
                        case 'ROLE_ADMIN':
                            window.location.href = '/admin/home';
                            break;
                        default:
                            window.location.href = '/';
                    }
                } else {
                    window.location.href = '/';
                }
            }, 1000);
        } else {
            const errorData = await response.json();
            showNotification(errorData.message || 'Login failed', 'danger');
        }
    } catch (error) {
        console.error('Login error:', error);
        showNotification('An error occurred during login', 'danger');
    }
});
</script>

<jsp:include page="footer.jsp" />