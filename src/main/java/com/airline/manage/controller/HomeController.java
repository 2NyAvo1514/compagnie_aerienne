package com.airline.manage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/") // <-- c'est ici que '/' est géré
    public String index() {
        // Retourne la JSP home/index.jsp
        return "home/index";
    }

    @GetMapping("/home")
    public String home() {
        return "home/index";
    }
}
