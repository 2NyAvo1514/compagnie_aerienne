package com.airline.manage.repository;

import com.airline.manage.model.AvionVol;
import com.airline.manage.model.Place;
import com.airline.manage.model.PrixVol;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Repository
public interface PrixVolRepository extends JpaRepository<PrixVol, Integer> {

    List<PrixVol> findByAvionVol(AvionVol avionVol);

    List<PrixVol> findByPlace(Place place);

    Optional<PrixVol> findByAvionVolAndPlace(AvionVol avionVol, Place place);

    @Query("SELECT pv.prix FROM PrixVol pv " +
            "WHERE pv.avionVol.id = :avionVolId AND pv.place.type = :typePlace")
    BigDecimal findPrixByAvionVolIdAndTypePlace(@Param("avionVolId") Integer avionVolId,
            @Param("typePlace") String typePlace);

    @Query("SELECT pv FROM PrixVol pv " +
            "WHERE pv.avionVol.vol.aeroportDepart.ville = :villeDepart " +
            "AND pv.avionVol.vol.aeroportArrivee.ville = :villeArrivee")
    List<PrixVol> findByTrajet(@Param("villeDepart") String villeDepart,
                    @Param("villeArrivee") String villeArrivee);
            
        List<PrixVol> findByAvionVolId(Integer avionVolId);

    @Query("SELECT pv FROM PrixVol pv " +
                    "JOIN FETCH pv.place " +
                    "WHERE pv.avionVol.id = :avionVolId")
    List<PrixVol> findWithPlaceByAvionVolId(@Param("avionVolId") Integer avionVolId);

//     @Query("SELECT pv.prix FROM PrixVol pv " +
//                     "WHERE pv.avionVol.id = :avionVolId " +
//                     "AND pv.place.type = :typePlace")
//     BigDecimal findPrixByAvionVolIdAndTypePlace(@Param("avionVolId") Integer avionVolId,
//                     @Param("typePlace") String typePlace);
}