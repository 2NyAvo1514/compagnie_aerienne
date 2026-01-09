package com.airline.manage.repository;

import com.airline.manage.model.AvionVol;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

// import java.time.LocalDate;
// import java.time.LocalTime;
import java.time.OffsetDateTime;
import java.util.List;

@Repository
public interface AvionVolRepository extends JpaRepository<AvionVol, Integer> {

    // Rechercher les vols selon critères
    List<AvionVol> findByVolAeroportDepartNomAndVolAeroportArriveeNomAndDateHeureBetween(
            String depart, String arrivee,
            OffsetDateTime start, OffsetDateTime end);

    // Recherche avancée avec paramètres optionnels
    @Query("""
                SELECT av
                FROM AvionVol av
                JOIN av.vol v
                JOIN v.aeroportDepart ad
                JOIN v.aeroportArrivee aa
                WHERE av.dateHeure BETWEEN :start AND :end
                  AND (:depart IS NULL OR ad.ville = :depart)
                  AND (:arrivee IS NULL OR aa.ville = :arrivee)
            """)
    List<AvionVol> searchFlights(
            @Param("start") OffsetDateTime start,
            @Param("end") OffsetDateTime end,
            @Param("depart") String depart,
            @Param("arrivee") String arrivee);

}
