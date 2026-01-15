package com.airline.manage.controller;

import com.airline.manage.dto.ChiffreAffairesDTO;
import com.airline.manage.dto.ChiffreAffairesTrajetDTO;
import com.airline.manage.dto.PeriodeRapideDTO;
import com.airline.manage.service.StatistiqueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

@Controller
public class StatistiqueController {

    @Autowired
    private StatistiqueService statistiqueService;

    @GetMapping("/statistiques")
    public String pageStatistiques(Model model) {
        List<ChiffreAffairesDTO> chiffreAffaires = statistiqueService.getChiffreAffairesParAvion();
        BigDecimal chiffreAffairesTotal = statistiqueService.getChiffreAffairesTotal();
        Integer totalReservations = statistiqueService.getTotalReservations();
        Integer totalPlacesVendues = statistiqueService.getTotalPlacesVendues();

        model.addAttribute("chiffreAffaires", chiffreAffaires);
        model.addAttribute("chiffreAffairesTotal", chiffreAffairesTotal);
        model.addAttribute("totalReservations", totalReservations);
        model.addAttribute("totalPlacesVendues", totalPlacesVendues);

        return "statistiques";
    }

    @GetMapping("/statistiques/par-periode")
    public String statistiquesParPeriode(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateDebut,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateFin,
            Model model) {

        if (dateDebut == null) {
            dateDebut = LocalDate.now().minusMonths(1);
        }

        if (dateFin == null) {
            dateFin = LocalDate.now();
        }

        LocalDateTime debut = dateDebut.atStartOfDay();
        LocalDateTime fin = dateFin.atTime(LocalTime.MAX);

        List<ChiffreAffairesDTO> chiffreAffaires = statistiqueService.getChiffreAffairesParAvionEtPeriode(debut, fin);
        BigDecimal chiffreAffairesTotal = statistiqueService.getChiffreAffairesTotal();

        model.addAttribute("chiffreAffaires", chiffreAffaires);
        model.addAttribute("chiffreAffairesTotal", chiffreAffairesTotal);
        model.addAttribute("dateDebut", dateDebut);
        model.addAttribute("dateFin", dateFin);

        return "statistiques-periode";
    }
    // @GetMapping("/statistiques/trajets")
    // public String statistiquesParTrajet(Model model) {
    //     List<ChiffreAffairesTrajetDTO> trajets = statistiqueService.getChiffreAffairesParTrajet();
    //     BigDecimal chiffreAffairesTotal = calculerChiffreAffairesTotalTrajets(trajets);
    //     Long totalReservations = calculerTotalReservationsTrajets(trajets);
    //     Long totalPlacesVendues = calculerTotalPlacesVenduesTrajets(trajets);
        
    //     model.addAttribute("trajets", trajets);
    //     model.addAttribute("chiffreAffairesTotal", chiffreAffairesTotal);
    //     model.addAttribute("totalReservations", totalReservations);
    //     model.addAttribute("totalPlacesVendues", totalPlacesVendues);
    //     model.addAttribute("topTrajets", statistiqueService.getTopTrajets(5));
        
    //     return "statistiques-trajets";
    // }
    
    // @GetMapping("/statistiques/trajets/par-periode")
    // public String statistiquesTrajetsParPeriode(
    //         @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateDebut,
    //         @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateFin,
    //         Model model) {
        
    //     if (dateDebut == null) {
    //         dateDebut = LocalDate.now().minusMonths(1);
    //     }
        
    //     if (dateFin == null) {
    //         dateFin = LocalDate.now();
    //     }
        
    //     LocalDateTime debut = dateDebut.atStartOfDay();
    //     LocalDateTime fin = dateFin.atTime(LocalTime.MAX);
        
    //     List<ChiffreAffairesTrajetDTO> trajets = 
    //         statistiqueService.getChiffreAffairesParTrajetEtPeriode(debut, fin);
    //     List<ChiffreAffairesTrajetDTO> topTrajets = statistiqueService.getTopTrajets(5);
    //     List<PeriodeRapideDTO> periodesRapides = getPeriodesRapides();
        
