package com.example.imms.service;

import com.example.imms.entity.DrugCategory;
import com.example.imms.repository.DrugCategoryRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DrugCategoryService {

    private final DrugCategoryRepository repository;

    public DrugCategoryService(DrugCategoryRepository repository) {
        this.repository = repository;
    }

    public DrugCategory create(String name) {
        if (repository.existsByName(name)) {
            throw new RuntimeException("分类已存在");
        }
        DrugCategory category = new DrugCategory();
        category.setName(name);
        return repository.save(category);
    }

    public List<DrugCategory> listAll() {
        return repository.findAll();
    }

    public void deleteById(Long id) {
        repository.deleteById(id);
    }
}
