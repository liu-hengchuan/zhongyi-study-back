package com.example.myspringboot.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.myspringboot.entity.User;
import com.example.myspringboot.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * 用户Controller
 */
@RestController
@RequestMapping("/api/users")
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 用户注册
     */
    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody User user) {
        // 检查用户名是否已存在
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", user.getUsername());
        User existingUser = userService.getOne(queryWrapper);
        if (existingUser != null) {
            return new ResponseEntity<>("用户名已存在", HttpStatus.BAD_REQUEST);
        }

        // 设置创建时间和更新时间
        String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        user.setCreateTime(now);
        user.setUpdateTime(now);

        // 保存用户信息
        boolean success = userService.save(user);
        if (success) {
            return new ResponseEntity<>("注册成功", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("注册失败", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * 用户登录
     */
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody User user) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", user.getUsername())
                    .eq("password", user.getPassword());
        User existingUser = userService.getOne(queryWrapper);
        if (existingUser != null) {
            return new ResponseEntity<>("登录成功", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("用户名或密码错误", HttpStatus.UNAUTHORIZED);
        }
    }

    /**
     * 获取用户信息
     */
    @GetMapping("/{id}")
    public ResponseEntity<?> getUserById(@PathVariable Integer id) {
        User user = userService.getById(id);
        if (user != null) {
            return new ResponseEntity<>(user, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("用户不存在", HttpStatus.NOT_FOUND);
        }
    }

    /**
     * 更新用户信息
     */
    @PutMapping
    public ResponseEntity<?> updateUser(@RequestBody User user) {
        // 设置更新时间
        String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        user.setUpdateTime(now);

        boolean success = userService.updateById(user);
        if (success) {
            return new ResponseEntity<>("更新成功", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("更新失败", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * 删除用户
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteUser(@PathVariable Integer id) {
        boolean success = userService.removeById(id);
        if (success) {
            return new ResponseEntity<>("删除成功", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("删除失败", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
