package com.airline.manage.repository;

import com.airline.manage.model.AvionVol;
import java.time.LocalDateTime;
import java.util.List;

public interface AvionVolRepositoryCustom {
    List<AvionVol> findByCriteria(
            Integer aeroportDepartId,
            Integer aeroportArriveeId,
            LocalDateTime dateDebut,
            LocalDateTime dateFin);
}