<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="header.jsp" />

<div class="container mt-4">
    <!-- Welcome Section -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card bg-primary text-white">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h2 class="card-title mb-2">
                                <i class="bi bi-house-heart"></i>
                                Welcome back, ${user.name}!
                            </h2>
                            <p class="card-text mb-0">
                                Track your complaints and stay updated on municipal issues in your area.
                            </p>
                        </div>
                        <div class="col-md-4 text-md-end">
                            <button class="btn btn-light btn-lg" data-bs-toggle="modal" data-bs-target="#newComplaintModal">
                                <i class="bi bi-plus-circle"></i>
                                File New Complaint
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-md-3 mb-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body text-center">
                    <div class="text-primary mb-2">
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
                    <div class="text-warning mb-2">
                        <i class="bi bi-clock fs-1"></i>
                    </div>
                    <h3 class="card-title" id="pendingComplaints">0</h3>
                    <p class="card-text text-muted">Pending</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body text-center">
                    <div class="text-info mb-2">
                        <i class="bi bi-gear fs-1"></i>
                    </div>
                    <h3 class="card-title" id="inProgressComplaints">0</h3>
                    <p class="card-text text-muted">In Progress</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body text-center">
                    <div class="text-success mb-2">
                        <i class="bi bi-check-circle fs-1"></i>
                    </div>
                    <h3 class="card-title" id="resolvedComplaints">0</h3>
                    <p class="card-text text-muted">Resolved</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Complaints Section -->
    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">
                            <i class="bi bi-clock-history"></i>
                            Recent Complaints
                        </h5>
                        <button class="btn btn-outline-primary btn-sm" onclick="refreshComplaints()">
                            <i class="bi bi-arrow-clockwise"></i>
                            Refresh
                        </button>
                    </div>
                </div>
                <div class="card-body">
                    <div id="complaintsList">
                        <div class="text-center py-4">
                            <div class="spinner-border text-primary" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                            <p class="mt-2 text-muted">Loading your complaints...</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="row mt-4">
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
                        <div class="col-md-4 mb-3">
                            <button class="btn btn-outline-primary w-100 h-100 py-3" onclick="showComplaintHistory()">
                                <i class="bi bi-clock-history fs-2 d-block mb-2"></i>
                                View History
                            </button>
                        </div>
                        <div class="col-md-4 mb-3">
                            <button class="btn btn-outline-info w-100 h-100 py-3" onclick="showNotifications()">
                                <i class="bi bi-bell fs-2 d-block mb-2"></i>
                                Notifications
                            </button>
                        </div>
                        <div class="col-md-4 mb-3">
                            <button class="btn btn-outline-success w-100 h-100 py-3" onclick="showProfile()">
                                <i class="bi bi-person fs-2 d-block mb-2"></i>
                                My Profile
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- New Complaint Modal -->
<div class="modal fade" id="newComplaintModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="bi bi-plus-circle"></i>
                    File New Complaint
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form id="complaintForm">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="category" class="form-label">Category *</label>
                            <select class="form-select" id="category" name="category" required>
                                <option value="">Select Category</option>
                                <option value="WATER">Water Issues</option>
                                <option value="SANITATION">Sanitation</option>
                                <option value="ROADS">Roads & Infrastructure</option>
                                <option value="ELECTRICITY">Electricity</option>
                                <option value="GARBAGE">Garbage Collection</option>
                                <option value="OTHER">Other</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="priority" class="form-label">Priority</label>
                            <select class="form-select" id="priority" name="priority">
                                <option value="LOW">Low</option>
                                <option value="MEDIUM" selected>Medium</option>
                                <option value="HIGH">High</option>
                                <option value="URGENT">Urgent</option>
                            </select>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="description" class="form-label">Description *</label>
                        <textarea class="form-control" id="description" name="description" rows="4" 
                                  placeholder="Please describe the issue in detail..." required></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="location" class="form-label">Location</label>
                        <input type="text" class="form-control" id="location" name="location" 
                               placeholder="Street address or landmark">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-send"></i>
                        Submit Complaint
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Complaint Details Modal -->
<div class="modal fade" id="complaintDetailsModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="bi bi-info-circle"></i>
                    Complaint Details
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body" id="complaintDetailsContent">
                <!-- Content will be loaded dynamically -->
            </div>
        </div>
    </div>
</div>

<!-- Add Comment Modal -->
<div class="modal fade" id="addCommentModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="bi bi-chat-dots"></i>
                    Add Comment
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form id="commentForm">
                <div class="modal-body">
                    <input type="hidden" id="commentComplaintId" name="complaintId">
                    <div class="mb-3">
                        <label for="commentText" class="form-label">Comment *</label>
                        <textarea class="form-control" id="commentText" name="commentText" rows="3" 
                                  placeholder="Add your comment..." required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-send"></i>
                        Add Comment
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />

