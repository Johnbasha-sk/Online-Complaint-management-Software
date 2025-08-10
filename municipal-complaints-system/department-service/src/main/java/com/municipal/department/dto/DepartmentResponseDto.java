package com.municipal.department.dto;

import com.municipal.department.Department;
import java.time.LocalDateTime;
import java.util.List;

public class DepartmentResponseDto {
    
    private Long id;
    private String name;
    private String description;
    private String contactInfo;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private Boolean isActive;
    private List<Long> staffIds;
    
    public DepartmentResponseDto() {
    }
    
    public DepartmentResponseDto(Department department) {
        this.id = department.getId();
        this.name = department.getName();
        this.description = department.getDescription();
        this.contactInfo = department.getContactInfo();
        this.createdAt = department.getCreatedAt();
        this.updatedAt = department.getUpdatedAt();
        this.isActive = department.getIsActive();
    }
    
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getContactInfo() {
        return contactInfo;
    }
    
    public void setContactInfo(String contactInfo) {
        this.contactInfo = contactInfo;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public Boolean getIsActive() {
        return isActive;
    }
    
    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }
    
    public List<Long> getStaffIds() {
        return staffIds;
    }
    
    public void setStaffIds(List<Long> staffIds) {
        this.staffIds = staffIds;
    }
    
    @Override
    public String toString() {
        return "DepartmentResponseDto{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", contactInfo='" + contactInfo + '\'' +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                ", isActive=" + isActive +
                ", staffIds=" + staffIds +
                '}';
    }
}