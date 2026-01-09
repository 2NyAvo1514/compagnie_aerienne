package com.airline.manage.controller;

import com.airline.manage.model.AvionVol;
import com.airline.manage.model.Client;
import com.airline.manage.service.ReservationService;
import com.airline.manage.repository.AvionVolRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.OffsetDateTime;
// import java.time.ZoneOffset;
import java.util.List;

@Controller
@RequestMapping("/reservation")
public class ReservationController {

    @Autowired
    private AvionVolRepository avionVolRepository;

    @Autowired
    private ReservationService reservationService;

    // Page recherche vols
    @GetMapping("/chercher")
    public String chercherVolForm() {
        return "reservation/chercher";
    }

    // Soumission recherche
    @PostMapping("/chercher")
    public String chercherVolResult(
            @RequestParam String depart,
            @RequestParam String arrivee,
            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm") OffsetDateTime dateHeure,
            Model model) {
        OffsetDateTime start = dateHeure.minusHours(1);
        OffsetDateTime end = dateHeure.plusHours(1);

        List<AvionVol> vols = avionVolRepository.findByVolAeroportDepartNomAndVolAeroportArriveeNomAndDateHeureBetween(
                depart, arrivee, start, end);

        model.addAttribute("vols", vols);
        return "reservation/vols-disponibles";
    }

    // Réserver un vol
    @PostMapping("/reserver")
    public String reserverVol(
            @RequestParam Integer avionVolId,
            @RequestParam int nbPlaces,
            HttpSession session,
            Model model) {
        Client client = (Client) session.getAttribute("client"); // client connecté
        if (client == null) {
            model.addAttribute("message", "Vous devez être connecté");
            return "reservation/chercher";
        }

        boolean ok = reservationService.reserver(client, avionVolId, nbPlaces);

        if (ok)
            model.addAttribute("message", "Réservation réussie !");
        else
            model.addAttribute("message", "Nombre de places insuffisant ou vol introuvable");

        return "reservation/confirmation";
    }
}
