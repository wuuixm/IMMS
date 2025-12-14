package com.example.imms.repository;
import com.example.imms.entity.DrugCategory;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DrugCategoryRepository
        extends JpaRepository<DrugCategory, Long> {
    boolean existsByName(String name);
}