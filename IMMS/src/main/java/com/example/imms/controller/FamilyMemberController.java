package com.example.imms.controller;

import com.example.imms.entity.FamilyMember;
import com.example.imms.service.FamilyMemberService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/family")
public class FamilyMemberController {

    private final FamilyMemberService service;

    public FamilyMemberController(FamilyMemberService service) {
        this.service = service;
    }

    @PostMapping
    public FamilyMember add(@RequestBody FamilyMember member) {
        return service.save(member);
    }

    @GetMapping
    public List<FamilyMember> list(@RequestParam Long userId) {
        return service.listByUser(userId);
    }

    @PutMapping("/{id}")
    public FamilyMember update(@PathVariable Long id, @RequestBody FamilyMember member) {
        return service.update(id, member);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        service.delete(id);
    }
}
