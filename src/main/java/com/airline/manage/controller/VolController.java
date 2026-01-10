package com.airline.manage.controller;

import com.airline.manage.dto.FiltreVolDTO;
import com.airline.manage.dto.ResultatVolDTO;
import com.airline.manage.model.Aeroport;
import com.airline.manage.repository.AeroportRepository;
import com.airline.manage.service.RechercheVolService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/vols")
public class VolController {

    @Autowired
    private RechercheVolService rechercheVolService;

    @Autowired
    private AeroportRepository aeroportRepository;

    @GetMapping("/liste")
public String listerVols(
        @ModelAttribute FiltreVolDTO filtre,
        @RequestParam(value = "date", required = false) String dateParam,
        Model model) {
    
    // Traiter le paramètre date venant du formulaire
    if (dateParam != null) {
        if (dateParam.isEmpty()) {
            // Champ date vide = pas de filtre par date
            filtre.setDate(null);
        } else {
            try {
                filtre.setDate(LocalDate.parse(dateParam));
            } catch (Exception e) {
                filtre.setDate(null);
            }
        }
    }
    
    // NE PAS mettre de date par défaut ici !
    // Laisser le service gérer l'absence de date
    
    // Rechercher les vols selon les filtres
    List<ResultatVolDTO> vols = rechercheVolService.rechercherVolsAvecFiltres(filtre);
    
    // Ajouter la liste des aéroports pour le select
    List<Aeroport> aeroports = aeroportRepository.findAll();
    
    model.addAttribute("vols", vols);
    model.addAttribute("aeroports", aeroports);
    model.addAttribute("filtre", filtre);
    
    return "liste-vols";
}

    @GetMapping("/recherche-avancee")
    public String rechercheAvancee(Model model) {
        List<Aeroport> aeroports = aeroportRepository.findAll();

        // Créer un filtre par défaut avec date d'aujourd'hui
        FiltreVolDTO filtre = new FiltreVolDTO();
        filtre.setDate(LocalDate.now());

        model.addAttribute("aeroports", aeroports);
        model.addAttribute("filtre", filtre);

        return "recherche-avancee";
    }
}