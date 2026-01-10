package com.airline.manage.repository;

import com.airline.manage.model.Vol;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface VolRepository extends JpaRepository<Vol, Long> {
    @Query("SELECT v FROM Vol v WHERE v.aeroportDepart.id = :departId AND v.aeroportArrivee.id = :arriveeId")
    Optional<Vol> findByAeroports(@Param("departId") Long departId, @Param("arriveeId") Long arriveeId);

    @Query("SELECT v FROM Vol v WHERE v.aeroportDepart.nom = :departNom AND v.aeroportArrivee.nom = :arriveeNom")
    Optional<Vol> findByAeroportNoms(@Param("departNom") String departNom, @Param("arriveeNom") String arriveeNom);
}