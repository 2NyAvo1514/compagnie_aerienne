package com.airline.manage.repository;

import com.airline.manage.model.Avion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AvionRepository extends JpaRepository<Avion, Long> {
}
