<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="header.jsp" />

<div class="container mt-4">
    <!-- Welcome Section -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card bg-info text-white">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h2 class="card-title mb-2">
                                <i class="bi bi-person-badge"></i>
                                Staff Dashboard - ${user.name}
                            </h2>
                            <p class="card-text mb-0">
                                Manage complaints, track progress, and coordinate with departments to resolve municipal issues.
                            </p>
                        </div>
                        <div class="col-md-4 text-md-end">
                            <button class="btn btn-light btn-lg" onclick="showQuickActions()">
                                <i class="bi bi-lightning"></i>
                                Quick Actions
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

    <!-- Department Assignment Info -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white">
                    <h5 class="mb-0">
                        <i class="bi bi-building"></i>
                        My Department Assignments
                    </h5>
                </div>
                <div class="card-body">
                    <div id="departmentAssignments">
                        <div class="text-center py-3">
                            <div class="spinner-border text-primary" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                            <p class="mt-2 text-muted">Loading department assignments...</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Complaints Management Section -->
    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">
                            <i class="bi bi-clipboard-data"></i>
                            Complaints Management
                        </h5>
                        <div class="d-flex gap-2">
                            <select class="form-select form-select-sm" id="statusFilter" onchange="filterComplaints()">
                                <option value="">All Status</option>
                                <option value="PENDING">Pending</option>
                                <option value="IN_PROGRESS">In Progress</option>
                                <option value="RESOLVED">Resolved</option>
                                <option value="CLOSED">Closed</option>
                            </select>
                            <select class="form-select form-select-sm" id="categoryFilter" onchange="filterComplaints()">
                                <option value="">All Categories</option>
                                <option value="WATER">Water</option>
                                <option value="SANITATION">Sanitation</option>
                                <option value="ROADS">Roads</option>
                                <option value="ELECTRICITY">Electricity</option>
                                <option value="GARBAGE">Garbage</option>
                                <option value="OTHER">Other</option>
                            </select>
                            <button class="btn btn-outline-primary btn-sm" onclick="refreshComplaints()">
                                <i class="bi bi-arrow-clockwise"></i>
                                Refresh
                            </button>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div id="complaintsList">
                        <div class="text-center py-4">
                            <div class="spinner-border text-primary" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                            <p class="mt-2 text-muted">Loading complaints...</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Actions Section -->
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
                        <div class="col-md-3 mb-3">
                            <button class="btn btn-outline-primary w-100 h-100 py-3" onclick="showAssignComplaint()">
                                <i class="bi bi-person-plus fs-2 d-block mb-2"></i>
                                Assign Complaint
                            </button>
                        </div>
                        <div class="col-md-3 mb-3">
                            <button class="btn btn-outline-info w-100 h-100 py-3" onclick="showUpdateStatus()">
                                <i class="bi bi-arrow-up-circle fs-2 d-block mb-2"></i>
                                Update Status
                            </button>
                        </div>
                        <div class="col-md-3 mb-3">
                            <button class="btn btn-outline-success w-100 h-100 py-3" onclick="showDepartmentReport()">
                                <i class="bi bi-file-earmark-text fs-2 d-block mb-2"></i>
                                Department Report
                            </button>
                        </div>
                        <div class="col-md-3 mb-3">
                            <button class="btn btn-outline-warning w-100 h-100 py-3" onclick="showNotifications()">
                                <i class="bi bi-bell fs-2 d-block mb-2"></i>
                                Notifications
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Assign Complaint Modal -->
<div class="modal fade" id="assignComplaintModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="bi bi-person-plus"></i>
                    Assign Complaint
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form id="assignComplaintForm">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="complaintSelect" class="form-label">Select Complaint *</label>
                        <select class="form-select" id="complaintSelect" name="complaintId" required>
                            <option value="">Choose a complaint...</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="departmentSelect" class="form-label">Assign to Department *</label>
                        <select class="form-select" id="departmentSelect" name="departmentId" required>
                            <option value="">Choose department...</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="staffSelect" class="form-label">Assign to Staff (Optional)</label>
                        <select class="form-select" id="staffSelect" name="staffId">
                            <option value="">Choose staff member...</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="assignmentNotes" class="form-label">Assignment Notes</label>
                        <textarea class="form-control" id="assignmentNotes" name="notes" rows="3" 
                                  placeholder="Add any notes about this assignment..."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-send"></i>
                        Assign Complaint
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Update Status Modal -->
<div class="modal fade" id="updateStatusModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="bi bi-arrow-up-circle"></i>
                    Update Complaint Status
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form id="updateStatusForm">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="statusComplaintSelect" class="form-label">Select Complaint *</label>
                        <select class="form-select" id="statusComplaintSelect" name="complaintId" required>
                            <option value="">Choose a complaint...</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="newStatus" class="form-label">New Status *</label>
                        <select class="form-select" id="newStatus" name="status" required>
                            <option value="">Choose status...</option>
                            <option value="PENDING">Pending</option>
                            <option value="IN_PROGRESS">In Progress</option>
                            <option value="RESOLVED">Resolved</option>
                            <option value="CLOSED">Closed</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="statusNotes" class="form-label">Status Update Notes</label>
                        <textarea class="form-control" id="statusNotes" name="notes" rows="3" 
                                  placeholder="Add notes about this status update..."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-check-circle"></i>
                        Update Status
                    </button>
                </div>
            </form>
        </div>
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

