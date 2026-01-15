package com.airline.manage.repository;

import com.airline.manage.model.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, Integer> {

    @Query("SELECT COALESCE(SUM(r.nbPlaces), 0) FROM Reservation r WHERE r.avionVol.id = :avionVolId")
    Integer sumPlacesByAvionVol(@Param("avionVolId") Integer avionVolId);

    // Chiffre d'affaires par avion
    @Query("SELECT COALESCE(SUM(r.prixTotal), 0) FROM Reservation r " +
            "WHERE r.avionVol.avion.id = :avionId")
    BigDecimal getChiffreAffairesParAvion(@Param("avionId") Integer avionId);

    // Chiffre d'affaires total
    @Query("SELECT COALESCE(SUM(r.prixTotal), 0) FROM Reservation r")
    BigDecimal getChiffreAffairesTotal();

    // Chiffre d'affaires par période
    @Query("SELECT COALESCE(SUM(r.prixTotal), 0) FROM Reservation r " +
            "WHERE r.dateReservation BETWEEN :dateDebut AND :dateFin")
    BigDecimal getChiffreAffairesParPeriode(@Param("dateDebut") LocalDateTime dateDebut,
            @Param("dateFin") LocalDateTime dateFin);

    // Chiffre d'affaires par avion et par période
    @Query("SELECT COALESCE(SUM(r.prixTotal), 0) FROM Reservation r " +
            "WHERE r.avionVol.avion.id = :avionId " +
            "AND r.dateReservation BETWEEN :dateDebut AND :dateFin")
    BigDecimal getChiffreAffairesParAvionEtPeriode(@Param("avionId") Integer avionId,
            @Param("dateDebut") LocalDateTime dateDebut,
            @Param("dateFin") LocalDateTime dateFin);

    // Ajouter ces méthodes à l'interface ReservationRepository existante

    @Query("SELECT COUNT(r) FROM Reservation r WHERE r.avionVol.avion.id = :avionId")
    Integer countByAvion(@Param("avionId") Integer avionId);

    @Query("SELECT COALESCE(SUM(r.nbPlaces), 0) FROM Reservation r WHERE r.avionVol.avion.id = :avionId")
    Integer sumPlacesByAvion(@Param("avionId") Integer avionId);

    @Query("SELECT COALESCE(SUM(r.nbPlaces), 0) FROM Reservation r")
    Integer sumTotalPlaces();

    @Query("SELECT COUNT(r) FROM Reservation r")
    Integer countTotalReservations();
}