package com.example.imms.service;

import com.example.imms.entity.HealthRecord;
import com.example.imms.repository.HealthRecordRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HealthRecordService {

    private final HealthRecordRepository repo;

    public HealthRecordService(HealthRecordRepository repo) {
        this.repo = repo;
    }

    public HealthRecord save(HealthRecord record) {
        return repo.save(record);
    }

    public List<HealthRecord> listByUser(Long userId) {
        return repo.findByUserId(userId);
    }

    public HealthRecord update(Long id, HealthRecord payload) {
        HealthRecord existing = repo.findById(id)
                .orElseThrow(() -> new RuntimeException("健康记录不存在"));

        existing.setType(payload.getType());
        existing.setValue(payload.getValue());
        existing.setRecordDate(payload.getRecordDate());
        existing.setUserId(payload.getUserId());
        return repo.save(existing);
    }

    public void delete(Long id) {
        if (!repo.existsById(id)) {
            throw new RuntimeException("健康记录不存在");
        }
        repo.deleteById(id);
    }
}
