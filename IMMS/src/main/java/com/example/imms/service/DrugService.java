package com.example.imms.service;

import com.example.imms.entity.Drug;
import com.example.imms.repository.DrugRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DrugService {

    private final DrugRepository repository;

    public DrugService(DrugRepository repository) {
        this.repository = repository;
    }

    // 新增药品
    public Drug create(Drug drug) {
        return repository.save(drug);
    }

    // 查询所有药品
    public List<Drug> listAll() {
        return repository.findAll();
    }

    // 按分类查询
    public List<Drug> listByCategory(Long categoryId) {
        return repository.findByCategoryId(categoryId);
    }

    // 更新库存
    public Drug updateStock(Long id, Integer stock) {
        Drug drug = repository.findById(id)
                .orElseThrow(() -> new RuntimeException("药品不存在"));

        drug.setStock(stock);
        return repository.save(drug);
    }

    // 删除
    public void delete(Long id) {
        repository.deleteById(id);
    }
}
