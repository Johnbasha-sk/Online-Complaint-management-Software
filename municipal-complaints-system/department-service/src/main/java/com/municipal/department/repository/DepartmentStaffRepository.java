package com.municipal.department.repository;

import com.municipal.department.DepartmentStaff;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface DepartmentStaffRepository extends JpaRepository<DepartmentStaff, Long> {
    
    List<DepartmentStaff> findByDepartmentIdAndIsActiveTrue(Long departmentId);
    
    List<DepartmentStaff> findByStaffIdAndIsActiveTrue(Long staffId);
    
    Optional<DepartmentStaff> findByDepartmentIdAndStaffIdAndIsActiveTrue(Long departmentId, Long staffId);
    
    @Query("SELECT ds.staffId FROM DepartmentStaff ds WHERE ds.departmentId = :departmentId AND ds.isActive = true")
    List<Long> findStaffIdsByDepartmentId(@Param("departmentId") Long departmentId);
    
    @Query("SELECT ds.departmentId FROM DepartmentStaff ds WHERE ds.staffId = :staffId AND ds.isActive = true")
    List<Long> findDepartmentIdsByStaffId(@Param("staffId") Long staffId);
    
    boolean existsByDepartmentIdAndStaffIdAndIsActiveTrue(Long departmentId, Long staffId);
}