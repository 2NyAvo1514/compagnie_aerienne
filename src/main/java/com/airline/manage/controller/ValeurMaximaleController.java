package com.airline.manage.controller;

import com.airline.manage.service.ValeurMaximaleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.util.Map;

@Controller
@RequestMapping("/valeur-maximale")
public class ValeurMaximaleController {

    @Autowired
    private ValeurMaximaleService valeurMaximaleService;

    @GetMapping("/vol/{avionVolId}")
    public String valeurMaximalePourVol(@PathVariable Integer avionVolId, Model model) {
        Map<String, Object> rapport = valeurMaximaleService.genererRapportValeurMaximale(avionVolId);
        model.addAttribute("rapport", rapport);
        return "valeur-maximale/details-vol";
    }

    @GetMapping("/trajet")
    public String valeurMaximaleParTrajet(
            @RequestParam(required = false) String depart,
            @RequestParam(required = false) String arrivee,
            Model model) {

        if (depart == null)
            depart = "Antananarivo";
        if (arrivee == null)
            arrivee = "Nosy Be";

        Map<String, BigDecimal> valeursParAvion = valeurMaximaleService.calculerValeurMaximaleParAvionPourTrajet(depart,
                arrivee);

        model.addAttribute("depart", depart);
        model.addAttribute("arrivee", arrivee);
        model.addAttribute("valeursParAvion", valeursParAvion);

        return "valeur-maximale/par-trajet";
    }

    @GetMapping("/exemple/tana-nosybe")
    public String exempleTanaNosyBe(Model model) {
        Map<String, Object> exemple = valeurMaximaleService.calculerExempleTanaNosyBe();
        model.addAttribute("exemple", exemple);
        return "exemple";
    }

    @GetMapping("/avion/{avionId}")
    public String valeurMaximaleTotaleAvion(@PathVariable Integer avionId, Model model) {
        BigDecimal valeurTotale = valeurMaximaleService.calculerValeurMaximaleTotalePourAvion(avionId);
        model.addAttribute("avionId", avionId);
        model.addAttribute("valeurTotale", valeurTotale);
        model.addAttribute("valeurTotaleFormatted", String.format("%,.2f Ar", valeurTotale));
        return "totale-avion";
    }
}