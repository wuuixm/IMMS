package com.example.imms.controller;

import com.example.imms.entity.Reminder;
import com.example.imms.service.ReminderService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/reminder")
public class ReminderController {

    private final ReminderService service;

    public ReminderController(ReminderService service) {
        this.service = service;
    }

    @PostMapping
    public Reminder add(@RequestBody Reminder reminder) {
        return service.save(reminder);
    }

    @PutMapping("/{id}")
    public Reminder update(@PathVariable Long id, @RequestBody Reminder reminder) {
        return service.update(id, reminder);
    }

    @PutMapping("/{id}/status")
    public Reminder updateStatus(@PathVariable Long id, @RequestParam String status) {
        return service.updateStatus(id, status);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        service.delete(id);
    }

    @GetMapping
    public List<Reminder> list(@RequestParam Long userId) {
        return service.listByUser(userId);
    }
}

