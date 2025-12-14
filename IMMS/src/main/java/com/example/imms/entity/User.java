package com.example.imms.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "sys_user")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 50)
    private String username;

    @Column(nullable = false, length = 100)
    private String password;

    @Column(nullable = true, length = 20)
    private String role;

    @Column(name = "create_time")
    private LocalDateTime createTime;

    private Integer age;

    @Column(length = 10)
    private String gender;
}
