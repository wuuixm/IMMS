package com.example.imms.entity;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "drug_category")
public class DrugCategory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 50)
    private String name;
}