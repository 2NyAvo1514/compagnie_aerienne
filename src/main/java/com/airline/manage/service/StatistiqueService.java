package com.airline.manage.service;

import com.airline.manage.dto.ChiffreAffairesDTO;
import com.airline.manage.dto.ChiffreAffairesTrajetDTO;
import com.airline.manage.model.Avion;
import com.airline.manage.repository.AvionRepository;
import com.airline.manage.repository.AvionVolRepository;
import com.airline.manage.repository.ReservationRepository;
import com.airline.manage.repository.VolRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class StatistiqueService {

    @Autowired
    private AvionRepository avionRepository;

    @Autowired
    private ReservationRepository reservationRepository;

    @Autowired
    private VolRepository volRepository;
    
    @Autowired
    private AvionVolRepository avionVolRepository;

    public List<ChiffreAffairesDTO> getChiffreAffairesParAvion() {
        List<ChiffreAffairesDTO> resultats = new ArrayList<>();
        List<Avion> avions = avionRepository.findAll();

        for (Avion avion : avions) {
            BigDecimal chiffreAffaires = reservationRepository.getChiffreAffairesParAvion(avion.getId());

            // Compter le nombre de réservations et places vendues
            Integer nombreReservations = reservationRepository.countByAvion(avion.getId());
            Integer placesVendues = reservationRepository.sumPlacesByAvion(avion.getId());

            ChiffreAffairesDTO dto = new ChiffreAffairesDTO(
                    avion.getId(),
                    avion.getNom(),
                    avion.getModele(),
                    nombreReservations != null ? nombreReservations : 0,
                    placesVendues != null ? placesVendues : 0,
                    chiffreAffaires != null ? chiffreAffaires : BigDecimal.ZERO);

            resultats.add(dto);
        }

        return resultats;
    }

    public List<ChiffreAffairesDTO> getChiffreAffairesParAvionEtPeriode(LocalDateTime dateDebut,
            LocalDateTime dateFin) {
        List<ChiffreAffairesDTO> resultats = new ArrayList<>();
        List<Avion> avions = avionRepository.findAll();

        for (Avion avion : avions) {
            BigDecimal chiffreAffaires = reservationRepository.getChiffreAffairesParAvionEtPeriode(
                    avion.getId(), dateDebut, dateFin);

            if (chiffreAffaires != null && chiffreAffaires.compareTo(BigDecimal.ZERO) > 0) {
                ChiffreAffairesDTO dto = new ChiffreAffairesDTO(
                        avion.getId(),
                        avion.getNom(),
                        avion.getModele(),
                        null, // Vous pouvez ajouter le comptage par période si nécessaire
                        null,
                        chiffreAffaires);

                resultats.add(dto);
            }
        }

        return resultats;
    }

    
    // public List<ChiffreAffairesTrajetDTO> getChiffreAffairesParTrajet() {
    //     return volRepository.getChiffreAffairesParTrajet();
    // }
    
    // // Statistiques par trajet avec période
    // public List<ChiffreAffairesTrajetDTO> getChiffreAffairesParTrajetEtPeriode(LocalDateTime dateDebut, LocalDateTime dateFin) {
    //     return volRepository.getChiffreAffairesParTrajetEtPeriode(dateDebut, dateFin);
    // }
    
    // // Top 10 des trajets les plus rentables
    // public List<ChiffreAffairesTrajetDTO> getTopTrajets(Integer limit) {
    //     List<ChiffreAffairesTrajetDTO> allTrajets = getChiffreAffairesParTrajet();
        
    //     // Trier par chiffre d'affaires décroissant
    //     allTrajets.sort((t1, t2) -> t2.getChiffreAffaires().compareTo(t1.getChiffreAffaires()));
        
    //     // Limiter aux N premiers
    //     if (limit != null && limit < allTrajets.size()) {
    //         return allTrajets.subList(0, limit);
    //     }
        
    //     return allTrajets;
    // }
    
    // // Statistiques détaillées pour un trajet spécifique
    // public ChiffreAffairesTrajetDTO getStatistiquesTrajet(Integer volId) {
    //     return volRepository.getStatistiquesTrajet(volId);
    // }
    
    // // Taux de remplissage par trajet
    // public List<ChiffreAffairesTrajetDTO> getTauxRemplissageParTrajet() {
    //     List<ChiffreAffairesTrajetDTO> trajets = getChiffreAffairesParTrajet();
        
    //     for (ChiffreAffairesTrajetDTO trajet : trajets) {
    //         // Calculer la capacité totale pour ce trajet
    //         Integer capaciteTotale = avionVolRepository.getCapaciteTotaleParTrajet(trajet.getTrajetId());
    //         if (capaciteTotale != null && capaciteTotale > 0) {
    //             // Le taux de remplissage est déjà calculé dans le DTO via getTauxRemplissage()
    //         }
    //     }
        
    //     return trajets;
    // }

    // Méthodes utilitaires pour les rapports
    public BigDecimal getChiffreAffairesTotal() {
        return reservationRepository.getChiffreAffairesTotal();
    }

    public Integer getTotalPlacesVendues() {
        return reservationRepository.sumTotalPlaces();
    }

    public Integer getTotalReservations() {
        return reservationRepository.countTotalReservations();
    }
}
