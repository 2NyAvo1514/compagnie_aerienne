package com.airline.manage.controller;

import com.airline.manage.dto.ReservationDTO;
import com.airline.manage.model.AvionVol;
import com.airline.manage.service.ReservationService;
import com.airline.manage.service.VolService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;

@Controller
public class ReservationController {

    @Autowired
    private VolService volService;

    @Autowired
    private ReservationService reservationService;

    @GetMapping("/reserver")
    public String formulaireReservation(@RequestParam Integer id, Model model) {
        AvionVol avionVol = volService.findAvionVolById(id);
        if (avionVol == null) {
            return "redirect:/";
        }

        int placesDisponibles = reservationService.getPlacesDisponibles(id);

        ReservationDTO reservationDTO = new ReservationDTO();
        reservationDTO.setAvionVolId(id);

        model.addAttribute("vol", avionVol);
        model.addAttribute("placesDisponibles", placesDisponibles);
        model.addAttribute("reservationDTO", reservationDTO);
        model.addAttribute("maintenant", LocalDateTime.now());

        return "reservation";
    }

    @PostMapping("/reserver")
    public String confirmerReservation(
            @ModelAttribute("reservationDTO") ReservationDTO reservationDTO,
            RedirectAttributes redirectAttributes) {

        try {
            reservationService.creerReservation(reservationDTO);
            redirectAttributes.addFlashAttribute("success", "Réservation confirmée avec succès!");
            return "redirect:/";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/reserver?id=" + reservationDTO.getAvionVolId();
        }
    }
}