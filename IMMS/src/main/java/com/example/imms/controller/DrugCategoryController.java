package com.example.imms.controller;

import com.example.imms.entity.DrugCategory;
import com.example.imms.service.DrugCategoryService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/category")
public class DrugCategoryController {

    private final DrugCategoryService service;

    public DrugCategoryController(DrugCategoryService service) {
        this.service = service;
    }

    // 新增分类
    @PostMapping
    public DrugCategory create(@RequestParam String name) {
        return service.create(name);
    }

    // 查询所有分类
    @GetMapping
    public List<DrugCategory> list() {
        return service.listAll();
    }

    // 删除分类
    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        service.deleteById(id);
    }
}
