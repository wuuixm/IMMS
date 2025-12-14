package com.example.imms.service;

import com.example.imms.entity.User;
import com.example.imms.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class UserService {

    private final UserRepository repository;

    public UserService(UserRepository repository) {
        this.repository = repository;
    }

    // 注册
    public User register(String username, String password, Integer age, String gender) {
        if (repository.existsByUsername(username)) {
            throw new RuntimeException("用户名已存在");
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(password); // 作业阶段：不加密
        user.setAge(age);
        user.setGender(gender);
        user.setRole("USER");
        user.setCreateTime(LocalDateTime.now());

        return repository.save(user);
    }

    // 登录
    public User login(String username, String password) {
        User user = repository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("用户不存在"));

        if (!user.getPassword().equals(password)) {
            throw new RuntimeException("密码错误");
        }

        return user; // 简化：直接返回用户
    }

    // 查询所有用户
    public java.util.List<User> listAll() {
        return repository.findAll();
    }
}
