<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="header.jsp" />

<div class="container mt-4">
    <!-- Welcome Section -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card bg-dark text-white">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h2 class="card-title mb-2">
                                <i class="bi bi-shield-check"></i>
                                Admin Dashboard - ${user.name}
                            </h2>
                            <p class="card-text mb-0">
                                System administration, user management, and comprehensive oversight of all municipal operations.
                            </p>
                        </div>
                        <div class="col-md-4 text-md-end">
                            <button class="btn btn-light btn-lg" onclick="showSystemStatus()">
                                <i class="bi bi-gear"></i>
                                System Status
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- System Overview Cards -->
    <div class="row mb-4">
        <div class="col-md-3 mb-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body text-center">
                    <div class="text-primary mb-2">
                        <i class="bi bi-people fs-1"></i>
                    </div>
                    <h3 class="card-title" id="totalUsers">0</h3>
                    <p class="card-text text-muted">Total Users</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body text-center">
                    <div class="text-warning mb-2">
                        <i class="bi bi-list-ul fs-1"></i>
                    </div>
                    <h3 class="card-title" id="totalComplaints">0</h3>
                    <p class="card-text text-muted">Total Complaints</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body text-center">
                    <div class="text-info mb-2">
                        <i class="bi bi-building fs-1"></i>
                    </div>
                    <h3 class="card-title" id="totalDepartments">0</h3>
                    <p class="card-text text-muted">Departments</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body text-center">
                    <div class="text-success mb-2">
                        <i class="bi bi-bell fs-1"></i>
                    </div>
                    <h3 class="card-title" id="totalNotifications">0</h3>
                    <p class="card-text text-muted">Notifications</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Actions Section -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white">
                    <h5 class="mb-0">
                        <i class="bi bi-lightning"></i>
                        Quick Actions
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-2 mb-3">
                            <button class="btn btn-outline-primary w-100 h-100 py-3" onclick="showUserManagement()">
                                <i class="bi bi-person-plus fs-2 d-block mb-2"></i>
                                Manage Users
                            </button>
                        </div>
                        <div class="col-md-2 mb-3">
                            <button class="btn btn-outline-info w-100 h-100 py-3" onclick="showDepartmentManagement()">
                                <i class="bi bi-building fs-2 d-block mb-2"></i>
                                Departments
                            </button>
                        </div>
                        <div class="col-md-2 mb-3">
                            <button class="btn btn-outline-success w-100 h-100 py-3" onclick="showSystemReports()">
                                <i class="bi bi-file-earmark-text fs-2 d-block mb-2"></i>
                                Reports
                            </button>
                        </div>
                        <div class="col-md-2 mb-3">
                            <button class="btn btn-outline-warning w-100 h-100 py-3" onclick="showSystemSettings()">
                                <i class="bi bi-gear fs-2 d-block mb-2"></i>
                                Settings
                            </button>
                        </div>
                        <div class="col-md-2 mb-3">
                            <button class="btn btn-outline-danger w-100 h-100 py-3" onclick="showSystemLogs()">
                                <i class="bi bi-journal-text fs-2 d-block mb-2"></i>
                                System Logs
                            </button>
                        </div>
                        <div class="col-md-2 mb-3">
                            <button class="btn btn-outline-secondary w-100 h-100 py-3" onclick="showBackupRestore()">
                                <i class="bi bi-cloud-arrow-up fs-2 d-block mb-2"></i>
                                Backup
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- System Status Overview -->
    <div class="row mb-4">
        <div class="col-md-6 mb-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-header bg-white">
                    <h5 class="mb-0">
                        <i class="bi bi-activity"></i>
                        System Health
                    </h5>
                </div>
                <div class="card-body">
                    <div id="systemHealth">
                        <div class="text-center py-3">
                            <div class="spinner-border text-primary" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                            <p class="mt-2 text-muted">Loading system health...</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6 mb-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-header bg-white">
                    <h5 class="mb-0">
                        <i class="bi bi-graph-up"></i>
                        Recent Activity
                    </h5>
                </div>
                <div class="card-body">
                    <div id="recentActivity">
                        <div class="text-center py-3">
                            <div class="spinner-border text-primary" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                            <p class="mt-2 text-muted">Loading recent activity...</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- User Management Section -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">
                            <i class="bi bi-people"></i>
                            User Management
                        </h5>
                        <div class="d-flex gap-2">
                            <button class="btn btn-primary btn-sm" onclick="showAddUserModal()">
                                <i class="bi bi-person-plus"></i>
                                Add User
                            </button>
                            <button class="btn btn-outline-primary btn-sm" onclick="refreshUsers()">
                                <i class="bi bi-arrow-clockwise"></i>
                                Refresh
                            </button>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div id="usersList">
                        <div class="text-center py-4">
                            <div class="spinner-border text-primary" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                            <p class="mt-2 text-muted">Loading users...</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Add User Modal -->
