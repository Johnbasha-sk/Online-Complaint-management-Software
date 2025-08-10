package com.municipal.department.service;

import com.municipal.department.Department;
import com.municipal.department.DepartmentStaff;
import com.municipal.department.dto.DepartmentCreateDto;
import com.municipal.department.dto.DepartmentResponseDto;
import com.municipal.department.dto.StaffAssignmentDto;
import com.municipal.department.repository.DepartmentRepository;
import com.municipal.department.repository.DepartmentStaffRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class DepartmentService {
    
    private final DepartmentRepository departmentRepository;
    private final DepartmentStaffRepository departmentStaffRepository;
    
    @Autowired
    public DepartmentService(DepartmentRepository departmentRepository, 
                           DepartmentStaffRepository departmentStaffRepository) {
        this.departmentRepository = departmentRepository;
        this.departmentStaffRepository = departmentStaffRepository;
    }
    
    public DepartmentResponseDto createDepartment(DepartmentCreateDto createDto) {
        if (departmentRepository.existsByName(createDto.getName())) {
            throw new IllegalArgumentException("Department with name '" + createDto.getName() + "' already exists");
        }
        
        Department department = new Department(
            createDto.getName(),
            createDto.getDescription(),
            createDto.getContactInfo()
        );
        
        Department savedDepartment = departmentRepository.save(department);
        return new DepartmentResponseDto(savedDepartment);
    }
    
    public DepartmentResponseDto getDepartmentById(Long id) {
        Department department = departmentRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Department not found with id: " + id));
        
        DepartmentResponseDto responseDto = new DepartmentResponseDto(department);
        List<Long> staffIds = departmentStaffRepository.findStaffIdsByDepartmentId(id);
        responseDto.setStaffIds(staffIds);
        
        return responseDto;
    }
    
    public List<DepartmentResponseDto> getAllDepartments() {
        List<Department> departments = departmentRepository.findAllActiveOrderByName();
        return departments.stream()
            .map(department -> {
                DepartmentResponseDto responseDto = new DepartmentResponseDto(department);
                List<Long> staffIds = departmentStaffRepository.findStaffIdsByDepartmentId(department.getId());
                responseDto.setStaffIds(staffIds);
                return responseDto;
            })
            .collect(Collectors.toList());
    }
    
    public DepartmentResponseDto updateDepartment(Long id, DepartmentCreateDto updateDto) {
        Department department = departmentRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Department not found with id: " + id));
        
        // Check if name is being changed and if the new name already exists
        if (!department.getName().equals(updateDto.getName()) && 
            departmentRepository.existsByName(updateDto.getName())) {
            throw new IllegalArgumentException("Department with name '" + updateDto.getName() + "' already exists");
        }
        
        department.setName(updateDto.getName());
        department.setDescription(updateDto.getDescription());
        department.setContactInfo(updateDto.getContactInfo());
        
        Department updatedDepartment = departmentRepository.save(department);
        DepartmentResponseDto responseDto = new DepartmentResponseDto(updatedDepartment);
        List<Long> staffIds = departmentStaffRepository.findStaffIdsByDepartmentId(id);
        responseDto.setStaffIds(staffIds);
        
        return responseDto;
    }
    
    public void deleteDepartment(Long id) {
        Department department = departmentRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Department not found with id: " + id));
        
        // Soft delete - mark as inactive
        department.setIsActive(false);
        departmentRepository.save(department);
        
        // Also deactivate all staff assignments
        List<DepartmentStaff> staffAssignments = departmentStaffRepository.findByDepartmentIdAndIsActiveTrue(id);
        staffAssignments.forEach(assignment -> assignment.setIsActive(false));
        departmentStaffRepository.saveAll(staffAssignments);
    }
    
    public void assignStaffToDepartment(StaffAssignmentDto assignmentDto, Long assignedBy) {
        // Check if department exists
        if (!departmentRepository.existsById(assignmentDto.getDepartmentId())) {
            throw new IllegalArgumentException("Department not found with id: " + assignmentDto.getDepartmentId());
        }
        
        // Check if assignment already exists
        if (departmentStaffRepository.existsByDepartmentIdAndStaffIdAndIsActiveTrue(
                assignmentDto.getDepartmentId(), assignmentDto.getStaffId())) {
            throw new IllegalArgumentException("Staff is already assigned to this department");
        }
        
        DepartmentStaff assignment = new DepartmentStaff(
            assignmentDto.getDepartmentId(),
            assignmentDto.getStaffId(),
            assignedBy
        );
        
        departmentStaffRepository.save(assignment);
    }
    
    public void removeStaffFromDepartment(Long departmentId, Long staffId) {
        DepartmentStaff assignment = departmentStaffRepository
            .findByDepartmentIdAndStaffIdAndIsActiveTrue(departmentId, staffId)
            .orElseThrow(() -> new IllegalArgumentException("Staff assignment not found"));
        
        assignment.setIsActive(false);
        departmentStaffRepository.save(assignment);
    }
    
    public List<Long> getStaffIdsByDepartment(Long departmentId) {
        return departmentStaffRepository.findStaffIdsByDepartmentId(departmentId);
    }
    
    public List<Long> getDepartmentIdsByStaff(Long staffId) {
        return departmentStaffRepository.findDepartmentIdsByStaffId(staffId);
    }
    
    public Department getDepartmentByName(String name) {
        return departmentRepository.findByName(name)
            .orElseThrow(() -> new IllegalArgumentException("Department not found with name: " + name));
    }
    
    public boolean departmentExists(Long id) {
        return departmentRepository.existsById(id);
    }
    
    public boolean departmentExistsByName(String name) {
        return departmentRepository.existsByName(name);
    }
}