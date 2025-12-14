package com.example.imms.service;

import com.example.imms.entity.FamilyMember;
import com.example.imms.repository.FamilyMemberRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FamilyMemberService {

    private final FamilyMemberRepository repo;

    public FamilyMemberService(FamilyMemberRepository repo) {
        this.repo = repo;
    }

    public FamilyMember save(FamilyMember member) {
        return repo.save(member);
    }

    public List<FamilyMember> listByUser(Long userId) {
        return repo.findByUserId(userId);
    }

    public FamilyMember update(Long id, FamilyMember payload) {
        FamilyMember existing = repo.findById(id)
                .orElseThrow(() -> new RuntimeException("家庭成员不存在"));

        existing.setMemberUserId(payload.getMemberUserId());
        existing.setUserId(payload.getUserId());
        return repo.save(existing);
    }

    public void delete(Long id) {
        if (!repo.existsById(id)) {
            throw new RuntimeException("家庭成员不存在");
        }
        repo.deleteById(id);
    }
}
