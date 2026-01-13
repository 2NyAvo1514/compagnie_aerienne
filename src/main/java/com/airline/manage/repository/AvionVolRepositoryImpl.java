package com.airline.manage.repository;

import com.airline.manage.model.AvionVol;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.criteria.*;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Repository
public class AvionVolRepositoryImpl implements AvionVolRepositoryCustom {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<AvionVol> findByCriteria(
            Integer aeroportDepartId,
            Integer aeroportArriveeId,
            LocalDateTime dateDebut,
            LocalDateTime dateFin) {

        var cb = entityManager.getCriteriaBuilder();
        CriteriaQuery<AvionVol> query = cb.createQuery(AvionVol.class);
        Root<AvionVol> avionVol = query.from(AvionVol.class);

        // Joins nécessaires
        Join<?, ?> volJoin = avionVol.join("vol");
        Join<?, ?> aeroportDepartJoin = volJoin.join("aeroportDepart");
        Join<?, ?> aeroportArriveeJoin = volJoin.join("aeroportArrivee");

        List<Predicate> predicates = new ArrayList<>();

        // Date de début
        if (dateDebut != null) {
            predicates.add(cb.greaterThanOrEqualTo(avionVol.get("dateHeure"), dateDebut));
        }

        // Date de fin
        if (dateFin != null) {
            predicates.add(cb.lessThanOrEqualTo(avionVol.get("dateHeure"), dateFin));
        }

        // Aéroport de départ
        if (aeroportDepartId != null) {
            predicates.add(cb.equal(aeroportDepartJoin.get("id"), aeroportDepartId));
        }

        // Aéroport d'arrivée
        if (aeroportArriveeId != null) {
            predicates.add(cb.equal(aeroportArriveeJoin.get("id"), aeroportArriveeId));
        }

        if (!predicates.isEmpty()) {
            query.where(cb.and(predicates.toArray(new Predicate[0])));
        }

        query.orderBy(cb.asc(avionVol.get("dateHeure")));

        return entityManager.createQuery(query).getResultList();
    }
}