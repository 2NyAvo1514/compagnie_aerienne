package com.airline.manage.repository;

import com.airline.manage.model.Avion;
import com.airline.manage.model.AvionPlace;
import com.airline.manage.model.Place;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AvionPlaceRepository extends JpaRepository<AvionPlace, Integer> {

    List<AvionPlace> findByAvion(Avion avion);

    List<AvionPlace> findByPlace(Place place);

    Optional<AvionPlace> findByAvionAndPlace(Avion avion, Place place);

    @Query("SELECT SUM(ap.nombre) FROM AvionPlace ap WHERE ap.avion.id = :avionId")
    Integer getCapaciteTotaleByAvionId(@Param("avionId") Integer avionId);

    @Query("SELECT ap.nombre FROM AvionPlace ap WHERE ap.avion.id = :avionId AND ap.place.type = :typePlace")
    Integer getNombrePlacesByAvionIdAndType(@Param("avionId") Integer avionId,
            @Param("typePlace") String typePlace);
    
    List<AvionPlace> findByAvionId(Integer avionId);

    @Query("SELECT ap FROM AvionPlace ap " +
            "JOIN FETCH ap.place " +
            "WHERE ap.avion.id = :avionId")
    List<AvionPlace> findWithPlaceByAvionId(@Param("avionId") Integer avionId);
}