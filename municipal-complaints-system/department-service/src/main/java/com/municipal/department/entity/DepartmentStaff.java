package com.municipal.department;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "department_staff")
public class DepartmentStaff {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "department_id", nullable = false)
    private Long departmentId;
    
    @Column(name = "staff_id", nullable = false)
    private Long staffId;
    
    @Column(name = "assigned_at")
    private LocalDateTime assignedAt;
    
    @Column(name = "assigned_by")
    private Long assignedBy;
    
    @Column(name = "is_active")
    private Boolean isActive = true;
    
    public DepartmentStaff() {
    }
    
    public DepartmentStaff(Long departmentId, Long staffId, Long assignedBy) {
        this.departmentId = departmentId;
        this.staffId = staffId;
        this.assignedBy = assignedBy;
    }
    
    @PrePersist
    protected void onCreate() {
        assignedAt = LocalDateTime.now();
    }
    
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public Long getDepartmentId() {
        return departmentId;
    }
    
    public void setDepartmentId(Long departmentId) {
        this.departmentId = departmentId;
    }
    
    public Long getStaffId() {
        return staffId;
    }
    
    public void setStaffId(Long staffId) {
        this.staffId = staffId;
    }
    
    public LocalDateTime getAssignedAt() {
        return assignedAt;
    }
    
    public void setAssignedAt(LocalDateTime assignedAt) {
        this.assignedAt = assignedAt;
    }
    
    public Long getAssignedBy() {
        return assignedBy;
    }
    
    public void setAssignedBy(Long assignedBy) {
        this.assignedBy = assignedBy;
    }
    
    public Boolean getIsActive() {
        return isActive;
    }
    
    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }
    
    @Override
    public String toString() {
        return "DepartmentStaff{" +
                "id=" + id +
                ", departmentId=" + departmentId +
                ", staffId=" + staffId +
                ", assignedAt=" + assignedAt +
                ", assignedBy=" + assignedBy +
                ", isActive=" + isActive +
                '}';
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        DepartmentStaff that = (DepartmentStaff) o;
        return Objects.equals(id, that.id) &&
                Objects.equals(departmentId, that.departmentId) &&
                Objects.equals(staffId, that.staffId) &&
                Objects.equals(isActive, that.isActive);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(id, departmentId, staffId, isActive);
    }
}