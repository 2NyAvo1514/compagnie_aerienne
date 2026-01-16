package com.airline.manage.repository;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.airline.manage.model.AvionVol;
import com.airline.manage.model.CategoriePassager;
import com.airline.manage.model.Place;
import com.airline.manage.model.PrixVol;

@Repository
public interface PrixVolRepository extends JpaRepository<PrixVol, Integer> {

    List<PrixVol> findByAvionVol(AvionVol avionVol);

    List<PrixVol> findByPlace(Place place);

    List<PrixVol> findByCategoriePassager(CategoriePassager categoriePassager);

    Optional<PrixVol> findByAvionVolAndPlaceAndCategoriePassager(
            AvionVol avionVol,
            Place place,
            CategoriePassager categoriePassager
    );

    @Query("""
           SELECT pv.prix
           FROM PrixVol pv
           WHERE pv.avionVol.id = :avionVolId
             AND pv.place.id = :placeId
             AND pv.categoriePassager.id = :categorieId
           """)
    BigDecimal findPrix(
            @Param("avionVolId") Integer avionVolId,
            @Param("placeId") Integer placeId,
            @Param("categorieId") Integer categorieId
    );

    @Query("""
           SELECT pv
           FROM PrixVol pv
           JOIN FETCH pv.place
           JOIN FETCH pv.categoriePassager
           WHERE pv.avionVol.id = :avionVolId
           """)
    List<PrixVol> findWithPlaceAndCategorieByAvionVolId(
            @Param("avionVolId") Integer avionVolId
    );

    @Query("""
           SELECT pv
           FROM PrixVol pv
           WHERE pv.avionVol.vol.aeroportDepart.ville = :villeDepart
             AND pv.avionVol.vol.aeroportArrivee.ville = :villeArrivee
           """)
    List<PrixVol> findByTrajet(
            @Param("villeDepart") String villeDepart,
            @Param("villeArrivee") String villeArrivee
    );
}