<!-- Custom JavaScript for Staff Dashboard -->
<script>
    // Global variables
    let currentComplaints = [];
    let currentDepartments = [];
    let currentStaff = [];
    
    // Initialize dashboard
    document.addEventListener('DOMContentLoaded', function() {
        loadDashboardData();
        setupEventListeners();
    });
    
    function setupEventListeners() {
        // Form submissions
        document.getElementById('assignComplaintForm').addEventListener('submit', function(e) {
            e.preventDefault();
            assignComplaint();
        });
        
        document.getElementById('updateStatusForm').addEventListener('submit', function(e) {
            e.preventDefault();
            updateComplaintStatus();
        });
        
        document.getElementById('commentForm').addEventListener('submit', function(e) {
            e.preventDefault();
            submitComment();
        });
    }
    
    // Load all dashboard data
    async function loadDashboardData() {
        await Promise.all([
            loadComplaints(),
            loadDepartmentAssignments(),
            loadDepartments(),
            loadStaff()
        ]);
    }
    
    // Load complaints from API
    async function loadComplaints() {
        try {
            const response = await fetch('/api/complaints', {
                headers: {
                    'Authorization': `Bearer ${getJwtToken()}`
                }
            });
            
            if (response.ok) {
                const complaints = await response.json();
                currentComplaints = complaints;
                updateStatistics(complaints);
                renderComplaints(complaints);
                populateComplaintSelects();
            } else {
                throw new Error('Failed to load complaints');
            }
        } catch (error) {
            console.error('Error loading complaints:', error);
            showAlert('Failed to load complaints. Please try again.', 'danger');
        }
    }
    
    // Load department assignments
    async function loadDepartmentAssignments() {
        try {
            const response = await fetch('/api/departments/staff/${user.id}', {
                headers: {
                    'Authorization': `Bearer ${getJwtToken()}`
                }
            });
            
            if (response.ok) {
                const assignments = await response.json();
                renderDepartmentAssignments(assignments);
            } else {
                throw new Error('Failed to load department assignments');
            }
        } catch (error) {
            console.error('Error loading department assignments:', error);
            showAlert('Failed to load department assignments.', 'danger');
        }
    }
    
    // Load departments
    async function loadDepartments() {
        try {
            const response = await fetch('/api/departments', {
                headers: {
                    'Authorization': `Bearer ${getJwtToken()}`
                }
            });
            
            if (response.ok) {
                currentDepartments = await response.json();
                populateDepartmentSelect();
            } else {
                throw new Error('Failed to load departments');
            }
        } catch (error) {
            console.error('Error loading departments:', error);
            showAlert('Failed to load departments.', 'danger');
        }
    }
    
    // Load staff members
    async function loadStaff() {
        try {
            const response = await fetch('/api/users/staff', {
                headers: {
                    'Authorization': `Bearer ${getJwtToken()}`
                }
            });
            
            if (response.ok) {
                currentStaff = await response.json();
                populateStaffSelect();
            } else {
                throw new Error('Failed to load staff');
            }
        } catch (error) {
            console.error('Error loading staff:', error);
            showAlert('Failed to load staff members.', 'danger');
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
    
    // Render department assignments
    function renderDepartmentAssignments(assignments) {
        const container = document.getElementById('departmentAssignments');
        
        if (assignments.length === 0) {
            container.innerHTML = `
                <div class="text-center py-3">
                    <i class="bi bi-building-x fs-1 text-muted"></i>
                    <p class="mt-2 text-muted">No department assignments found.</p>
                </div>
            `;
            return;
        }
        
        const assignmentsHtml = assignments.map(assignment => `
            <div class="d-flex align-items-center p-3 border rounded mb-2">
                <div class="flex-grow-1">
                    <h6 class="mb-1">${assignment.departmentName}</h6>
                    <small class="text-muted">Assigned since ${formatDate(assignment.assignedAt)}</small>
                </div>
                <span class="badge bg-primary">${assignment.departmentDescription || 'No description'}</span>
            </div>
        `).join('');
        
        container.innerHTML = assignmentsHtml;
    }
    
    // Render complaints list
    function renderComplaints(complaints) {
        const container = document.getElementById('complaintsList');
        
        if (complaints.length === 0) {
            container.innerHTML = `
                <div class="text-center py-4">
                    <i class="bi bi-inbox fs-1 text-muted"></i>
                    <p class="mt-2 text-muted">No complaints found.</p>
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
                                <i class="bi bi-person"></i>
                                Filed by: ${complaint.createdBy || 'Unknown'}
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
                            <button class="btn btn-outline-info btn-sm me-2" onclick="addComment(${complaint.id})">
                                <i class="bi bi-chat-dots"></i>
                                Comment
                            </button>
                            <button class="btn btn-outline-warning btn-sm" onclick="showQuickActions(${complaint.id})">
                                <i class="bi bi-gear"></i>
                                Actions
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        `).join('');
        
        container.innerHTML = complaintsHtml;
    }
    
    // Populate select dropdowns
    function populateComplaintSelects() {
        const complaintSelect = document.getElementById('complaintSelect');
        const statusComplaintSelect = document.getElementById('statusComplaintSelect');
        
        const options = currentComplaints.map(complaint => 
            `<option value="${complaint.id}">#${complaint.id} - ${complaint.category} - ${complaint.description.substring(0, 50)}...</option>`
        ).join('');
        
        complaintSelect.innerHTML = '<option value="">Choose a complaint...</option>' + options;
        statusComplaintSelect.innerHTML = '<option value="">Choose a complaint...</option>' + options;
    }
    
    function populateDepartmentSelect() {
        const departmentSelect = document.getElementById('departmentSelect');
        
        const options = currentDepartments.map(dept => 
            `<option value="${dept.id}">${dept.name}</option>`
        ).join('');
        
        departmentSelect.innerHTML = '<option value="">Choose department...</option>' + options;
    }
    
    function populateStaffSelect() {
        const staffSelect = document.getElementById('staffSelect');
        
        const options = currentStaff.map(staff => 
            `<option value="${staff.id}">${staff.name} (${staff.username})</option>`
        ).join('');
        
        staffSelect.innerHTML = '<option value="">Choose staff member...</option>' + options;
    }
    
    // Filter complaints
    function filterComplaints() {
        const statusFilter = document.getElementById('statusFilter').value;
        const categoryFilter = document.getElementById('categoryFilter').value;
        
        let filteredComplaints = currentComplaints;
        
        if (statusFilter) {
            filteredComplaints = filteredComplaints.filter(c => c.status === statusFilter);
        }
        
        if (categoryFilter) {
            filteredComplaints = filteredComplaints.filter(c => c.category === categoryFilter);
        }
        
        renderComplaints(filteredComplaints);
    }
    
    // Show quick actions
    function showQuickActions() {
        // Implementation for showing quick actions
        console.log('Showing quick actions...');
    }
    
    // Show assign complaint modal
    function showAssignComplaint() {
        const modal = new bootstrap.Modal(document.getElementById('assignComplaintModal'));
        modal.show();
    }
    
    // Show update status modal
    function showUpdateStatus() {
        const modal = new bootstrap.Modal(document.getElementById('updateStatusModal'));
        modal.show();
    }
    
    // Assign complaint
    async function assignComplaint() {
        const formData = new FormData(document.getElementById('assignComplaintForm'));
        const assignmentData = {
            complaintId: formData.get('complaintId'),
            departmentId: formData.get('departmentId'),
            staffId: formData.get('staffId') || null,
            notes: formData.get('notes')
        };
        
        try {
            const response = await fetch(`/api/complaints/${assignmentData.complaintId}/assign`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${getJwtToken()}`
                },
                body: JSON.stringify(assignmentData)
            });
            
            if (response.ok) {
                showAlert('Complaint assigned successfully!', 'success');
                document.getElementById('assignComplaintForm').reset();
                bootstrap.Modal.getInstance(document.getElementById('assignComplaintModal')).hide();
                loadComplaints(); // Refresh the list
            } else {
                throw new Error('Failed to assign complaint');
            }
        } catch (error) {
            console.error('Error assigning complaint:', error);
            showAlert('Failed to assign complaint. Please try again.', 'danger');
        }
    }
    
    // Update complaint status
    async function updateComplaintStatus() {
        const formData = new FormData(document.getElementById('updateStatusForm'));
        const statusData = {
            status: formData.get('status'),
            notes: formData.get('notes')
        };
        const complaintId = formData.get('complaintId');
        
        try {
            const response = await fetch(`/api/complaints/${complaintId}/status`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${getJwtToken()}`
                },
                body: JSON.stringify(statusData)
            });
            
            if (response.ok) {
                showAlert('Complaint status updated successfully!', 'success');
                document.getElementById('updateStatusForm').reset();
                bootstrap.Modal.getInstance(document.getElementById('updateStatusModal')).hide();
                loadComplaints(); // Refresh the list
            } else {
                throw new Error('Failed to update complaint status');
            }
        } catch (error) {
            console.error('Error updating complaint status:', error);
            showAlert('Failed to update complaint status. Please try again.', 'danger');
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
                    
                    <h6>Filed By</h6>
                    <p>${complaint.createdBy || 'Unknown'}</p>
                    
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
    
    function showDepartmentReport() {
        // Implementation for showing department report
        console.log('Showing department report...');
    }
    
    function showNotifications() {
        // Implementation for showing notifications
        console.log('Showing notifications...');
    }
</script>