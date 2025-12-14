package com.example.imms.service;

import com.example.imms.entity.Reminder;
import com.example.imms.repository.ReminderRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReminderService {

    private final ReminderRepository repo;

    public ReminderService(ReminderRepository repo) {
        this.repo = repo;
    }

    public Reminder save(Reminder reminder) {
        return repo.save(reminder);
    }

    public List<Reminder> listByUser(Long userId) {
        return repo.findByUserId(userId);
    }
}
