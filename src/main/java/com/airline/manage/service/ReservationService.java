package com.airline.manage.service;

import com.airline.manage.dto.ReservationDTO;
import com.airline.manage.model.*;
import com.airline.manage.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Service
public class ReservationService {

    @Autowired
    private ReservationRepository reservationRepository;

    @Autowired
    private ClientRepository clientRepository;

    @Autowired
    private AvionVolRepository avionVolRepository;

    @Transactional
    public Reservation creerReservation(ReservationDTO reservationDTO) {
        // Vérifier si le client existe, sinon le créer
        Client client = clientRepository.findByEmail(reservationDTO.getEmailClient());
        if (client == null) {
            client = new Client();
            client.setNom(reservationDTO.getNomClient());
            client.setEmail(reservationDTO.getEmailClient());
            client = clientRepository.save(client);
        }

        // Vérifier la disponibilité des places
        AvionVol avionVol = avionVolRepository.findById(reservationDTO.getAvionVolId())
                .orElseThrow(() -> new RuntimeException("Vol non trouvé"));

        int placesReservees = reservationRepository.sumPlacesByAvionVol(avionVol.getId());
        int placesDisponibles = avionVol.getAvion().getCapacite() - (placesReservees != 0 ? placesReservees : 0);

        if (reservationDTO.getNbPlaces() > placesDisponibles) {
            throw new RuntimeException("Nombre de places insuffisant. Places disponibles: " + placesDisponibles);
        }

        // Calculer le prix total
        BigDecimal prixParPlace = avionVol.getVol().getPrix();
        BigDecimal prixTotal = prixParPlace.multiply(BigDecimal.valueOf(reservationDTO.getNbPlaces()));

        // Ajouter des frais de service (10%)
        BigDecimal fraisService = prixTotal.multiply(new BigDecimal("0.10"));
        prixTotal = prixTotal.add(fraisService);

        // Créer la réservation
        Reservation reservation = new Reservation();
        reservation.setAvionVol(avionVol);
        reservation.setClient(client);
        reservation.setNbPlaces(reservationDTO.getNbPlaces());
        reservation.setPrixTotal(prixTotal);
        reservation.setDateReservation(LocalDateTime.now());

        return reservationRepository.save(reservation);
    }

    public int getPlacesDisponibles(Integer avionVolId) {
        AvionVol avionVol = avionVolRepository.findById(avionVolId)
                .orElseThrow(() -> new RuntimeException("Vol non trouvé"));

        int placesReservees = reservationRepository.sumPlacesByAvionVol(avionVolId);
        return avionVol.getAvion().getCapacite() - (placesReservees != 0 ? placesReservees : 0);
    }

    // Nouvelle méthode pour calculer le chiffre d'affaires par avion
    public BigDecimal getChiffreAffairesParAvion(Integer avionId) {
        BigDecimal chiffreAffaires = reservationRepository.getChiffreAffairesParAvion(avionId);
        return chiffreAffaires != null ? chiffreAffaires : BigDecimal.ZERO;
    }

    // Méthode pour obtenir le chiffre d'affaires total
    public BigDecimal getChiffreAffairesTotal() {
        BigDecimal chiffreAffaires = reservationRepository.getChiffreAffairesTotal();
        return chiffreAffaires != null ? chiffreAffaires : BigDecimal.ZERO;
    }

    // Méthode pour obtenir le chiffre d'affaires par période
    public BigDecimal getChiffreAffairesParPeriode(LocalDateTime dateDebut, LocalDateTime dateFin) {
        BigDecimal chiffreAffaires = reservationRepository.getChiffreAffairesParPeriode(dateDebut, dateFin);
        return chiffreAffaires != null ? chiffreAffaires : BigDecimal.ZERO;
    }
}