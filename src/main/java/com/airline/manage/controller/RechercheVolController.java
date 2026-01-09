package com.airline.manage.controller;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.airline.manage.model.AvionVol;
import com.airline.manage.repository.AvionVolRepository;

@Controller
@RequestMapping("/vols")
public class RechercheVolController {

    private final AvionVolRepository avionVolRepository;

    public RechercheVolController(AvionVolRepository avionVolRepository) {
        this.avionVolRepository = avionVolRepository;
    }

    @GetMapping("/chercher")
    public String chercherVols(
            @RequestParam(required = false) String depart,
            @RequestParam(required = false) String arrivee,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.TIME) LocalTime heure,
            Model model) {

        OffsetDateTime start;
        OffsetDateTime end;

        // Aucun filtre de date → à partir de maintenant jusqu’à +1 an
        if (date == null && heure == null) {
            start = OffsetDateTime.now();
            end = start.plusYears(1);
        }
        // Date uniquement → toute la journée
        else if (date != null && heure == null) {
            start = date.atStartOfDay().atOffset(OffsetDateTime.now().getOffset());
            end = start.plusDays(1);
        }
        // Heure uniquement → aujourd’hui à cette heure
        else if (date == null && heure != null) {
            LocalDate today = LocalDate.now();
            start = today.atTime(heure).atOffset(OffsetDateTime.now().getOffset());
            end = start.plusHours(1);
        }
        // Date + heure → créneau d’1 heure
        else {
            start = date.atTime(heure).atOffset(OffsetDateTime.now().getOffset());
            end = start.plusHours(1);
        }

        List<AvionVol> vols = avionVolRepository.searchFlights(
                start,
                end,
                depart,
                arrivee);

        model.addAttribute("vols", vols);
        return "vol/chercher";
    }

}
