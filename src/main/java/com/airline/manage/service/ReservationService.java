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

import java.util.Optional;

@Service
public class ReservationService {

    @Autowired
    private AvionVolRepository avionVolRepository;

    @Autowired
    private ClientRepository clientRepository;

    @Autowired
    private ReservationRepository reservationRepository;

    @Transactional
    public Reservation creerReservation(ReservationDTO reservationDTO) throws Exception {
        // Vérifier l'existence de l'AvionVol
        Optional<AvionVol> avionVolOpt = avionVolRepository.findById(reservationDTO.getAvionVolId());
        if (!avionVolOpt.isPresent()) {
            throw new Exception("Vol non trouvé");
        }

        AvionVol avionVol = avionVolOpt.get();

        // Vérifier les places disponibles
        Integer placesReservees = reservationRepository.getNombrePlacesReservees(avionVol.getId());
        Integer placesDisponibles = avionVol.getAvion().getCapacite() - (placesReservees != null ? placesReservees : 0);

        if (reservationDTO.getNbPlaces() > placesDisponibles) {
            throw new Exception("Places insuffisantes. Disponible: " + placesDisponibles);
        }

        // Rechercher ou créer le client
        Client client;
        Optional<Client> clientOpt = clientRepository.findByEmail(reservationDTO.getEmailClient());

        if (clientOpt.isPresent()) {
            client = clientOpt.get();
            // Vérifier que le nom correspond
            if (!client.getNom().equals(reservationDTO.getNomClient())) {
                throw new Exception("L'email est déjà utilisé par un autre client");
            }
        } else {
            // Créer un nouveau client
            client = new Client(reservationDTO.getNomClient(), reservationDTO.getEmailClient());
            client = clientRepository.save(client);
        }

        // Créer la réservation
        Reservation reservation = new Reservation(avionVol, client, reservationDTO.getNbPlaces());

        return reservationRepository.save(reservation);
    }
}