<div class="modal fade" id="addUserModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="bi bi-person-plus"></i>
                    Add New User
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form id="addUserForm">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="username" class="form-label">Username *</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    <div class="mb-3">
                        <label for="name" class="form-label">Full Name *</label>
                        <input type="text" class="form-control" id="name" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email *</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password *</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <div class="mb-3">
                        <label for="role" class="form-label">Role *</label>
                        <select class="form-select" id="role" name="role" required>
                            <option value="">Choose role...</option>
                            <option value="CITIZEN">Citizen</option>
                            <option value="STAFF">Staff</option>
                            <option value="ADMIN">Admin</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-send"></i>
                        Add User
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit User Modal -->
<div class="modal fade" id="editUserModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="bi bi-person-gear"></i>
                    Edit User
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form id="editUserForm">
                <div class="modal-body">
                    <input type="hidden" id="editUserId" name="id">
                    <div class="mb-3">
                        <label for="editUsername" class="form-label">Username</label>
                        <input type="text" class="form-control" id="editUsername" name="username" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="editName" class="form-label">Full Name *</label>
                        <input type="text" class="form-control" id="editName" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="editEmail" class="form-label">Email *</label>
                        <input type="email" class="form-control" id="editEmail" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="editRole" class="form-label">Role *</label>
                        <select class="form-select" id="editRole" name="role" required>
                            <option value="CITIZEN">Citizen</option>
                            <option value="STAFF">Staff</option>
                            <option value="ADMIN">Admin</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="editStatus" class="form-label">Status</label>
                        <select class="form-select" id="editStatus" name="status">
                            <option value="ACTIVE">Active</option>
                            <option value="INACTIVE">Inactive</option>
                            <option value="SUSPENDED">Suspended</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-check-circle"></i>
                        Update User
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Department Management Modal -->
<div class="modal fade" id="departmentManagementModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="bi bi-building"></i>
                    Department Management
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div id="departmentManagementContent">
                    <!-- Content will be loaded dynamically -->
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />

