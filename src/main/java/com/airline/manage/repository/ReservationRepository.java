package com.airline.manage.repository;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.airline.manage.model.Reservation;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, Integer> {

    // Nombre de places réservées pour un vol
    @Query("""
           SELECT COALESCE(SUM(r.nbPlaces), 0)
           FROM Reservation r
           WHERE r.avionVol.id = :avionVolId
           """)
    Integer sumPlacesByAvionVol(@Param("avionVolId") Integer avionVolId);

    // Chiffre d'affaires par avion
    @Query("""
           SELECT COALESCE(SUM(r.prixTotal), 0)
           FROM Reservation r
           WHERE r.avionVol.avion.id = :avionId
           """)
    BigDecimal getChiffreAffairesParAvion(@Param("avionId") Integer avionId);

    // Chiffre d'affaires total
    @Query("""
           SELECT COALESCE(SUM(r.prixTotal), 0)
           FROM Reservation r
           """)
    BigDecimal getChiffreAffairesTotal();

    // Chiffre d'affaires par période
    @Query("""
           SELECT COALESCE(SUM(r.prixTotal), 0)
           FROM Reservation r
           WHERE r.dateReservation BETWEEN :dateDebut AND :dateFin
           """)
    BigDecimal getChiffreAffairesParPeriode(
            @Param("dateDebut") LocalDateTime dateDebut,
            @Param("dateFin") LocalDateTime dateFin
    );

    // Chiffre d'affaires par avion et période
    @Query("""
           SELECT COALESCE(SUM(r.prixTotal), 0)
           FROM Reservation r
           WHERE r.avionVol.avion.id = :avionId
             AND r.dateReservation BETWEEN :dateDebut AND :dateFin
           """)
    BigDecimal getChiffreAffairesParAvionEtPeriode(
            @Param("avionId") Integer avionId,
            @Param("dateDebut") LocalDateTime dateDebut,
            @Param("dateFin") LocalDateTime dateFin
    );

    // Nombre de réservations par avion
    @Query("""
           SELECT COUNT(r)
           FROM Reservation r
           WHERE r.avionVol.avion.id = :avionId
           """)
    Integer countByAvion(@Param("avionId") Integer avionId);

    // Nombre de places par avion
    @Query("""
           SELECT COALESCE(SUM(r.nbPlaces), 0)
           FROM Reservation r
           WHERE r.avionVol.avion.id = :avionId
           """)
    Integer sumPlacesByAvion(@Param("avionId") Integer avionId);

    // Total places réservées
    @Query("""
           SELECT COALESCE(SUM(r.nbPlaces), 0)
           FROM Reservation r
           """)
    Integer sumTotalPlaces();

    // Total réservations
    @Query("""
           SELECT COUNT(r)
           FROM Reservation r
           """)
    Integer countTotalReservations();
}
