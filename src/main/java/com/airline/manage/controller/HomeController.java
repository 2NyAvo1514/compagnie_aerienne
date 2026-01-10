package com.airline.manage.controller;

import com.airline.manage.dto.ResultatVolDTO;
import com.airline.manage.service.RechercheVolService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private RechercheVolService rechercheVolService;

    @GetMapping("/")
    public String home(Model model) {
        // Récupérer les 5 prochains vols pour l'accueil
        List<ResultatVolDTO> prochainsVols = rechercheVolService.getProchainsVols(5);

        model.addAttribute("prochainsVols", prochainsVols);
        return "index";
    }

    @GetMapping("/dashboard")
    public String dashboard() {
        return "dashboard";
    }
}