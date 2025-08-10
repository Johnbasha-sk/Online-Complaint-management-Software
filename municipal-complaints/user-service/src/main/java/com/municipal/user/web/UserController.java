package com.municipal.user.web;

import com.municipal.user.dto.UserResponse;
import com.municipal.user.entity.User;
import com.municipal.user.repo.UserRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/users")
public class UserController {

    private final UserRepository userRepository;

    public UserController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @GetMapping("/me")
    public ResponseEntity<UserResponse> me(Authentication auth) {
        if (auth == null || auth.getName() == null) {
            return ResponseEntity.status(401).build();
        }
        return userRepository.findByUsername(auth.getName())
                .map(u -> ResponseEntity.ok(new UserResponse(u.getId(), u.getUsername(), u.getName(), u.getEmail(), u.getRole())))
                .orElse(ResponseEntity.status(404).build());
    }
}