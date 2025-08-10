package com.municipal.department.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public class DepartmentCreateDto {
    
    @NotBlank(message = "Department name is required")
    @Size(min = 2, max = 100, message = "Department name must be between 2 and 100 characters")
    private String name;
    
    @Size(max = 500, message = "Description cannot exceed 500 characters")
    private String description;
    
    @Size(max = 200, message = "Contact info cannot exceed 200 characters")
    private String contactInfo;
    
    public DepartmentCreateDto() {
    }
    
    public DepartmentCreateDto(String name, String description, String contactInfo) {
        this.name = name;
        this.description = description;
        this.contactInfo = contactInfo;
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
    
    @Override
    public String toString() {
        return "DepartmentCreateDto{" +
                "name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", contactInfo='" + contactInfo + '\'' +
                '}';
    }
}