package com.airline.manage.repository;

import com.airline.manage.model.AvionVol;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface AvionVolRepository extends JpaRepository<AvionVol, Integer>, AvionVolRepositoryCustom {

        // Méthode pour trouver tous les AvionVol par ID d'avion
        @Query("SELECT av FROM AvionVol av WHERE av.avion.id = :avionId ORDER BY av.dateHeure DESC")
        List<AvionVol> findByAvionId(@Param("avionId") Integer avionId);

        // Méthode pour trouver les AvionVol par ID d'avion avec une période
        @Query("SELECT av FROM AvionVol av " +
                        "WHERE av.avion.id = :avionId " +
                        "AND av.dateHeure BETWEEN :dateDebut AND :dateFin " +
                        "ORDER BY av.dateHeure DESC")
        List<AvionVol> findByAvionIdAndDateBetween(@Param("avionId") Integer avionId,
                        @Param("dateDebut") LocalDateTime dateDebut,
                        @Param("dateFin") LocalDateTime dateFin);

        // Méthode pour trouver les AvionVol futurs par ID d'avion
        @Query("SELECT av FROM AvionVol av " +
                        "WHERE av.avion.id = :avionId " +
                        "AND av.dateHeure >= CURRENT_TIMESTAMP " +
                        "ORDER BY av.dateHeure ASC")
        List<AvionVol> findFutursByAvionId(@Param("avionId") Integer avionId);

        // Méthode pour trouver les AvionVol passés par ID d'avion
        @Query("SELECT av FROM AvionVol av " +
                        "WHERE av.avion.id = :avionId " +
                        "AND av.dateHeure < CURRENT_TIMESTAMP " +
                        "ORDER BY av.dateHeure DESC")
        List<AvionVol> findPassesByAvionId(@Param("avionId") Integer avionId);

        // Méthode pour compter le nombre d'AvionVol par avion
        @Query("SELECT COUNT(av) FROM AvionVol av WHERE av.avion.id = :avionId")
        Long countByAvionId(@Param("avionId") Integer avionId);

        // Méthodes existantes
        @Query("SELECT COALESCE(SUM(a.capacite), 0) FROM AvionVol av " +
                        "JOIN av.avion a " +
                        "WHERE av.vol.id = :volId")
        Integer getCapaciteTotaleParTrajet(@Param("volId") Integer volId);

        @Query("SELECT COUNT(DISTINCT av.id) FROM AvionVol av " +
                        "WHERE av.vol.id = :volId " +
                        "AND av.dateHeure BETWEEN :dateDebut AND :dateFin")
        Integer countVolsParTrajetEtPeriode(@Param("volId") Integer volId,
                        @Param("dateDebut") LocalDateTime dateDebut,
                        @Param("dateFin") LocalDateTime dateFin);

        // Méthode pour trouver les AvionVol par trajet (départ → arrivée)
        @Query("SELECT av FROM AvionVol av " +
                        "WHERE av.vol.aeroportDepart.ville = :villeDepart " +
                        "AND av.vol.aeroportArrivee.ville = :villeArrivee " +
                        "ORDER BY av.dateHeure DESC")
        List<AvionVol> findByTrajet(@Param("villeDepart") String villeDepart,
                        @Param("villeArrivee") String villeArrivee);

        // Méthode pour trouver les AvionVol par trajet avec une période
        @Query("SELECT av FROM AvionVol av " +
                        "WHERE av.vol.aeroportDepart.ville = :villeDepart " +
                        "AND av.vol.aeroportArrivee.ville = :villeArrivee " +
                        "AND av.dateHeure BETWEEN :dateDebut AND :dateFin " +
                        "ORDER BY av.dateHeure DESC")
        List<AvionVol> findByTrajetAndDateBetween(@Param("villeDepart") String villeDepart,
                        @Param("villeArrivee") String villeArrivee,
                        @Param("dateDebut") LocalDateTime dateDebut,
                        @Param("dateFin") LocalDateTime dateFin);

        // Méthode pour vérifier si un avion a des vols programmés à une date/heure
        // spécifique
        @Query("SELECT COUNT(av) > 0 FROM AvionVol av " +
                        "WHERE av.avion.id = :avionId " +
                        "AND av.dateHeure = :dateHeure")
        boolean existsByAvionIdAndDateHeure(@Param("avionId") Integer avionId,
                        @Param("dateHeure") LocalDateTime dateHeure);

        // Méthode pour trouver les AvionVol par avion et par vol
        @Query("SELECT av FROM AvionVol av " +
                        "WHERE av.avion.id = :avionId " +
                        "AND av.vol.id = :volId " +
                        "ORDER BY av.dateHeure DESC")
        List<AvionVol> findByAvionIdAndVolId(@Param("avionId") Integer avionId,
                        @Param("volId") Integer volId);

        // List<AvionVol> findByAvionId(Integer avionId);

        @Query("SELECT av FROM AvionVol av " +
                        "LEFT JOIN FETCH av.avion " +
                        "LEFT JOIN FETCH av.vol v " +
                        "LEFT JOIN FETCH v.aeroportDepart " +
                        "LEFT JOIN FETCH v.aeroportArrivee " +
                        "ORDER BY av.dateHeure DESC")
        List<AvionVol> findAllWithDetails();

        @Query("SELECT DISTINCT av FROM AvionVol av " +
                        "LEFT JOIN FETCH av.avion " +
                        "LEFT JOIN FETCH av.vol " +
                        "LEFT JOIN FETCH av.prixVols pv " +
                        "LEFT JOIN FETCH pv.place " +
                        "ORDER BY av.dateHeure DESC")
        List<AvionVol> findAllWithPrices();
}