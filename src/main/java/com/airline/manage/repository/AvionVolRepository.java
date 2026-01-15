package com.airline.manage.repository;

import com.airline.manage.model.AvionVol;

import java.time.LocalDateTime;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface AvionVolRepository extends JpaRepository<AvionVol, Integer>, AvionVolRepositoryCustom {
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
}