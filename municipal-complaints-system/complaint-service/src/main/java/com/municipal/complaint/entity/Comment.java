package com.municipal.complaint.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "comments")
public class Comment {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "complaint_id", nullable = false)
    private Long complaintId;
    
    @Column(name = "user_id", nullable = false)
    private Long userId;
    
    @Column(name = "user_role", nullable = false)
    private String userRole;
    
    @Column(name = "comment_text", nullable = false, length = 1000)
    private String commentText;
    
    @Column(name = "timestamp", nullable = false)
    private LocalDateTime timestamp;
    
    @Column(name = "is_internal")
    private Boolean isInternal;
    
    // Default constructor
    public Comment() {
        this.timestamp = LocalDateTime.now();
        this.isInternal = false;
    }
    
    // Constructor with required fields
    public Comment(Long complaintId, Long userId, String userRole, String commentText) {
        this();
        this.complaintId = complaintId;
        this.userId = userId;
        this.userRole = userRole;
        this.commentText = commentText;
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public Long getComplaintId() {
        return complaintId;
    }
    
    public void setComplaintId(Long complaintId) {
        this.complaintId = complaintId;
    }
    
    public Long getUserId() {
        return userId;
    }
    
    public void setUserId(Long userId) {
        this.userId = userId;
    }
    
    public String getUserRole() {
        return userRole;
    }
    
    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }
    
    public String getCommentText() {
        return commentText;
    }
    
    public void setCommentText(String commentText) {
        this.commentText = commentText;
    }
    
    public LocalDateTime getTimestamp() {
        return timestamp;
    }
    
    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }
    
    public Boolean getIsInternal() {
        return isInternal;
    }
    
    public void setIsInternal(Boolean isInternal) {
        this.isInternal = isInternal;
    }
    
    // toString method
    @Override
    public String toString() {
        return "Comment{" +
                "id=" + id +
                ", complaintId=" + complaintId +
                ", userId=" + userId +
                ", userRole='" + userRole + '\'' +
                ", commentText='" + commentText + '\'' +
                ", timestamp=" + timestamp +
                ", isInternal=" + isInternal +
                '}';
    }
    
    // equals and hashCode methods
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        
        Comment comment = (Comment) o;
        
        return id != null ? id.equals(comment.id) : comment.id == null;
    }
    
    @Override
    public int hashCode() {
        return id != null ? id.hashCode() : 0;
    }
}