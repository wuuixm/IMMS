package com.example.imms.controller;

import com.example.imms.entity.Drug;
import com.example.imms.service.DrugService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/drug")
public class DrugController {

    private final DrugService service;

    public DrugController(DrugService service) {
        this.service = service;
    }

    // 新增药品
    @PostMapping
    public Drug create(@RequestBody Drug drug) {
        return service.create(drug);
    }

    // 查询全部
    @GetMapping
    public List<Drug> list() {
        return service.listAll();
    }

    // 按分类查询
    @GetMapping("/category/{categoryId}")
    public List<Drug> listByCategory(@PathVariable Long categoryId) {
        return service.listByCategory(categoryId);
    }

    // 修改库存
    @PutMapping("/{id}/stock")
    public Drug updateStock(
            @PathVariable Long id,
            @RequestParam Integer stock
    ) {
        return service.updateStock(id, stock);
    }

    // 删除药品
    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        service.delete(id);
    }
}
