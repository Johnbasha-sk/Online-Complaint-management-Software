package com.municipal.complaint.dto;

import com.municipal.complaint.entity.ComplaintCategory;
import com.municipal.complaint.entity.ComplaintPriority;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public class ComplaintCreateDto {
    
    @NotNull(message = "Category is required")
    private ComplaintCategory category;
    
    @NotBlank(message = "Description is required")
    @Size(min = 10, max = 1000, message = "Description must be between 10 and 1000 characters")
    private String description;
    
    @Size(max = 200, message = "Location must not exceed 200 characters")
    private String location;
    
    @Size(max = 20, message = "Contact phone must not exceed 20 characters")
    private String contactPhone;
    
    private ComplaintPriority priority;
    
    // Default constructor
    public ComplaintCreateDto() {
    }
    
    // Constructor with required fields
    public ComplaintCreateDto(ComplaintCategory category, String description) {
        this.category = category;
        this.description = description;
    }
    
    // Getters and Setters
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
    
    public ComplaintPriority getPriority() {
        return priority;
    }
    
    public void setPriority(ComplaintPriority priority) {
        this.priority = priority;
    }
    
    // toString method
    @Override
    public String toString() {
        return "ComplaintCreateDto{" +
                "category=" + category +
                ", description='" + description + '\'' +
                ", location='" + location + '\'' +
                ", contactPhone='" + contactPhone + '\'' +
                ", priority=" + priority +
                '}';
    }
}