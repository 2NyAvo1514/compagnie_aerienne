package com.airline.manage.repository;

import com.airline.manage.model.Aeroport;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AeroportRepository extends JpaRepository<Aeroport, Long> {
    Optional<Aeroport> findByNomAndVille(String nom, String ville);

    @Query("SELECT a FROM Aeroport a WHERE LOWER(a.nom) LIKE LOWER(CONCAT('%', :recherche, '%')) OR LOWER(a.ville) LIKE LOWER(CONCAT('%', :recherche, '%'))")
    List<Aeroport> rechercherAeroport(@Param("recherche") String recherche);

    List<Aeroport> findByNomContainingIgnoreCase(String nom);
}