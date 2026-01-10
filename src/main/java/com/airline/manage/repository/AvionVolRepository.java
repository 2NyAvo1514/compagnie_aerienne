package com.airline.manage.repository;

import com.airline.manage.model.AvionVol;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface AvionVolRepository extends JpaRepository<AvionVol, Long> {

        // Méthodes existantes
        @Query("SELECT av FROM AvionVol av WHERE av.vol.id = :volId AND DATE(av.dateHeure) = DATE(:date) AND EXTRACT(HOUR FROM av.dateHeure) = :heure")
        List<AvionVol> findByVolAndDateAndHeure(@Param("volId") Long volId,
                        @Param("date") LocalDateTime date,
                        @Param("heure") Integer heure);

        @Query("SELECT av FROM AvionVol av WHERE av.vol.aeroportDepart.nom = :departNom AND av.vol.aeroportArrivee.nom = :arriveeNom AND DATE(av.dateHeure) = DATE(:date)")
        List<AvionVol> findByAeroportsAndDate(@Param("departNom") String departNom,
                        @Param("arriveeNom") String arriveeNom,
                        @Param("date") LocalDateTime date);

        // Méthodes pour la recherche par plage
        @Query("SELECT av FROM AvionVol av WHERE av.vol.aeroportDepart.nom = :departNom AND av.vol.aeroportArrivee.nom = :arriveeNom AND av.dateHeure BETWEEN :debut AND :fin ORDER BY av.dateHeure")
        List<AvionVol> findByAeroportsAndDateRange(@Param("departNom") String departNom,
                        @Param("arriveeNom") String arriveeNom,
                        @Param("debut") LocalDateTime debut,
                        @Param("fin") LocalDateTime fin);

        @Query("SELECT av FROM AvionVol av WHERE av.dateHeure BETWEEN :debut AND :fin ORDER BY av.dateHeure")
        List<AvionVol> findByDateRange(@Param("debut") LocalDateTime debut,
                        @Param("fin") LocalDateTime fin);

        // NOUVELLE MÉTHODE : Trouver les vols à partir d'une date
        @Query("SELECT av FROM AvionVol av WHERE av.dateHeure >= :debut ORDER BY av.dateHeure")
        List<AvionVol> findFromDate(@Param("debut") LocalDateTime debut);

        @Query("SELECT av FROM AvionVol av WHERE av.dateHeure >= :maintenant ORDER BY av.dateHeure")
        List<AvionVol> findProchainsVols(@Param("maintenant") LocalDateTime maintenant);
}