package com.municipal.complaint.controller;

import com.municipal.complaint.dto.ComplaintCreateDto;
import com.municipal.complaint.dto.ComplaintResponseDto;
import com.municipal.complaint.dto.CommentCreateDto;
import com.municipal.complaint.dto.CommentResponseDto;
import com.municipal.complaint.entity.ComplaintStatus;
import com.municipal.complaint.service.ComplaintService;
import com.municipal.complaint.util.JwtUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/complaints")
@CrossOrigin(origins = "*")
public class ComplaintController {
    
    @Autowired
    private ComplaintService complaintService;
    
    @Autowired
    private JwtUtil jwtUtil;
    
    // Create new complaint (CITIZEN)
    @PostMapping
    @PreAuthorize("hasRole('CITIZEN')")
    public ResponseEntity<ComplaintResponseDto> createComplaint(
            @Valid @RequestBody ComplaintCreateDto complaintDto,
            HttpServletRequest request) {
        
        Long userId = extractUserIdFromRequest(request);
        ComplaintResponseDto createdComplaint = complaintService.createComplaint(complaintDto, userId, "ROLE_CITIZEN");
        return ResponseEntity.status(HttpStatus.CREATED).body(createdComplaint);
    }
    
    // Get complaint by ID
    @GetMapping("/{id}")
    public ResponseEntity<ComplaintResponseDto> getComplaint(@PathVariable Long id) {
        ComplaintResponseDto complaint = complaintService.getComplaintById(id);
        return ResponseEntity.ok(complaint);
    }
    
    // Get complaints by current user (CITIZEN)
    @GetMapping("/mine")
    @PreAuthorize("hasRole('CITIZEN')")
    public ResponseEntity<List<ComplaintResponseDto>> getMyComplaints(HttpServletRequest request) {
        Long userId = extractUserIdFromRequest(request);
        List<ComplaintResponseDto> complaints = complaintService.getComplaintsByUser(userId);
        return ResponseEntity.ok(complaints);
    }
    
    // Get all complaints with filtering (STAFF/ADMIN)
    @GetMapping
    @PreAuthorize("hasAnyRole('STAFF', 'ADMIN')")
    public ResponseEntity<Page<ComplaintResponseDto>> getAllComplaints(
            @RequestParam(required = false) ComplaintStatus status,
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String priority,
            @RequestParam(required = false) Long departmentId,
            @RequestParam(required = false) Long assignedTo,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        
        Pageable pageable = PageRequest.of(page, size);
        Page<ComplaintResponseDto> complaints = complaintService.getAllComplaints(
                status, category, priority, departmentId, assignedTo, pageable);
        
        return ResponseEntity.ok(complaints);
    }
    
    // Update complaint status (STAFF/ADMIN)
    @PutMapping("/{id}/status")
    @PreAuthorize("hasAnyRole('STAFF', 'ADMIN')")
    public ResponseEntity<ComplaintResponseDto> updateStatus(
            @PathVariable Long id,
            @RequestParam ComplaintStatus status,
            HttpServletRequest request) {
        
        Long userId = extractUserIdFromRequest(request);
        String userRole = extractUserRoleFromRequest(request);
        
        ComplaintResponseDto updatedComplaint = complaintService.updateComplaintStatus(id, status, userId, userRole);
        return ResponseEntity.ok(updatedComplaint);
    }
    
    // Assign complaint to department (STAFF/ADMIN)
    @PutMapping("/{id}/assign")
    @PreAuthorize("hasAnyRole('STAFF', 'ADMIN')")
    public ResponseEntity<ComplaintResponseDto> assignToDepartment(
            @PathVariable Long id,
            @RequestParam Long departmentId,
            HttpServletRequest request) {
        
        Long userId = extractUserIdFromRequest(request);
        String userRole = extractUserRoleFromRequest(request);
        
        ComplaintResponseDto updatedComplaint = complaintService.assignToDepartment(id, departmentId, userId, userRole);
        return ResponseEntity.ok(updatedComplaint);
    }
    
    // Add comment to complaint
    @PostMapping("/{id}/comments")
    public ResponseEntity<CommentResponseDto> addComment(
            @PathVariable Long id,
            @Valid @RequestBody CommentCreateDto commentDto,
            HttpServletRequest request) {
        
        Long userId = extractUserIdFromRequest(request);
        String userRole = extractUserRoleFromRequest(request);
        
        CommentResponseDto comment = complaintService.addComment(id, commentDto, userId, userRole);
        return ResponseEntity.status(HttpStatus.CREATED).body(comment);
    }
    
    // Get complaint statistics (STAFF/ADMIN)
    @GetMapping("/statistics")
    @PreAuthorize("hasAnyRole('STAFF', 'ADMIN')")
    public ResponseEntity<ComplaintService.ComplaintStatistics> getStatistics() {
        ComplaintService.ComplaintStatistics stats = complaintService.getComplaintStatistics();
        return ResponseEntity.ok(stats);
    }
    
    // Delete complaint (ADMIN only)
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Void> deleteComplaint(@PathVariable Long id, HttpServletRequest request) {
        String userRole = extractUserRoleFromRequest(request);
        complaintService.deleteComplaint(id, userRole);
        return ResponseEntity.noContent().build();
    }
    
    // Helper methods to extract user information from request headers
    private Long extractUserIdFromRequest(HttpServletRequest request) {
        String userIdHeader = request.getHeader("X-User-ID");
        if (userIdHeader != null) {
            try {
                return Long.parseLong(userIdHeader);
            } catch (NumberFormatException e) {
                throw new RuntimeException("Invalid user ID in header");
            }
        }
        throw new RuntimeException("User ID header not found");
    }
    
    private String extractUserRoleFromRequest(HttpServletRequest request) {
        String rolesHeader = request.getHeader("X-User-Roles");
        if (rolesHeader != null && !rolesHeader.isEmpty()) {
            // Extract the first role (remove ROLE_ prefix if present)
            String role = rolesHeader.split(",")[0].trim();
            if (role.startsWith("ROLE_")) {
                return role;
            } else {
                return "ROLE_" + role;
            }
        }
        throw new RuntimeException("User roles header not found");
    }
}