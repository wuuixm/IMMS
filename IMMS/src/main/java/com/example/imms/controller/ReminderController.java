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

    @GetMapping
    public List<Reminder> list(@RequestParam Long userId) {
        return service.listByUser(userId);
    }
}
