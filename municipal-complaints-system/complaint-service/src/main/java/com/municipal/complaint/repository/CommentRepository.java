package com.municipal.complaint.repository;

import com.municipal.complaint.entity.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {
    
    // Find all comments for a specific complaint
    List<Comment> findByComplaintIdOrderByTimestampAsc(Long complaintId);
    
    // Find comments by user
    List<Comment> findByUserIdOrderByTimestampDesc(Long userId);
    
    // Find comments by complaint and user
    List<Comment> findByComplaintIdAndUserIdOrderByTimestampDesc(Long complaintId, Long userId);
    
    // Find internal comments for a complaint
    List<Comment> findByComplaintIdAndIsInternalTrueOrderByTimestampAsc(Long complaintId);
    
    // Find public comments for a complaint
    List<Comment> findByComplaintIdAndIsInternalFalseOrderByTimestampAsc(Long complaintId);
    
    // Count comments for a complaint
    long countByComplaintId(Long complaintId);
    
    // Find recent comments across all complaints
    @Query("SELECT c FROM Comment c ORDER BY c.timestamp DESC")
    List<Comment> findRecentComments(@Param("limit") int limit);
    
    // Find comments by role
    List<Comment> findByUserRoleOrderByTimestampDesc(String userRole);
}