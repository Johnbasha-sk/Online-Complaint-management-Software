package com.municipal.department.controller;

import com.municipal.department.dto.DepartmentCreateDto;
import com.municipal.department.dto.DepartmentResponseDto;
import com.municipal.department.dto.StaffAssignmentDto;
import com.municipal.department.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api/departments")
public class DepartmentController {
    
    private final DepartmentService departmentService;
    
    @Autowired
    public DepartmentController(DepartmentService departmentService) {
        this.departmentService = departmentService;
    }
    
    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<DepartmentResponseDto> createDepartment(@Valid @RequestBody DepartmentCreateDto createDto) {
        DepartmentResponseDto department = departmentService.createDepartment(createDto);
        return ResponseEntity.status(HttpStatus.CREATED).body(department);
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<DepartmentResponseDto> getDepartmentById(@PathVariable Long id) {
        DepartmentResponseDto department = departmentService.getDepartmentById(id);
        return ResponseEntity.ok(department);
    }
    
    @GetMapping
    public ResponseEntity<List<DepartmentResponseDto>> getAllDepartments() {
        List<DepartmentResponseDto> departments = departmentService.getAllDepartments();
        return ResponseEntity.ok(departments);
    }
    
    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<DepartmentResponseDto> updateDepartment(
            @PathVariable Long id, 
            @Valid @RequestBody DepartmentCreateDto updateDto) {
        DepartmentResponseDto department = departmentService.updateDepartment(id, updateDto);
        return ResponseEntity.ok(department);
    }
    
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Void> deleteDepartment(@PathVariable Long id) {
        departmentService.deleteDepartment(id);
        return ResponseEntity.noContent().build();
    }
    
    @PostMapping("/{id}/assign-staff")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Void> assignStaffToDepartment(
            @PathVariable Long id,
            @Valid @RequestBody StaffAssignmentDto assignmentDto,
            @RequestHeader("X-User-ID") Long assignedBy) {
        
        // Ensure the department ID in path matches the one in the request body
        if (!id.equals(assignmentDto.getDepartmentId())) {
            return ResponseEntity.badRequest().build();
        }
        
        departmentService.assignStaffToDepartment(assignmentDto, assignedBy);
        return ResponseEntity.ok().build();
    }
    
    @DeleteMapping("/{departmentId}/staff/{staffId}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Void> removeStaffFromDepartment(
            @PathVariable Long departmentId,
            @PathVariable Long staffId) {
        departmentService.removeStaffFromDepartment(departmentId, staffId);
        return ResponseEntity.ok().build();
    }
    
    @GetMapping("/{id}/staff")
    public ResponseEntity<List<Long>> getStaffByDepartment(@PathVariable Long id) {
        List<Long> staffIds = departmentService.getStaffIdsByDepartment(id);
        return ResponseEntity.ok(staffIds);
    }
    
    @GetMapping("/staff/{staffId}")
    public ResponseEntity<List<Long>> getDepartmentsByStaff(@PathVariable Long staffId) {
        List<Long> departmentIds = departmentService.getDepartmentIdsByStaff(staffId);
        return ResponseEntity.ok(departmentIds);
    }
}