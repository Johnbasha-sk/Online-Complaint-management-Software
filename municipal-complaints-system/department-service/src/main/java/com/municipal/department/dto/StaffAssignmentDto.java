package com.municipal.department.dto;

import jakarta.validation.constraints.NotNull;

public class StaffAssignmentDto {
    
    @NotNull(message = "Staff ID is required")
    private Long staffId;
    
    @NotNull(message = "Department ID is required")
    private Long departmentId;
    
    public StaffAssignmentDto() {
    }
    
    public StaffAssignmentDto(Long staffId, Long departmentId) {
        this.staffId = staffId;
        this.departmentId = departmentId;
    }
    
    public Long getStaffId() {
        return staffId;
    }
    
    public void setStaffId(Long staffId) {
        this.staffId = staffId;
    }
    
    public Long getDepartmentId() {
        return departmentId;
    }
    
    public void setDepartmentId(Long departmentId) {
        this.departmentId = departmentId;
    }
    
    @Override
    public String toString() {
        return "StaffAssignmentDto{" +
                "staffId=" + staffId +
                ", departmentId=" + departmentId +
                '}';
    }
}