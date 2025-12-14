package com.example.imms.entity;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "reminder")
public class Reminder {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "drug_id", nullable = false)
    private Long drugId;

    @Column(name = "remind_time", nullable = false)
    private LocalDateTime remindTime;

    @Column(nullable = false, length = 20)
    private String status;
}