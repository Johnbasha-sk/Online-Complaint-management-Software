package com.municipal.complaint.dto;

import com.municipal.complaint.entity.Comment;

import java.time.LocalDateTime;

public class CommentResponseDto {
    
    private Long id;
    private Long complaintId;
    private Long userId;
    private String userName;
    private String userRole;
    private String commentText;
    private LocalDateTime timestamp;
    private Boolean isInternal;
    
    // Default constructor
    public CommentResponseDto() {
    }
    
    // Constructor from Comment entity
    public CommentResponseDto(Comment comment) {
        this.id = comment.getId();
        this.complaintId = comment.getComplaintId();
        this.userId = comment.getUserId();
        this.userRole = comment.getUserRole();
        this.commentText = comment.getCommentText();
        this.timestamp = comment.getTimestamp();
        this.isInternal = comment.getIsInternal();
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
    
    public String getUserName() {
        return userName;
    }
    
    public void setUserName(String userName) {
        this.userName = userName;
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
        return "CommentResponseDto{" +
                "id=" + id +
                ", complaintId=" + complaintId +
                ", userId=" + userId +
                ", userName='" + userName + '\'' +
                ", userRole='" + userRole + '\'' +
                ", commentText='" + commentText + '\'' +
                ", timestamp=" + timestamp +
                ", isInternal=" + isInternal +
                '}';
    }
}