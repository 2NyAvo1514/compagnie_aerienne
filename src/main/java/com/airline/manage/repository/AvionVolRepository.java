package com.airline.manage.repository;

import com.airline.manage.model.AvionVol;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AvionVolRepository extends JpaRepository<AvionVol, Integer>, AvionVolRepositoryCustom {
}