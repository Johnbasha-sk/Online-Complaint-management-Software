package com.municipal.complaint.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "complaints")
public class Complaint {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ComplaintCategory category;
    
    @Column(nullable = false, length = 1000)
    private String description;
    
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ComplaintStatus status;
    
    @Column(name = "assigned_department_id")
    private Long assignedDepartmentId;
    
    @Column(name = "created_by", nullable = false)
    private Long createdBy;
    
    @Column(name = "created_date", nullable = false)
    private LocalDateTime createdDate;
    
    @Column(name = "updated_date")
    private LocalDateTime updatedDate;
    
    @Column(name = "priority")
    @Enumerated(EnumType.STRING)
    private ComplaintPriority priority;
    
    @Column(name = "location")
    private String location;
    
    @Column(name = "contact_phone")
    private String contactPhone;
    
    @Column(name = "assigned_to")
    private Long assignedTo;
    
    // Default constructor
    public Complaint() {
        this.createdDate = LocalDateTime.now();
        this.status = ComplaintStatus.PENDING;
        this.priority = ComplaintPriority.MEDIUM;
    }
    
    // Constructor with required fields
    public Complaint(ComplaintCategory category, String description, Long createdBy) {
        this();
        this.category = category;
        this.description = description;
        this.createdBy = createdBy;
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
    
    public Long getCreatedBy() {
        return createdBy;
    }
    
    public void setCreatedBy(Long createdBy) {
        this.createdBy = createdBy;
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
    
    // Lifecycle methods
    @PreUpdate
    public void preUpdate() {
        this.updatedDate = LocalDateTime.now();
    }
    
    // toString method
    @Override
    public String toString() {
        return "Complaint{" +
                "id=" + id +
                ", category=" + category +
                ", description='" + description + '\'' +
                ", status=" + status +
                ", assignedDepartmentId=" + assignedDepartmentId +
                ", createdBy=" + createdBy +
                ", createdDate=" + createdDate +
                ", updatedDate=" + updatedDate +
                ", priority=" + priority +
                ", location='" + location + '\'' +
                ", contactPhone='" + contactPhone + '\'' +
                ", assignedTo=" + assignedTo +
                '}';
    }
    
    // equals and hashCode methods
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        
        Complaint complaint = (Complaint) o;
        
        return id != null ? id.equals(complaint.id) : complaint.id == null;
    }
    
    @Override
    public int hashCode() {
        return id != null ? id.hashCode() : 0;
    }
}