package com.example.imms.repository;

import com.example.imms.entity.Drug;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DrugRepository extends JpaRepository<Drug, Long> {

    // 按分类查询药品
    List<Drug> findByCategoryId(Long categoryId);

    // 按名称模糊查询（可选，用于搜索）
    List<Drug> findByNameContaining(String name);
}
