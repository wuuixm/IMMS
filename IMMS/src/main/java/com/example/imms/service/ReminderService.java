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

    public Reminder update(Long id, Reminder payload) {
        Reminder existing = repo.findById(id)
                .orElseThrow(() -> new RuntimeException("用药提醒不存在"));
        existing.setUserId(payload.getUserId());
        existing.setDrugId(payload.getDrugId());
        existing.setRemindTime(payload.getRemindTime());
        existing.setStatus(payload.getStatus());
        return repo.save(existing);
    }

    public Reminder updateStatus(Long id, String status) {
        Reminder existing = repo.findById(id)
                .orElseThrow(() -> new RuntimeException("用药提醒不存在"));
        existing.setStatus(status);
        return repo.save(existing);
    }

    public void delete(Long id) {
        if (!repo.existsById(id)) {
            throw new RuntimeException("用药提醒不存在");
        }
        repo.deleteById(id);
    }

    public List<Reminder> listByUser(Long userId) {
        return repo.findByUserId(userId);
    }
}

