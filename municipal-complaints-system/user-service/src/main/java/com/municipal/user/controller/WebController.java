package com.municipal.user.controller;

import com.municipal.user.dto.UserResponseDto;
import com.municipal.user.service.UserService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping
public class WebController {

    private final UserService userService;

    @Autowired
    public WebController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/")
    public String home() {
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @GetMapping("/citizen/home")
    public String citizenHome(@CookieValue(value = "jwt", required = false) String jwt, Model model) {
        if (jwt != null && userService.validateToken(jwt)) {
            try {
                UserResponseDto user = userService.getUserFromToken(jwt);
                model.addAttribute("user", user);
                return "citizenHome";
            } catch (Exception e) {
                return "redirect:/login";
            }
        }
        return "redirect:/login";
    }

    @GetMapping("/staff/home")
    public String staffHome(@CookieValue(value = "jwt", required = false) String jwt, Model model) {
        if (jwt != null && userService.validateToken(jwt)) {
            try {
                UserResponseDto user = userService.getUserFromToken(jwt);
                if (user.getRole().name().equals("ROLE_STAFF") || user.getRole().name().equals("ROLE_ADMIN")) {
                    model.addAttribute("user", user);
                    return "staffHome";
                }
            } catch (Exception e) {
                return "redirect:/login";
            }
        }
        return "redirect:/login";
    }

    @GetMapping("/admin/home")
    public String adminHome(@CookieValue(value = "jwt", required = false) String jwt, Model model) {
        if (jwt != null && userService.validateToken(jwt)) {
            try {
                UserResponseDto user = userService.getUserFromToken(jwt);
                if (user.getRole().name().equals("ROLE_ADMIN")) {
                    model.addAttribute("user", user);
                    return "adminHome";
                }
            } catch (Exception e) {
                return "redirect:/login";
            }
        }
        return "redirect:/login";
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        // Clear the JWT cookie
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("jwt".equals(cookie.getName())) {
                    cookie.setValue("");
                    cookie.setPath("/");
                    cookie.setMaxAge(0);
                }
            }
        }
        return "redirect:/login";
    }
}