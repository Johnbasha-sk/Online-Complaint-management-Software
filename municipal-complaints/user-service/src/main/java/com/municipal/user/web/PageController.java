package com.municipal.user.web;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

    @GetMapping("/ui/login")
    public String loginPage() {
        return "login";
    }

    @GetMapping("/ui/register")
    public String registerPage() {
        return "register";
    }

    @PreAuthorize("hasRole('CITIZEN')")
    @GetMapping("/citizen/home")
    public String citizenHome(Model model) {
        return "citizenHome";
    }

    @PreAuthorize("hasRole('STAFF')")
    @GetMapping("/staff/home")
    public String staffHome(Model model) {
        return "staffHome";
    }

    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/admin/home")
    public String adminHome(Model model) {
        return "adminHome";
    }
}