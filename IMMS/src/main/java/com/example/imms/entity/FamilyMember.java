package com.example.imms.entity;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "family_member")
public class FamilyMember {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(nullable = false, length = 50)
    private String name;

    private Integer age;

    @Column(length = 10)
    private String gender;
}