<!-- Custom JavaScript for Admin Dashboard -->
<script>
    // Global variables
    let currentUsers = [];
    let systemStats = {};
    
    // Initialize dashboard
    document.addEventListener('DOMContentLoaded', function() {
        loadDashboardData();
        setupEventListeners();
    });
    
    function setupEventListeners() {
        // Form submissions
        document.getElementById('addUserForm').addEventListener('submit', function(e) {
            e.preventDefault();
            addUser();
        });
        
        document.getElementById('editUserForm').addEventListener('submit', function(e) {
            e.preventDefault();
            updateUser();
        });
    }
    
    // Load all dashboard data
    async function loadDashboardData() {
        await Promise.all([
            loadSystemStats(),
            loadUsers(),
            loadSystemHealth(),
            loadRecentActivity()
        ]);
    }
    
    // Load system statistics
    async function loadSystemStats() {
        try {
            const response = await fetch('/api/admin/stats', {
                headers: {
                    'Authorization': `Bearer ${getJwtToken()}`
                }
            });
            
            if (response.ok) {
                systemStats = await response.json();
                updateStatistics();
            } else {
                throw new Error('Failed to load system stats');
            }
        } catch (error) {
            console.error('Error loading system stats:', error);
            showAlert('Failed to load system statistics.', 'danger');
        }
    }
    
    // Load users
    async function loadUsers() {
        try {
            const response = await fetch('/api/admin/users', {
                headers: {
                    'Authorization': `Bearer ${getJwtToken()}`
                }
            });
            
            if (response.ok) {
                currentUsers = await response.json();
                renderUsers();
            } else {
                throw new Error('Failed to load users');
            }
        } catch (error) {
            console.error('Error loading users:', error);
            showAlert('Failed to load users.', 'danger');
        }
    }
    
    // Load system health
    async function loadSystemHealth() {
        try {
            const response = await fetch('/actuator/health', {
                headers: {
                    'Authorization': `Bearer ${getJwtToken()}`
                }
            });
            
            if (response.ok) {
                const health = await response.json();
                renderSystemHealth(health);
            } else {
                throw new Error('Failed to load system health');
            }
        } catch (error) {
            console.error('Error loading system health:', error);
            renderSystemHealth({ status: 'UNKNOWN' });
        }
    }
    
    // Load recent activity
    async function loadRecentActivity() {
        try {
            const response = await fetch('/api/admin/activity', {
                headers: {
                    'Authorization': `Bearer ${getJwtToken()}`
                }
            });
            
            if (response.ok) {
                const activity = await response.json();
                renderRecentActivity(activity);
            } else {
                throw new Error('Failed to load recent activity');
            }
        } catch (error) {
            console.error('Error loading recent activity:', error);
            renderRecentActivity([]);
        }
    }
    
    // Update statistics display
    function updateStatistics() {
        document.getElementById('totalUsers').textContent = systemStats.totalUsers || 0;
        document.getElementById('totalComplaints').textContent = systemStats.totalComplaints || 0;
        document.getElementById('totalDepartments').textContent = systemStats.totalDepartments || 0;
        document.getElementById('totalNotifications').textContent = systemStats.totalNotifications || 0;
    }
    
    // Render users list
    function renderUsers() {
        const container = document.getElementById('usersList');
        
        if (currentUsers.length === 0) {
            container.innerHTML = `
                <div class="text-center py-4">
                    <i class="bi bi-people fs-1 text-muted"></i>
                    <p class="mt-2 text-muted">No users found.</p>
                </div>
            `;
            return;
        }
        
        const usersHtml = currentUsers.map(user => `
            <div class="card mb-3 border-0 shadow-sm">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <div class="d-flex align-items-center mb-2">
                                <span class="badge ${getRoleBadgeClass(user.role)} me-2">
                                    ${user.role}
                                </span>
                                <span class="badge ${getStatusBadgeClass(user.status)} me-2">
                                    ${user.status}
                                </span>
                            </div>
                            <h6 class="card-title mb-1">${user.name}</h6>
                            <p class="text-muted mb-1">
                                <i class="bi bi-person"></i>
                                ${user.username}
                            </p>
                            <small class="text-muted">
                                <i class="bi bi-envelope"></i>
                                ${user.email}
                            </small>
                        </div>
                        <div class="col-md-4 text-md-end">
                            <button class="btn btn-outline-primary btn-sm me-2" onclick="editUser(${user.id})">
                                <i class="bi bi-pencil"></i>
                                Edit
                            </button>
                            <button class="btn btn-outline-danger btn-sm" onclick="deleteUser(${user.id})">
                                <i class="bi bi-trash"></i>
                                Delete
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        `).join('');
        
        container.innerHTML = usersHtml;
    }
    
    // Render system health
    function renderSystemHealth(health) {
        const container = document.getElementById('systemHealth');
        const status = health.status || 'UNKNOWN';
        const statusClass = status === 'UP' ? 'text-success' : 'text-danger';
        
        container.innerHTML = `
            <div class="text-center">
                <i class="bi bi-circle-fill ${statusClass} fs-1"></i>
                <h5 class="mt-2">System Status: ${status}</h5>
                <p class="text-muted">Last checked: ${new Date().toLocaleTimeString()}</p>
            </div>
        `;
    }
    
    // Render recent activity
    function renderRecentActivity(activities) {
        const container = document.getElementById('recentActivity');
        
        if (activities.length === 0) {
            container.innerHTML = `
                <div class="text-center py-3">
                    <i class="bi bi-activity fs-1 text-muted"></i>
                    <p class="mt-2 text-muted">No recent activity.</p>
                </div>
            `;
            return;
        }
        
        const activitiesHtml = activities.slice(0, 5).map(activity => `
            <div class="d-flex align-items-center p-2 border-bottom">
                <div class="flex-shrink-0 me-3">
                    <i class="bi bi-circle-fill text-primary"></i>
                </div>
                <div class="flex-grow-1">
                    <small class="text-muted">${activity.description}</small>
                    <br>
                    <small class="text-muted">${formatDate(activity.timestamp)}</small>
                </div>
            </div>
        `).join('');
        
        container.innerHTML = activitiesHtml;
    }
    
    // Show add user modal
    function showAddUserModal() {
        document.getElementById('addUserForm').reset();
        const modal = new bootstrap.Modal(document.getElementById('addUserModal'));
        modal.show();
    }
    
    // Add new user
    async function addUser() {
        const formData = new FormData(document.getElementById('addUserForm'));
        const userData = {
            username: formData.get('username'),
            name: formData.get('name'),
            email: formData.get('email'),
            password: formData.get('password'),
            role: formData.get('role')
        };
        
        try {
            const response = await fetch('/api/admin/users', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${getJwtToken()}`
                },
                body: JSON.stringify(userData)
            });
            
            if (response.ok) {
                showAlert('User added successfully!', 'success');
                document.getElementById('addUserForm').reset();
                bootstrap.Modal.getInstance(document.getElementById('addUserModal')).hide();
                loadUsers(); // Refresh the list
            } else {
                throw new Error('Failed to add user');
            }
        } catch (error) {
            console.error('Error adding user:', error);
            showAlert('Failed to add user. Please try again.', 'danger');
        }
    }
    
    // Edit user
    function editUser(userId) {
        const user = currentUsers.find(u => u.id === userId);
        if (!user) return;
        
        document.getElementById('editUserId').value = user.id;
        document.getElementById('editUsername').value = user.username;
        document.getElementById('editName').value = user.name;
        document.getElementById('editEmail').value = user.email;
        document.getElementById('editRole').value = user.role;
        document.getElementById('editStatus').value = user.status || 'ACTIVE';
        
        const modal = new bootstrap.Modal(document.getElementById('editUserModal'));
        modal.show();
    }
    
    // Update user
    async function updateUser() {
        const formData = new FormData(document.getElementById('editUserForm'));
        const userId = formData.get('id');
        const userData = {
            name: formData.get('name'),
            email: formData.get('email'),
            role: formData.get('role'),
            status: formData.get('status')
        };
        
        try {
            const response = await fetch(`/api/admin/users/${userId}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${getJwtToken()}`
                },
                body: JSON.stringify(userData)
            });
            
            if (response.ok) {
                showAlert('User updated successfully!', 'success');
                bootstrap.Modal.getInstance(document.getElementById('editUserModal')).hide();
                loadUsers(); // Refresh the list
            } else {
                throw new Error('Failed to update user');
            }
        } catch (error) {
            console.error('Error updating user:', error);
            showAlert('Failed to update user. Please try again.', 'danger');
        }
    }
    
    // Delete user
    async function deleteUser(userId) {
        if (!confirm('Are you sure you want to delete this user? This action cannot be undone.')) {
            return;
        }
        
        try {
            const response = await fetch(`/api/admin/users/${userId}`, {
                method: 'DELETE',
                headers: {
                    'Authorization': `Bearer ${getJwtToken()}`
                }
            });
            
            if (response.ok) {
                showAlert('User deleted successfully!', 'success');
                loadUsers(); // Refresh the list
            } else {
                throw new Error('Failed to delete user');
            }
        } catch (error) {
            console.error('Error deleting user:', error);
            showAlert('Failed to delete user. Please try again.', 'danger');
        }
    }
    
    // Utility functions
    function getJwtToken() {
        const cookies = document.cookie.split(';');
        for (let cookie of cookies) {
            const [name, value] = cookie.trim().split('=');
            if (name === 'jwt') {
                return value;
            }
        }
        return null;
    }
    
    function getRoleBadgeClass(role) {
        switch (role) {
            case 'ADMIN': return 'bg-danger';
            case 'STAFF': return 'bg-primary';
            case 'CITIZEN': return 'bg-success';
            default: return 'bg-secondary';
        }
    }
    
    function getStatusBadgeClass(status) {
        switch (status) {
            case 'ACTIVE': return 'bg-success';
            case 'INACTIVE': return 'bg-secondary';
            case 'SUSPENDED': return 'bg-warning';
            default: return 'bg-light';
        }
    }
    
    function formatDate(dateString) {
        const date = new Date(dateString);
        return date.toLocaleDateString() + ' ' + date.toLocaleTimeString();
    }
    
    function showAlert(message, type) {
        const alertDiv = document.createElement('div');
        alertDiv.className = `alert alert-${type} alert-dismissible fade show`;
        alertDiv.innerHTML = `
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        `;
        
        const container = document.querySelector('.container');
        container.insertBefore(alertDiv, container.firstChild);
        
        // Auto-dismiss after 5 seconds
        setTimeout(() => {
            if (alertDiv.parentNode) {
                alertDiv.remove();
            }
        }, 5000);
    }
    
    // Quick action functions
    function showUserManagement() {
        // Already visible in the main dashboard
        console.log('User management section is visible');
    }
    
    function showDepartmentManagement() {
        // Implementation for department management
        console.log('Showing department management...');
    }
    
    function showSystemReports() {
        // Implementation for system reports
        console.log('Showing system reports...');
    }
    
    function showSystemSettings() {
        // Implementation for system settings
        console.log('Showing system settings...');
    }
    
    function showSystemLogs() {
        // Implementation for system logs
        console.log('Showing system logs...');
    }
    
    function showBackupRestore() {
        // Implementation for backup/restore
        console.log('Showing backup/restore...');
    }
    
    function showSystemStatus() {
        // Implementation for system status
        console.log('Showing system status...');
    }
    
    function refreshUsers() {
        loadUsers();
    }
</script>