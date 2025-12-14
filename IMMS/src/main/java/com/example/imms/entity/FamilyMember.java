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

    // 家庭拥有者（创建者）
    @Column(name = "user_id", nullable = false)
    private Long userId;

    // 被关联的真实系统用户ID
    @Column(name = "member_user_id")
    private Long memberUserId;

}