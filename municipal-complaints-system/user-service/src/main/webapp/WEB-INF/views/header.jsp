<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Municipal Complaints System</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        .navbar-brand {
            font-weight: bold;
            color: #2c3e50 !important;
        }
        .nav-link {
            color: #34495e !important;
            font-weight: 500;
        }
        .nav-link:hover {
            color: #3498db !important;
        }
        .navbar {
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .user-menu {
            min-width: 200px;
        }
        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            font-size: 0.7rem;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-white">
        <div class="container">
            <!-- Brand -->
            <a class="navbar-brand" href="/">
                <i class="bi bi-building"></i>
                Municipal Complaints
            </a>
            
            <!-- Mobile Toggle -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <!-- Navigation Items -->
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <c:if test="${not empty user}">
                        <c:choose>
                            <c:when test="${user.role == 'CITIZEN'}">
                                <li class="nav-item">
                                    <a class="nav-link" href="/citizen/home">
                                        <i class="bi bi-house"></i> Dashboard
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#newComplaintModal">
                                        <i class="bi bi-plus-circle"></i> New Complaint
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#" onclick="loadMyComplaints()">
                                        <i class="bi bi-list-ul"></i> My Complaints
                                    </a>
                                </li>
                            </c:when>
                            <c:when test="${user.role == 'STAFF'}">
                                <li class="nav-item">
                                    <a class="nav-link" href="/staff/home">
                                        <i class="bi bi-house"></i> Dashboard
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#" onclick="loadAllComplaints()">
                                        <i class="bi bi-list-ul"></i> All Complaints
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#" onclick="loadDepartments()">
                                        <i class="bi bi-building"></i> Departments
                                    </a>
                                </li>
                            </c:when>
                            <c:when test="${user.role == 'ADMIN'}">
                                <li class="nav-item">
                                    <a class="nav-link" href="/admin/home">
                                        <i class="bi bi-house"></i> Dashboard
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#" onclick="loadAllComplaints()">
                                        <i class="bi bi-list-ul"></i> All Complaints
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#" onclick="loadUsers()">
                                        <i class="bi bi-people"></i> Users
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#" onclick="loadDepartments()">
                                        <i class="bi bi-building"></i> Departments
                                    </a>
                                </li>
                            </c:when>
                        </c:choose>
                    </c:if>
                </ul>
                
                <!-- User Menu -->
                <c:if test="${not empty user}">
                    <ul class="navbar-nav">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                                <i class="bi bi-person-circle"></i>
                                ${user.name}
                                <span class="badge bg-primary ms-1">${user.role}</span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end user-menu">
                                <li>
                                    <a class="dropdown-item" href="#" onclick="showProfile()">
                                        <i class="bi bi-person"></i> Profile
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="#" onclick="showNotifications()">
                                        <i class="bi bi-bell"></i> Notifications
                                        <span class="badge bg-danger notification-badge">3</span>
                                    </a>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item text-danger" href="/logout">
                                        <i class="bi bi-box-arrow-right"></i> Logout
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </c:if>
                
                <!-- Login/Register for non-authenticated users -->
                <c:if test="${empty user}">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="/login">
                                <i class="bi bi-box-arrow-in-right"></i> Login
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/register">
                                <i class="bi bi-person-plus"></i> Register
                            </a>
                        </li>
                    </ul>
                </c:if>
            </div>
        </div>
    </nav>
    
    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        function loadMyComplaints() {
            // Implementation for loading citizen's complaints
            console.log('Loading my complaints...');
        }
        
        function loadAllComplaints() {
            // Implementation for loading all complaints (staff/admin)
            console.log('Loading all complaints...');
        }
        
        function loadDepartments() {
            // Implementation for loading departments
            console.log('Loading departments...');
        }
        
        function loadUsers() {
            // Implementation for loading users (admin only)
            console.log('Loading users...');
        }
        
        function showProfile() {
            // Implementation for showing user profile
            console.log('Showing profile...');
        }
        
        function showNotifications() {
            // Implementation for showing notifications
            console.log('Showing notifications...');
        }
    </script>