<!-- Custom JavaScript for Citizen Dashboard -->
<script>
    // Global variables
    let currentComplaints = [];
    
    // Initialize dashboard
    document.addEventListener('DOMContentLoaded', function() {
        loadComplaints();
        setupEventListeners();
    });
    
    function setupEventListeners() {
        // Complaint form submission
        document.getElementById('complaintForm').addEventListener('submit', function(e) {
            e.preventDefault();
            submitComplaint();
        });
        
        // Comment form submission
        document.getElementById('commentForm').addEventListener('submit', function(e) {
            e.preventDefault();
            submitComment();
        });
    }
    
    // Load complaints from API
    async function loadComplaints() {
        try {
            const response = await fetch('/api/complaints/mine', {
                headers: {
                    'Authorization': `Bearer ${getJwtToken()}`
                }
            });
            
            if (response.ok) {
                const complaints = await response.json();
                currentComplaints = complaints;
                updateStatistics(complaints);
                renderComplaints(complaints);
            } else {
                throw new Error('Failed to load complaints');
            }
        } catch (error) {
            console.error('Error loading complaints:', error);
            showAlert('Failed to load complaints. Please try again.', 'danger');
        }
    }
    
    // Update statistics
    function updateStatistics(complaints) {
        const total = complaints.length;
        const pending = complaints.filter(c => c.status === 'PENDING').length;
        const inProgress = complaints.filter(c => c.status === 'IN_PROGRESS').length;
        const resolved = complaints.filter(c => c.status === 'RESOLVED').length;
        
        document.getElementById('totalComplaints').textContent = total;
        document.getElementById('pendingComplaints').textContent = pending;
        document.getElementById('inProgressComplaints').textContent = inProgress;
        document.getElementById('resolvedComplaints').textContent = resolved;
    }
    
    // Render complaints list
    function renderComplaints(complaints) {
        const container = document.getElementById('complaintsList');
        
        if (complaints.length === 0) {
            container.innerHTML = `
                <div class="text-center py-4">
                    <i class="bi bi-inbox fs-1 text-muted"></i>
                    <p class="mt-2 text-muted">No complaints found. File your first complaint to get started!</p>
                </div>
            `;
            return;
        }
        
        const complaintsHtml = complaints.map(complaint => `
            <div class="card mb-3 border-0 shadow-sm">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <div class="d-flex align-items-center mb-2">
                                <span class="badge ${getStatusBadgeClass(complaint.status)} me-2">
                                    ${complaint.status}
                                </span>
                                <span class="badge bg-secondary me-2">
                                    ${complaint.category}
                                </span>
                                <span class="badge ${getPriorityBadgeClass(complaint.priority)}">
                                    ${complaint.priority}
                                </span>
                            </div>
                            <h6 class="card-title mb-1">${complaint.description.substring(0, 100)}${complaint.description.length > 100 ? '...' : ''}</h6>
                            <p class="text-muted mb-1">
                                <i class="bi bi-geo-alt"></i>
                                ${complaint.location || 'Location not specified'}
                            </p>
                            <small class="text-muted">
                                <i class="bi bi-calendar"></i>
                                Filed on ${formatDate(complaint.createdDate)}
                            </small>
                        </div>
                        <div class="col-md-4 text-md-end">
                            <button class="btn btn-outline-primary btn-sm me-2" onclick="viewComplaintDetails(${complaint.id})">
                                <i class="bi bi-eye"></i>
                                View
                            </button>
                            <button class="btn btn-outline-info btn-sm" onclick="addComment(${complaint.id})">
                                <i class="bi bi-chat-dots"></i>
                                Comment
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        `).join('');
        
        container.innerHTML = complaintsHtml;
    }
    
    // Submit new complaint
    async function submitComplaint() {
        const formData = new FormData(document.getElementById('complaintForm'));
        const complaintData = {
            category: formData.get('category'),
            description: formData.get('description'),
            priority: formData.get('priority'),
            location: formData.get('location')
        };
        
        try {
            const response = await fetch('/api/complaints', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${getJwtToken()}`
                },
                body: JSON.stringify(complaintData)
            });
            
            if (response.ok) {
                showAlert('Complaint submitted successfully!', 'success');
                document.getElementById('complaintForm').reset();
                bootstrap.Modal.getInstance(document.getElementById('newComplaintModal')).hide();
                loadComplaints(); // Refresh the list
            } else {
                throw new Error('Failed to submit complaint');
            }
        } catch (error) {
            console.error('Error submitting complaint:', error);
            showAlert('Failed to submit complaint. Please try again.', 'danger');
        }
    }
    
    // View complaint details
    async function viewComplaintDetails(complaintId) {
        try {
            const response = await fetch(`/api/complaints/${complaintId}`, {
                headers: {
                    'Authorization': `Bearer ${getJwtToken()}`
                }
            });
            
            if (response.ok) {
                const complaint = await response.json();
                showComplaintDetails(complaint);
            } else {
                throw new Error('Failed to load complaint details');
            }
        } catch (error) {
            console.error('Error loading complaint details:', error);
            showAlert('Failed to load complaint details.', 'danger');
        }
    }
    
    // Show complaint details modal
    function showComplaintDetails(complaint) {
        const content = document.getElementById('complaintDetailsContent');
        content.innerHTML = `
            <div class="row">
                <div class="col-md-6">
                    <h6>Category</h6>
                    <p class="badge bg-secondary">${complaint.category}</p>
                    
                    <h6>Priority</h6>
                    <p class="badge ${getPriorityBadgeClass(complaint.priority)}">${complaint.priority}</p>
                    
                    <h6>Status</h6>
                    <p class="badge ${getStatusBadgeClass(complaint.status)}">${complaint.status}</p>
                    
                    <h6>Location</h6>
                    <p>${complaint.location || 'Not specified'}</p>
                    
                    <h6>Filed On</h6>
                    <p>${formatDate(complaint.createdDate)}</p>
                </div>
                <div class="col-md-6">
                    <h6>Description</h6>
                    <p>${complaint.description}</p>
                    
                    ${complaint.assignedDepartment ? `
                        <h6>Assigned Department</h6>
                        <p>${complaint.assignedDepartment}</p>
                    ` : ''}
                    
                    ${complaint.assignedTo ? `
                        <h6>Assigned To</h6>
                        <p>${complaint.assignedTo}</p>
                    ` : ''}
                </div>
            </div>
            
            ${complaint.comments && complaint.comments.length > 0 ? `
                <hr>
                <h6>Comments</h6>
                <div class="comments-section">
                    ${complaint.comments.map(comment => `
                        <div class="card mb-2">
                            <div class="card-body py-2">
                                <div class="d-flex justify-content-between">
                                    <small class="text-muted">${comment.userRole} - ${formatDate(comment.timestamp)}</small>
                                </div>
                                <p class="mb-0">${comment.commentText}</p>
                            </div>
                        </div>
                    `).join('')}
                </div>
            ` : ''}
        `;
        
        const modal = new bootstrap.Modal(document.getElementById('complaintDetailsModal'));
        modal.show();
    }
    
    // Add comment to complaint
    function addComment(complaintId) {
        document.getElementById('commentComplaintId').value = complaintId;
        const modal = new bootstrap.Modal(document.getElementById('addCommentModal'));
        modal.show();
    }
    
    // Submit comment
    async function submitComment() {
        const formData = new FormData(document.getElementById('commentForm'));
        const commentData = {
            commentText: formData.get('commentText')
        };
        const complaintId = formData.get('complaintId');
        
        try {
            const response = await fetch(`/api/complaints/${complaintId}/comments`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${getJwtToken()}`
                },
                body: JSON.stringify(commentData)
            });
            
            if (response.ok) {
                showAlert('Comment added successfully!', 'success');
                document.getElementById('commentForm').reset();
                bootstrap.Modal.getInstance(document.getElementById('addCommentModal')).hide();
                loadComplaints(); // Refresh to show new comment
            } else {
                throw new Error('Failed to add comment');
            }
        } catch (error) {
            console.error('Error adding comment:', error);
            showAlert('Failed to add comment. Please try again.', 'danger');
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
    
    function getStatusBadgeClass(status) {
        switch (status) {
            case 'PENDING': return 'bg-warning';
            case 'IN_PROGRESS': return 'bg-primary';
            case 'RESOLVED': return 'bg-success';
            case 'CLOSED': return 'bg-secondary';
            default: return 'bg-light';
        }
    }
    
    function getPriorityBadgeClass(priority) {
        switch (priority) {
            case 'LOW': return 'bg-success';
            case 'MEDIUM': return 'bg-info';
            case 'HIGH': return 'bg-warning';
            case 'URGENT': return 'bg-danger';
            default: return 'bg-secondary';
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
    
    function refreshComplaints() {
        loadComplaints();
    }
    
    function showComplaintHistory() {
        // Implementation for showing complaint history
        console.log('Showing complaint history...');
    }
    
    function showNotifications() {
        // Implementation for showing notifications
        console.log('Showing notifications...');
    }
    
    function showProfile() {
        // Implementation for showing profile
        console.log('Showing profile...');
    }
</script>