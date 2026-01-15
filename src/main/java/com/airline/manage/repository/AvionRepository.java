package com.airline.manage.repository;

import com.airline.manage.model.Avion;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AvionRepository extends JpaRepository<Avion, Long> {
    List<Avion> findByModele(String modele);

    // Méthode pour trouver les avions avec capacité minimale
    List<Avion> findByCapaciteGreaterThanEqual(Integer capacite);
}
