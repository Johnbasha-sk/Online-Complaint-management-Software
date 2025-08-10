package com.municipal.complaint.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public class CommentCreateDto {
    
    @NotNull(message = "Complaint ID is required")
    private Long complaintId;
    
    @NotBlank(message = "Comment text is required")
    @Size(min = 1, max = 1000, message = "Comment text must be between 1 and 1000 characters")
    private String commentText;
    
    private Boolean isInternal;
    
    // Default constructor
    public CommentCreateDto() {
        this.isInternal = false;
    }
    
    // Constructor with required fields
    public CommentCreateDto(Long complaintId, String commentText) {
        this();
        this.complaintId = complaintId;
        this.commentText = commentText;
    }
    
    // Getters and Setters
    public Long getComplaintId() {
        return complaintId;
    }
    
    public void setComplaintId(Long complaintId) {
        this.complaintId = complaintId;
    }
    
    public String getCommentText() {
        return commentText;
    }
    
    public void setCommentText(String commentText) {
        this.commentText = commentText;
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
        return "CommentCreateDto{" +
                "complaintId=" + complaintId +
                ", commentText='" + commentText + '\'' +
                ", isInternal=" + isInternal +
                '}';
    }
}