    //     BigDecimal chiffreAffairesTotal = calculerChiffreAffairesTotalTrajets(trajets);
    //     Long totalReservations = calculerTotalReservationsTrajets(trajets);
    //     Long totalPlacesVendues = calculerTotalPlacesVenduesTrajets(trajets);
        
    //     model.addAttribute("trajets", trajets);
    //     model.addAttribute("chiffreAffairesTotal", chiffreAffairesTotal);
    //     model.addAttribute("totalReservations", totalReservations);
    //     model.addAttribute("totalPlacesVendues", totalPlacesVendues);
    //     model.addAttribute("topTrajets", topTrajets);
    //     model.addAttribute("dateDebut", dateDebut);
    //     model.addAttribute("dateFin", dateFin);
    //     model.addAttribute("periodesRapides", periodesRapides);
        
    //     return "statistiques-trajets-periode";
    // }
    
    // @GetMapping("/statistiques/trajets/detail")
    // public String detailTrajet(
    //         @RequestParam Integer trajetId,
    //         Model model) {
        
    //     ChiffreAffairesTrajetDTO trajet = statistiqueService.getStatistiquesTrajet(trajetId);
    //     List<ChiffreAffairesTrajetDTO> historique = statistiqueService.getChiffreAffairesParTrajet();
        
    //     model.addAttribute("trajet", trajet);
    //     model.addAttribute("historique", historique);
        
    //     return "statistiques-trajet-detail";
    // }
    
    // Méthodes utilitaires
    private BigDecimal calculerChiffreAffairesTotalTrajets(List<ChiffreAffairesTrajetDTO> trajets) {
        return trajets.stream()
                .map(ChiffreAffairesTrajetDTO::getChiffreAffaires)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    private Long calculerTotalReservationsTrajets(List<ChiffreAffairesTrajetDTO> trajets) {
        return trajets.stream()
                .map(ChiffreAffairesTrajetDTO::getNombreReservations)
                .map(Long::valueOf) // Conversion en Long
                .reduce(0L, Long::sum);
    }

    private Long calculerTotalPlacesVenduesTrajets(List<ChiffreAffairesTrajetDTO> trajets) {
        return trajets.stream()
                .map(ChiffreAffairesTrajetDTO::getPlacesVendues)
                .map(Long::valueOf) // Conversion en Long
                .reduce(0L, Long::sum);
    }

    // Méthode supplémentaire pour calculer le total des vols
    private Long calculerTotalVolsTrajets(List<ChiffreAffairesTrajetDTO> trajets) {
        return trajets.stream()
                .map(ChiffreAffairesTrajetDTO::getNombreVols)
                .map(Long::valueOf)
                .reduce(0L, Long::sum);
    }

    private List<PeriodeRapideDTO> getPeriodesRapides() {
        List<PeriodeRapideDTO> periodes = new ArrayList<>();
        LocalDate aujourdhui = LocalDate.now();

        periodes.add(new PeriodeRapideDTO("Aujourd'hui", aujourdhui, aujourdhui));
        periodes.add(new PeriodeRapideDTO("Hier", aujourdhui.minusDays(1), aujourdhui.minusDays(1)));
        periodes.add(new PeriodeRapideDTO("Cette semaine",
                aujourdhui.minusDays(aujourdhui.getDayOfWeek().getValue() - 1),
                aujourdhui));
        periodes.add(new PeriodeRapideDTO("Semaine dernière",
                aujourdhui.minusDays(aujourdhui.getDayOfWeek().getValue() + 6),
                aujourdhui.minusDays(aujourdhui.getDayOfWeek().getValue())));
        periodes.add(new PeriodeRapideDTO("Ce mois",
                aujourdhui.withDayOfMonth(1),
                aujourdhui));
        periodes.add(new PeriodeRapideDTO("Mois dernier",
                aujourdhui.minusMonths(1).withDayOfMonth(1),
                aujourdhui.withDayOfMonth(1).minusDays(1)));

        return periodes;
    }
}
