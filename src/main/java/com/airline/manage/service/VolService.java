package com.airline.manage.service;

import com.airline.manage.dto.RechercheVolDTO;
import com.airline.manage.model.AvionVol;
import com.airline.manage.model.Vol;
import com.airline.manage.repository.AvionVolRepository;
import com.airline.manage.repository.VolRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
// import java.time.LocalTime;
import java.util.List;

@Service
public class VolService {

    @Autowired
    private AvionVolRepository avionVolRepository;

    @Autowired
    private VolRepository volRepository;

    public List<AvionVol> rechercherVols(RechercheVolDTO criteres) {
        if (criteres == null) {
            // Retourner tous les vols à partir d'aujourd'hui
            return avionVolRepository.findByCriteria(
                    null,
                    null,
                    LocalDateTime.now(),
                    null);
        }

        LocalDateTime dateDebut = criteres.getDateDebut();
        if (dateDebut == null) {
            return avionVolRepository.findByCriteria(
                    criteres.getAeroportDepartId(),
                    criteres.getAeroportArriveeId(),
                    LocalDateTime.now(),
                    null);
        }

        LocalDateTime dateFin = criteres.getDateFin();
        // if (dateFin == null && dateDebut != null) {
        //     // Si seulement une date de début est spécifiée, chercher pour la journée
        //     // entière
        //     dateFin = dateDebut.with(LocalTime.MAX);
        // }

        return avionVolRepository.findByCriteria(
                criteres.getAeroportDepartId(),
                criteres.getAeroportArriveeId(),
                dateDebut,
                dateFin);
    }

    public List<AvionVol> rechercherVolsAujourdhui() {
        LocalDateTime maintenant = LocalDateTime.now();
        // LocalDateTime finJournee = maintenant.with(LocalTime.MAX);

        return avionVolRepository.findByCriteria(
                null,
                null,
                maintenant,
                null);
    }

    public List<Vol> findAllVols() {
        return volRepository.findAll();
    }

    public AvionVol findAvionVolById(Integer id) {
        return avionVolRepository.findById(id).orElse(null);
    }
}