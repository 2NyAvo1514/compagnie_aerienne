package com.airline.manage.service;

import com.airline.manage.model.AvionVol;
import com.airline.manage.model.Client;
import com.airline.manage.model.Reservation;
import com.airline.manage.repository.AvionVolRepository;
import com.airline.manage.repository.ReservationRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

// import java.time.OffsetDateTime;
import java.util.Optional;

@Service
public class ReservationService {

    @Autowired
    private AvionVolRepository avionVolRepository;

    @Autowired
    private ReservationRepository reservationRepository;

    @Transactional
    public boolean reserver(Client client, Integer avionVolId, int nbPlaces) {
        Optional<AvionVol> volOpt = avionVolRepository.findById(avionVolId);

        if (volOpt.isEmpty())
            return false;

        AvionVol vol = volOpt.get();

        // Calcul du nombre de places déjà réservées
        int placesReservees = reservationRepository.sumNbPlacesByAvionVol(vol.getId());
        if (placesReservees + nbPlaces > vol.getAvion().getCapacite()) {
            return false; // pas assez de places disponibles
        }

        Reservation r = new Reservation();
        r.setClient(client);
        r.setAvionVol(vol);
        r.setNbPlaces(nbPlaces);
        reservationRepository.save(r);

        return true;
    }
}
