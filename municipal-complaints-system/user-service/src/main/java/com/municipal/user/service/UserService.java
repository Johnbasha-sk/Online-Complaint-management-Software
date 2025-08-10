package com.municipal.user.service;

import com.municipal.user.dto.UserRegistrationDto;
import com.municipal.user.dto.UserResponseDto;
import com.municipal.user.entity.User;
import com.municipal.user.entity.UserRole;
import com.municipal.user.repository.UserRepository;
import com.municipal.user.util.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtil jwtUtil;

    @Autowired
    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder, JwtUtil jwtUtil) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtUtil = jwtUtil;
    }

    public UserResponseDto registerUser(UserRegistrationDto registrationDto) {
        // Validate password confirmation
        if (!registrationDto.getPassword().equals(registrationDto.getConfirmPassword())) {
            throw new IllegalArgumentException("Password and confirm password do not match");
        }

        // Check if username already exists
        if (userRepository.existsByUsername(registrationDto.getUsername())) {
            throw new IllegalArgumentException("Username already exists");
        }

        // Check if email already exists
        if (userRepository.existsByEmail(registrationDto.getEmail())) {
            throw new IllegalArgumentException("Email already exists");
        }

        // Create new user with default role as CITIZEN
        User user = new User();
        user.setUsername(registrationDto.getUsername());
        user.setName(registrationDto.getName());
        user.setEmail(registrationDto.getEmail());
        user.setPassword(passwordEncoder.encode(registrationDto.getPassword()));
        user.setRole(UserRole.ROLE_CITIZEN);

        User savedUser = userRepository.save(user);
        return new UserResponseDto(savedUser);
    }

    public String loginUser(String username, String password) {
        Optional<User> userOpt = userRepository.findByUsername(username);
        
        if (userOpt.isEmpty()) {
            throw new IllegalArgumentException("Invalid username or password");
        }

        User user = userOpt.get();
        
        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new IllegalArgumentException("Invalid username or password");
        }

        return jwtUtil.generateToken(user);
    }

    public UserResponseDto getUserById(Long id) {
        Optional<User> userOpt = userRepository.findById(id);
        if (userOpt.isEmpty()) {
            throw new IllegalArgumentException("User not found with id: " + id);
        }
        return new UserResponseDto(userOpt.get());
    }

    public UserResponseDto getUserByUsername(String username) {
        Optional<User> userOpt = userRepository.findByUsername(username);
        if (userOpt.isEmpty()) {
            throw new IllegalArgumentException("User not found with username: " + username);
        }
        return new UserResponseDto(userOpt.get());
    }

    public List<UserResponseDto> getAllUsers() {
        return userRepository.findAll().stream()
                .map(UserResponseDto::new)
                .collect(Collectors.toList());
    }

    public UserResponseDto updateUserRole(Long userId, UserRole newRole) {
        Optional<User> userOpt = userRepository.findById(userId);
        if (userOpt.isEmpty()) {
            throw new IllegalArgumentException("User not found with id: " + userId);
        }

        User user = userOpt.get();
        user.setRole(newRole);
        User updatedUser = userRepository.save(user);
        return new UserResponseDto(updatedUser);
    }

    public void deleteUser(Long userId) {
        if (!userRepository.existsById(userId)) {
            throw new IllegalArgumentException("User not found with id: " + userId);
        }
        userRepository.deleteById(userId);
    }

    public boolean validateToken(String token) {
        return jwtUtil.validateToken(token);
    }

    public UserResponseDto getUserFromToken(String token) {
        if (!jwtUtil.validateToken(token)) {
            throw new IllegalArgumentException("Invalid token");
        }

        Long userId = jwtUtil.extractUserId(token);
        return getUserById(userId);
    }

    public void createAdminUserIfNotExists() {
        if (!userRepository.existsByUsername("admin")) {
            User adminUser = new User();
            adminUser.setUsername("admin");
            adminUser.setName("System Administrator");
            adminUser.setEmail("admin@municipal.com");
            adminUser.setPassword(passwordEncoder.encode("admin123"));
            adminUser.setRole(UserRole.ROLE_ADMIN);
            userRepository.save(adminUser);
        }
    }
}