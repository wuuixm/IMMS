package com.example.imms.controller;

import com.example.imms.entity.HealthRecord;
import com.example.imms.service.HealthRecordService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/health")
public class HealthController {

    private final HealthRecordService service;

    public HealthController(HealthRecordService service) {
        this.service = service;
    }

    @PostMapping
    public HealthRecord add(@RequestBody HealthRecord record) {
        return service.save(record);
    }

    @GetMapping
    public List<HealthRecord> list(@RequestParam Long userId) {
        return service.listByUser(userId);
    }

    @PutMapping("/{id}")
    public HealthRecord update(@PathVariable Long id, @RequestBody HealthRecord record) {
        return service.update(id, record);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        service.delete(id);
    }
}
