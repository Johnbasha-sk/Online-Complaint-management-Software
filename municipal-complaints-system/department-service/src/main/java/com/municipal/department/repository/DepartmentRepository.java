package com.municipal.department.repository;

import com.municipal.department.Department;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface DepartmentRepository extends JpaRepository<Department, Long> {
    
    Optional<Department> findByName(String name);
    
    List<Department> findByIsActiveTrue();
    
    @Query("SELECT d FROM Department d WHERE d.isActive = true AND d.name LIKE %:searchTerm%")
    List<Department> findActiveByNameContaining(@Param("searchTerm") String searchTerm);
    
    boolean existsByName(String name);
    
    @Query("SELECT d FROM Department d WHERE d.isActive = true ORDER BY d.name")
    List<Department> findAllActiveOrderByName();
}