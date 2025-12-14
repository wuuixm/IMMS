package com.example.imms.controller;

import com.example.imms.entity.User;
import com.example.imms.service.UserService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/user")
public class UserController {

    private final UserService service;

    public UserController(UserService service) {
        this.service = service;
    }

    // 注册
    @PostMapping("/register")
    public User register(
            @RequestParam String username,
            @RequestParam String password
    ) {
        return service.register(username, password);
    }

    // 登录
    @PostMapping("/login")
    public User login(
            @RequestParam String username,
            @RequestParam String password
    ) {
        return service.login(username, password);
    }
}
