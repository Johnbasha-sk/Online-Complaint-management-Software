package com.municipal.complaint.dto;

import com.municipal.complaint.entity.Complaint;
import com.municipal.complaint.entity.ComplaintCategory;
import com.municipal.complaint.entity.ComplaintPriority;
import com.municipal.complaint.entity.ComplaintStatus;

import java.time.LocalDateTime;
import java.util.List;

public class ComplaintResponseDto {
    
    private Long id;
    private ComplaintCategory category;
    private String description;
    private ComplaintStatus status;
    private Long assignedDepartmentId;
    private String assignedDepartmentName;
    private Long createdBy;
    private String createdByName;
    private LocalDateTime createdDate;
    private LocalDateTime updatedDate;
    private ComplaintPriority priority;
    private String location;
    private String contactPhone;
    private Long assignedTo;
    private String assignedToName;
    private List<CommentResponseDto> comments;
    
    // Default constructor
    public ComplaintResponseDto() {
    }
    
    // Constructor from Complaint entity
    public ComplaintResponseDto(Complaint complaint) {
        this.id = complaint.getId();
        this.category = complaint.getCategory();
        this.description = complaint.getDescription();
        this.status = complaint.getStatus();
        this.assignedDepartmentId = complaint.getAssignedDepartmentId();
        this.createdBy = complaint.getCreatedBy();
        this.createdDate = complaint.getCreatedDate();
        this.updatedDate = complaint.getUpdatedDate();
        this.priority = complaint.getPriority();
        this.location = complaint.getLocation();
        this.contactPhone = complaint.getContactPhone();
        this.assignedTo = complaint.getAssignedTo();
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public ComplaintCategory getCategory() {
        return category;
    }
    
    public void setCategory(ComplaintCategory category) {
        this.category = category;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public ComplaintStatus getStatus() {
        return status;
    }
    
    public void setStatus(ComplaintStatus status) {
        this.status = status;
    }
    
    public Long getAssignedDepartmentId() {
        return assignedDepartmentId;
    }
    
    public void setAssignedDepartmentId(Long assignedDepartmentId) {
        this.assignedDepartmentId = assignedDepartmentId;
    }
    
    public String getAssignedDepartmentName() {
        return assignedDepartmentName;
    }
    
    public void setAssignedDepartmentName(String assignedDepartmentName) {
        this.assignedDepartmentName = assignedDepartmentName;
    }
    
    public Long getCreatedBy() {
        return createdBy;
    }
    
    public void setCreatedBy(Long createdBy) {
        this.createdBy = createdBy;
    }
    
    public String getCreatedByName() {
        return createdByName;
    }
    
    public void setCreatedByName(String createdByName) {
        this.createdByName = createdByName;
    }
    
    public LocalDateTime getCreatedDate() {
        return createdDate;
    }
    
    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }
    
    public LocalDateTime getUpdatedDate() {
        return updatedDate;
    }
    
    public void setUpdatedDate(LocalDateTime updatedDate) {
        this.updatedDate = updatedDate;
    }
    
    public ComplaintPriority getPriority() {
        return priority;
    }
    
    public void setPriority(ComplaintPriority priority) {
        this.priority = priority;
    }
    
    public String getLocation() {
        return location;
    }
    
    public void setLocation(String location) {
        this.location = location;
    }
    
    public String getContactPhone() {
        return contactPhone;
    }
    
    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }
    
    public Long getAssignedTo() {
        return assignedTo;
    }
    
    public void setAssignedTo(Long assignedTo) {
        this.assignedTo = assignedTo;
    }
    
    public String getAssignedToName() {
        return assignedToName;
    }
    
    public void setAssignedToName(String assignedToName) {
        this.assignedToName = assignedToName;
    }
    
    public List<CommentResponseDto> getComments() {
        return comments;
    }
    
    public void setComments(List<CommentResponseDto> comments) {
        this.comments = comments;
    }
    
    // toString method
    @Override
    public String toString() {
        return "ComplaintResponseDto{" +
                "id=" + id +
                ", category=" + category +
                ", description='" + description + '\'' +
                ", status=" + status +
                ", assignedDepartmentId=" + assignedDepartmentId +
                ", assignedDepartmentName='" + assignedDepartmentName + '\'' +
                ", createdBy=" + createdBy +
                ", createdByName='" + createdByName + '\'' +
                ", createdDate=" + createdDate +
                ", updatedDate=" + updatedDate +
                ", priority=" + priority +
                ", location='" + location + '\'' +
                ", contactPhone='" + contactPhone + '\'' +
                ", assignedTo=" + assignedTo +
                ", assignedToName='" + assignedToName + '\'' +
                ", comments=" + comments +
                '}';
    }
}