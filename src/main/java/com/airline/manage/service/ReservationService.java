package com.airline.manage.service;

import com.airline.manage.dto.ReservationDTO;
import com.airline.manage.model.AvionVol;
import com.airline.manage.model.Client;
import com.airline.manage.model.Reservation;
import com.airline.manage.repository.AvionVolRepository;
import com.airline.manage.repository.ClientRepository;
import com.airline.manage.repository.ReservationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

        // Créer la réservation
        Reservation reservation = new Reservation();
        reservation.setAvionVol(avionVol);
        reservation.setClient(client);
        reservation.setNbPlaces(reservationDTO.getNbPlaces());

        return reservationRepository.save(reservation);
    }

    public int getPlacesDisponibles(Integer avionVolId) {
        AvionVol avionVol = avionVolRepository.findById(avionVolId)
                .orElseThrow(() -> new RuntimeException("Vol non trouvé"));

        int placesReservees = reservationRepository.sumPlacesByAvionVol(avionVolId);
        return avionVol.getAvion().getCapacite() - (placesReservees != 0 ? placesReservees : 0);
    }
}