package com.example.imms.entity;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "drug")
public class Drug {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String name;

    @Column(name = "category_id")
    private Long categoryId;

    @Column(columnDefinition = "TEXT")
    private String description;

    private Integer stock;
}