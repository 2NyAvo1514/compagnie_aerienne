package com.airline.manage.controller;

import com.airline.manage.dto.RechercheVolDTO;
import com.airline.manage.model.Aeroport;
import com.airline.manage.model.AvionVol;
import com.airline.manage.service.VolService;
import com.airline.manage.repository.AeroportRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
public class VolController {

    @Autowired
    private VolService volService;

    @Autowired
    private AeroportRepository aeroportRepository;

    @GetMapping("/")
    public String accueil(Model model) {
        // Initialiser avec les vols à partir d'aujourd'hui
        List<AvionVol> vols = volService.rechercherVolsAujourdhui();
        List<Aeroport> aeroports = aeroportRepository.findAll();

        RechercheVolDTO criteres = new RechercheVolDTO();
        criteres.setDateDebut(LocalDateTime.now());

        model.addAttribute("vols", vols);
        model.addAttribute("aeroports", aeroports);
        model.addAttribute("criteres", criteres);
        model.addAttribute("maintenant", LocalDateTime.now());

        return "index";
    }

    @GetMapping("/rechercher")
    public String rechercherVols(
            @RequestParam(required = false) Integer depart,
            @RequestParam(required = false) Integer arrivee,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date,
            @RequestParam(required = false) @DateTimeFormat(pattern = "HH:mm") LocalTime heure,
            Model model) {

        RechercheVolDTO criteres = new RechercheVolDTO();
        criteres.setAeroportDepartId(depart);
        criteres.setAeroportArriveeId(arrivee);

        if (date != null) {
            LocalDateTime dateHeure = LocalDateTime.of(date, heure != null ? heure : LocalTime.MIN);
            criteres.setDateDebut(dateHeure);
            // criteres.setDateFin(dateHeure.with(LocalTime.MAX));
        } else {
            // Si pas de date, on prend à partir de maintenant
            criteres.setDateDebut(LocalDateTime.now());
        }

        List<AvionVol> vols = volService.rechercherVols(criteres);
        List<Aeroport> aeroports = aeroportRepository.findAll();

        model.addAttribute("vols", vols);
        model.addAttribute("aeroports", aeroports);
        model.addAttribute("criteres", criteres);
        model.addAttribute("maintenant", LocalDateTime.now());

        return "index";
    }

    @GetMapping("/details")
    public String detailsVol(@RequestParam Integer id, Model model) {
        AvionVol avionVol = volService.findAvionVolById(id);
        if (avionVol == null) {
            return "redirect:/";
        }

        model.addAttribute("vol", avionVol);
        model.addAttribute("maintenant", LocalDateTime.now());
        return "detail";
    }
}