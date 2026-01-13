package com.airline.manage.repository;

import com.airline.manage.model.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, Integer> {

    @Query("SELECT COALESCE(SUM(r.nbPlaces), 0) FROM Reservation r WHERE r.avionVol.id = :avionVolId")
    Integer sumPlacesByAvionVol(@Param("avionVolId") Integer avionVolId);
}