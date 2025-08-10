package com.municipal.complaint.service;

import com.municipal.complaint.dto.ComplaintCreateDto;
import com.municipal.complaint.dto.ComplaintResponseDto;
import com.municipal.complaint.dto.CommentCreateDto;
import com.municipal.complaint.dto.CommentResponseDto;
import com.municipal.complaint.entity.Complaint;
import com.municipal.complaint.entity.Comment;
import com.municipal.complaint.entity.ComplaintStatus;
import com.municipal.complaint.entity.ComplaintPriority;
import com.municipal.complaint.entity.ComplaintCategory;
import com.municipal.complaint.repository.ComplaintRepository;
import com.municipal.complaint.repository.CommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.client.loadbalancer.LoadBalanced;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ComplaintService {
    
    @Autowired
    private ComplaintRepository complaintRepository;
    
    @Autowired
    private CommentRepository commentRepository;
    
    @Autowired
    @LoadBalanced
    private RestTemplate restTemplate;
    
    // Create a new complaint
    public ComplaintResponseDto createComplaint(ComplaintCreateDto complaintDto, Long userId, String userRole) {
        Complaint complaint = new Complaint();
        complaint.setCategory(complaintDto.getCategory());
        complaint.setDescription(complaintDto.getDescription());
        complaint.setLocation(complaintDto.getLocation());
        complaint.setContactPhone(complaintDto.getContactPhone());
        complaint.setPriority(complaintDto.getPriority() != null ? complaintDto.getPriority() : ComplaintPriority.MEDIUM);
        complaint.setCreatedBy(userId);
        complaint.setStatus(ComplaintStatus.PENDING);
        
        Complaint savedComplaint = complaintRepository.save(complaint);
        
        // Trigger notification for new complaint
        triggerNotification(savedComplaint, "COMPLAINT_CREATED");
        
        return new ComplaintResponseDto(savedComplaint);
    }
    
    // Get complaint by ID with comments
    public ComplaintResponseDto getComplaintById(Long id) {
        Complaint complaint = complaintRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Complaint not found"));
        
        ComplaintResponseDto responseDto = new ComplaintResponseDto(complaint);
        
        // Load comments
        List<Comment> comments = commentRepository.findByComplaintIdOrderByTimestampAsc(id);
        List<CommentResponseDto> commentDtos = comments.stream()
                .map(CommentResponseDto::new)
                .collect(Collectors.toList());
        
        responseDto.setComments(commentDtos);
        
        // Enrich with user and department names
        enrichComplaintData(responseDto);
        
        return responseDto;
    }
    
    // Get complaints by user
    public List<ComplaintResponseDto> getComplaintsByUser(Long userId) {
        List<Complaint> complaints = complaintRepository.findByCreatedByOrderByCreatedDateDesc(userId);
        return complaints.stream()
                .map(ComplaintResponseDto::new)
                .peek(this::enrichComplaintData)
                .collect(Collectors.toList());
    }
    
    // Get all complaints with filtering and pagination
    public Page<ComplaintResponseDto> getAllComplaints(ComplaintStatus status, 
                                                      String category, 
                                                      String priority, 
                                                      Long departmentId, 
                                                      Long assignedTo, 
                                                      Pageable pageable) {
        
        ComplaintCategory categoryEnum = category != null ? ComplaintCategory.valueOf(category.toUpperCase()) : null;
        ComplaintPriority priorityEnum = priority != null ? ComplaintPriority.valueOf(priority.toUpperCase()) : null;
        
        Page<Complaint> complaints = complaintRepository.findByCriteria(
                status, categoryEnum, priorityEnum, departmentId, assignedTo, pageable);
        
        return complaints.map(complaint -> {
            ComplaintResponseDto dto = new ComplaintResponseDto(complaint);
            enrichComplaintData(dto);
            return dto;
        });
    }
    
    // Update complaint status
    public ComplaintResponseDto updateComplaintStatus(Long id, ComplaintStatus status, Long userId, String userRole) {
        Complaint complaint = complaintRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Complaint not found"));
        
        // Check if user has permission to update status
        if (!hasPermissionToUpdateStatus(userRole, complaint)) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Insufficient permissions to update complaint status");
        }
        
        ComplaintStatus oldStatus = complaint.getStatus();
        complaint.setStatus(status);
        complaint.setUpdatedDate(LocalDateTime.now());
        
        Complaint savedComplaint = complaintRepository.save(complaint);
        
        // Trigger notification for status change
        if (!oldStatus.equals(status)) {
            triggerNotification(savedComplaint, "STATUS_CHANGED");
        }
        
        return new ComplaintResponseDto(savedComplaint);
    }
    
    // Assign complaint to department
    public ComplaintResponseDto assignToDepartment(Long id, Long departmentId, Long userId, String userRole) {
        Complaint complaint = complaintRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Complaint not found"));
        
        // Check if user has permission to assign
        if (!hasPermissionToAssign(userRole)) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Insufficient permissions to assign complaint");
        }
        
        complaint.setAssignedDepartmentId(departmentId);
        complaint.setUpdatedDate(LocalDateTime.now());
        
        Complaint savedComplaint = complaintRepository.save(complaint);
        
        // Trigger notification for department assignment
        triggerNotification(savedComplaint, "DEPARTMENT_ASSIGNED");
        
        return new ComplaintResponseDto(savedComplaint);
    }
    
    // Add comment to complaint
    public CommentResponseDto addComment(Long complaintId, CommentCreateDto commentDto, Long userId, String userRole) {
        Complaint complaint = complaintRepository.findById(complaintId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Complaint not found"));
        
        // Check if user has permission to comment
        if (!hasPermissionToComment(userRole, complaint, userId)) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Insufficient permissions to add comment");
        }
        
        Comment comment = new Comment();
        comment.setComplaintId(complaintId);
        comment.setUserId(userId);
        comment.setUserRole(userRole);
        comment.setCommentText(commentDto.getCommentText());
        comment.setIsInternal(commentDto.getIsInternal());
        
        Comment savedComment = commentRepository.save(comment);
        
        // Trigger notification for new comment
        triggerNotification(complaint, "COMMENT_ADDED");
        
        return new CommentResponseDto(savedComment);
    }
    
    // Get complaint statistics
    public ComplaintStatistics getComplaintStatistics() {
        ComplaintStatistics stats = new ComplaintStatistics();
        stats.setTotalComplaints(complaintRepository.count());
        stats.setPendingComplaints(complaintRepository.countByStatus(ComplaintStatus.PENDING));
        stats.setInProgressComplaints(complaintRepository.countByStatus(ComplaintStatus.IN_PROGRESS));
        stats.setResolvedComplaints(complaintRepository.countByStatus(ComplaintStatus.RESOLVED));
        stats.setClosedComplaints(complaintRepository.countByStatus(ComplaintStatus.CLOSED));
        
        return stats;
    }
    
    // Delete complaint (admin only)
    public void deleteComplaint(Long id, String userRole) {
        if (!"ROLE_ADMIN".equals(userRole)) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Only administrators can delete complaints");
        }
        
        Complaint complaint = complaintRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Complaint not found"));
        
        // Delete associated comments first
        commentRepository.deleteByComplaintId(id);
        
        // Delete complaint
        complaintRepository.delete(complaint);
    }
    
    // Helper methods
    private boolean hasPermissionToUpdateStatus(String userRole, Complaint complaint) {
        return "ROLE_ADMIN".equals(userRole) || 
               "ROLE_STAFF".equals(userRole) || 
               ("ROLE_CITIZEN".equals(userRole) && complaint.getCreatedBy().equals(complaint.getCreatedBy()));
    }
    
    private boolean hasPermissionToAssign(String userRole) {
        return "ROLE_ADMIN".equals(userRole) || "ROLE_STAFF".equals(userRole);
    }
    
    private boolean hasPermissionToComment(String userRole, Complaint complaint, Long userId) {
        return "ROLE_ADMIN".equals(userRole) || 
               "ROLE_STAFF".equals(userRole) || 
               ("ROLE_CITIZEN".equals(userRole) && complaint.getCreatedBy().equals(userId));
    }
    
    private void enrichComplaintData(ComplaintResponseDto dto) {
        // This would typically call other services to get user and department names
        // For now, we'll set placeholder values
        dto.setCreatedByName("User " + dto.getCreatedBy());
        if (dto.getAssignedDepartmentId() != null) {
            dto.setAssignedDepartmentName("Department " + dto.getAssignedDepartmentId());
        }
        if (dto.getAssignedTo() != null) {
            dto.setAssignedToName("Staff " + dto.getAssignedTo());
        }
    }
    
    private void triggerNotification(Complaint complaint, String eventType) {
        try {
            // Call notification service via Eureka
            String notificationUrl = "http://notification-service/api/notifications/send";
            NotificationRequest request = new NotificationRequest();
            request.setUserId(complaint.getCreatedBy());
            request.setEventType(eventType);
            request.setComplaintId(complaint.getId());
            request.setMessage("Complaint " + complaint.getId() + " " + eventType.toLowerCase());
            
            restTemplate.postForEntity(notificationUrl, request, String.class);
        } catch (Exception e) {
            // Log error but don't fail the operation
            System.err.println("Failed to trigger notification: " + e.getMessage());
        }
    }
    
    // Inner classes for notifications and statistics
    public static class NotificationRequest {
        private Long userId;
        private String eventType;
        private Long complaintId;
        private String message;
        
        // Getters and setters
        public Long getUserId() { return userId; }
        public void setUserId(Long userId) { this.userId = userId; }
        
        public String getEventType() { return eventType; }
        public void setEventType(String eventType) { this.eventType = eventType; }
        
        public Long getComplaintId() { return complaintId; }
        public void setComplaintId(Long complaintId) { this.complaintId = complaintId; }
        
        public String getMessage() { return message; }
        public void setMessage(String message) { this.message = message; }
    }
    
    public static class ComplaintStatistics {
        private long totalComplaints;
        private long pendingComplaints;
        private long inProgressComplaints;
        private long resolvedComplaints;
        private long closedComplaints;
        
        // Getters and setters
        public long getTotalComplaints() { return totalComplaints; }
        public void setTotalComplaints(long totalComplaints) { this.totalComplaints = totalComplaints; }
        
        public long getPendingComplaints() { return pendingComplaints; }
        public void setPendingComplaints(long pendingComplaints) { this.pendingComplaints = pendingComplaints; }
        
        public long getInProgressComplaints() { return inProgressComplaints; }
        public void setInProgressComplaints(long inProgressComplaints) { this.inProgressComplaints = inProgressComplaints; }
        
        public long getResolvedComplaints() { return resolvedComplaints; }
        public void setResolvedComplaints(long resolvedComplaints) { this.resolvedComplaints = resolvedComplaints; }
        
        public long getClosedComplaints() { return closedComplaints; }
        public void setClosedComplaints(long closedComplaints) { this.closedComplaints = closedComplaints; }
    }
}