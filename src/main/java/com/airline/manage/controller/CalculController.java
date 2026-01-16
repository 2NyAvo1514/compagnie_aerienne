package com.airline.manage.controller;

import com.airline.manage.model.Avion;
import com.airline.manage.model.Vol;
import com.airline.manage.model.AvionVol;
import com.airline.manage.service.CalculService;
import com.airline.manage.service.ValeurMaximaleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/calculer")
public class CalculController {

    @Autowired
    private CalculService calculService;

    @Autowired
    private ValeurMaximaleService valeurMaximaleService;

    @GetMapping("/valeur-maximale")
    public String pageCalculValeurMaximale(Model model) {
        // Charger tous les avions avec leurs configurations de places
        List<Avion> avions = calculService.getAllAvionsWithPlaces();

        // Charger tous les AvionVol (vols programmés)
        List<AvionVol> avionVols = calculService.getAllAvionVolsWithPrices();

        model.addAttribute("avions", avions);
        model.addAttribute("avionVols", avionVols);

        return "calcul";
    }

    @PostMapping("/valeur-maximale")
    public String calculerValeurMaximale(
            @RequestParam Long avionId,
            @RequestParam(required = false) Integer avionVolId,
            @RequestParam(required = false) BigDecimal prixEconomique,
            @RequestParam(required = false) BigDecimal prixAffaires,
            @RequestParam(required = false) BigDecimal prixPremiere,
            @RequestParam(required = false) BigDecimal prixSuite,
            @RequestParam(defaultValue = "true") boolean inclureFrais,
            @RequestParam(defaultValue = "true") boolean inclureTaxes,
            Model model) {

        Map<String, BigDecimal> prixParType = new HashMap<>();
        if (prixEconomique != null)
            prixParType.put("Économique", prixEconomique);
        if (prixAffaires != null)
            prixParType.put("Affaires", prixAffaires);
        if (prixPremiere != null)
            prixParType.put("Première", prixPremiere);
        if (prixSuite != null)
            prixParType.put("Suite", prixSuite);

        // Calculer la valeur maximale
        Map<String, Object> resultats = calculService.calculerValeurMaximale(
                avionId, avionVolId, prixParType, inclureFrais, inclureTaxes);

        model.addAttribute("resultats", resultats);
        model.addAttribute("avions", calculService.getAllAvionsWithPlaces());
        model.addAttribute("avionVols", calculService.getAllAvionVolsWithPrices());

        return "calcul";
    }

    @GetMapping("/exemple/tana-nosybe")
    public String exempleTanaNosyBe(Model model) {
        Map<String, Object> exemple = valeurMaximaleService.calculerExempleTanaNosyBe();
        model.addAttribute("exemple", exemple);
        return "calcul-exemple";
    }

    @GetMapping("/simulation-strategies")
    public String pageSimulationStrategies(Model model) {
        List<Avion> avions = calculService.getAllAvionsWithPlaces();
        model.addAttribute("avions", avions);
        return "simulation-strategies";
    }
}