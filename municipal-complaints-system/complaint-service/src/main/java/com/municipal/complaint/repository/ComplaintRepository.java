package com.municipal.complaint.repository;

import com.municipal.complaint.entity.Complaint;
import com.municipal.complaint.entity.ComplaintCategory;
import com.municipal.complaint.entity.ComplaintStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface ComplaintRepository extends JpaRepository<Complaint, Long> {
    
    // Find complaints by user who created them
    List<Complaint> findByCreatedByOrderByCreatedDateDesc(Long createdBy);
    
    // Find complaints by status
    List<Complaint> findByStatusOrderByCreatedDateDesc(ComplaintStatus status);
    
    // Find complaints by category
    List<Complaint> findByCategoryOrderByCreatedDateDesc(ComplaintCategory category);
    
    // Find complaints by assigned department
    List<Complaint> findByAssignedDepartmentIdOrderByCreatedDateDesc(Long departmentId);
    
    // Find complaints by assigned staff member
    List<Complaint> findByAssignedToOrderByCreatedDateDesc(Long assignedTo);
    
    // Find complaints by priority
    List<Complaint> findByPriorityOrderByCreatedDateDesc(ComplaintPriority priority);
    
    // Find complaints created between dates
    List<Complaint> findByCreatedDateBetweenOrderByCreatedDateDesc(
            LocalDateTime startDate, LocalDateTime endDate);
    
    // Find complaints by multiple criteria with pagination
    @Query("SELECT c FROM Complaint c WHERE " +
            "(:status IS NULL OR c.status = :status) AND " +
            "(:category IS NULL OR c.category = :category) AND " +
            "(:priority IS NULL OR c.priority = :priority) AND " +
            "(:departmentId IS NULL OR c.assignedDepartmentId = :departmentId) AND " +
            "(:assignedTo IS NULL OR c.assignedTo = :assignedTo)")
    Page<Complaint> findByCriteria(
            @Param("status") ComplaintStatus status,
            @Param("category") ComplaintCategory category,
            @Param("priority") ComplaintPriority priority,
            @Param("departmentId") Long departmentId,
            @Param("assignedTo") Long assignedTo,
            Pageable pageable);
    
    // Find complaints by user with pagination
    Page<Complaint> findByCreatedBy(Long createdBy, Pageable pageable);
    
    // Count complaints by status
    long countByStatus(ComplaintStatus status);
    
    // Count complaints by category
    long countByCategory(ComplaintCategory category);
    
    // Count complaints by user
    long countByCreatedBy(Long createdBy);
    
    // Find complaints that need attention (pending or in progress)
    @Query("SELECT c FROM Complaint c WHERE c.status IN ('PENDING', 'IN_PROGRESS') ORDER BY c.priority DESC, c.createdDate ASC")
    List<Complaint> findComplaintsNeedingAttention();
    
    // Find complaints by status and priority
    List<Complaint> findByStatusAndPriorityOrderByCreatedDateDesc(ComplaintStatus status, ComplaintPriority priority);
}