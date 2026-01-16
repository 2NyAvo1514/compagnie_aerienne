package com.airline.manage.controller;

// import com.airline.manage.model.Avion;
import com.airline.manage.model.*;
import com.airline.manage.repository.*;
// import com.airline.manage.model.AvionVol;
import com.airline.manage.model.PrixVol;
// import com.airline.manage.service.CalculService;
// import com.airline.manage.service.ValeurMaximaleService;
import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Controller;
// import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class ApiController {

    @Autowired
    private PrixVolRepository prixVolRepository;

    @Autowired
    private AvionPlaceRepository avionPlaceRepository;

    @GetMapping("/avionvol/{id}/prix")
    public Map<String, BigDecimal> getPrixByAvionVol(@PathVariable Integer id) {
        Map<String, BigDecimal> prixMap = new HashMap<>();

        List<PrixVol> prixVols = prixVolRepository.findWithPlaceByAvionVolId(id);
        for (PrixVol prixVol : prixVols) {
            prixMap.put(prixVol.getPlace().getType(), prixVol.getPrix());
        }

        return prixMap;
    }

    @GetMapping("/avion/{id}/places")
    public List<AvionPlace> getAvionPlaces(@PathVariable Long id) {
        // Convertir Long en Integer si nécessaire
        return avionPlaceRepository.findWithPlaceByAvionId(id.intValue());
    }
}