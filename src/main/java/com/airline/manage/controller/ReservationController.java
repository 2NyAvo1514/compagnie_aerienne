package com.airline.manage.controller;

import com.airline.manage.dto.RechercheVolDTO;
import com.airline.manage.dto.ReservationDTO;
import com.airline.manage.dto.ResultatVolDTO;
import com.airline.manage.service.RechercheVolService;
import com.airline.manage.service.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/reservation")
public class ReservationController {

    @Autowired
    private RechercheVolService rechercheVolService;

    @Autowired
    private ReservationService reservationService;

    @GetMapping("/recherche")
    public String afficherPageRecherche(Model model) {
        model.addAttribute("rechercheVolDTO", new RechercheVolDTO());
        return "recherche-vol";
    }

    @PostMapping("/rechercher")
    public String rechercherVols(@ModelAttribute RechercheVolDTO rechercheVolDTO, Model model) {
        // Recherche de TNR à Nosy Be pour le 12 janvier à 12h
        rechercheVolDTO.setAeroportDepart("Aéroport d'Ivato");
        rechercheVolDTO.setAeroportArrivee("Aéroport de Fascène");
        rechercheVolDTO.setDate(LocalDate.of(2024, 1, 12));
        rechercheVolDTO.setHeure(12);

        List<ResultatVolDTO> resultats = rechercheVolService.rechercherVols(rechercheVolDTO);

        model.addAttribute("resultats", resultats);
        model.addAttribute("recherche", rechercheVolDTO);

        return "resultats-recherche";
    }

    @GetMapping("/reserver/{avionVolId}")
    public String afficherFormulaireReservation(@PathVariable Long avionVolId, Model model) {
        ReservationDTO reservationDTO = new ReservationDTO();
        reservationDTO.setAvionVolId(avionVolId);

        model.addAttribute("reservationDTO", reservationDTO);
        return "formulaire-reservation";
    }

    @PostMapping("/confirmer")
    public String confirmerReservation(@ModelAttribute ReservationDTO reservationDTO, Model model) {
        try {
            reservationService.creerReservation(reservationDTO);
            model.addAttribute("message", "Réservation confirmée avec succès !");
            model.addAttribute("reservation", reservationDTO);
            return "confirmation-reservation";
        } catch (Exception e) {
            model.addAttribute("erreur", e.getMessage());
            model.addAttribute("reservationDTO", reservationDTO);
            return "formulaire-reservation";
        }
    }
}