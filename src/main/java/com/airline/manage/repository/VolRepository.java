package com.airline.manage.repository;

import com.airline.manage.dto.ChiffreAffairesTrajetDTO;
import com.airline.manage.model.Vol;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface VolRepository extends JpaRepository<Vol, Integer> {

    // Correction des méthodes de statistiques par trajet

//     @Query("SELECT new com.airline.manage.dto.ChiffreAffairesTrajetDTO(" +
//             "v.id, " +
//             "ad.nom, " +
//             "ad.ville, " +
//             "aa.nom, " +
//             "aa.ville, " +
//             "COUNT(DISTINCT av), " + // Compte des AvionVol distincts
//             "COUNT(r), " + // Compte des Réservations
//             "COALESCE(SUM(r.nbPlaces), 0), " +
//             "COALESCE(SUM(r.prixTotal), 0), " +
//             "COALESCE(AVG(v.prix), 0)) " + // Utiliser COALESCE pour AVG
//             "FROM Vol v " +
//             "LEFT JOIN v.aeroportDepart ad " +
//             "LEFT JOIN v.aeroportArrivee aa " +
//             "LEFT JOIN AvionVol av ON av.vol.id = v.id " +
//             "LEFT JOIN av.reservations r " + // Joindre via AvionVol
//             "GROUP BY v.id, ad.id, aa.id, ad.nom, ad.ville, aa.nom, aa.ville " +
//             "ORDER BY COALESCE(SUM(r.prixTotal), 0) DESC")
//     List<ChiffreAffairesTrajetDTO> getChiffreAffairesParTrajet();

//     @Query("SELECT new com.airline.manage.dto.ChiffreAffairesTrajetDTO(" +
//             "v.id, " +
//             "ad.nom, " +
//             "ad.ville, " +
//             "aa.nom, " +
//             "aa.ville, " +
//             "COUNT(DISTINCT av), " +
//             "COUNT(r), " +
//             "COALESCE(SUM(r.nbPlaces), 0), " +
//             "COALESCE(SUM(r.prixTotal), 0), " +
//             "COALESCE(AVG(v.prix), 0)) " +
//             "FROM Vol v " +
//             "LEFT JOIN v.aeroportDepart ad " +
//             "LEFT JOIN v.aeroportArrivee aa " +
//             "LEFT JOIN AvionVol av ON av.vol.id = v.id " +
//             "LEFT JOIN av.reservations r " +
//             "WHERE (r.dateReservation IS NULL OR r.dateReservation BETWEEN :dateDebut AND :dateFin) " +
//             "GROUP BY v.id, ad.id, aa.id, ad.nom, ad.ville, aa.nom, aa.ville " +
//             "ORDER BY COALESCE(SUM(r.prixTotal), 0) DESC")
//     List<ChiffreAffairesTrajetDTO> getChiffreAffairesParTrajetEtPeriode(
//             @Param("dateDebut") LocalDateTime dateDebut,
//             @Param("dateFin") LocalDateTime dateFin);

//     @Query("SELECT new com.airline.manage.dto.ChiffreAffairesTrajetDTO(" +
//             "v.id, " +
//             "ad.nom, " +
//             "ad.ville, " +
//             "aa.nom, " +
//             "aa.ville, " +
//             "COUNT(DISTINCT av), " +
//             "COUNT(r), " +
//             "COALESCE(SUM(r.nbPlaces), 0), " +
//             "COALESCE(SUM(r.prixTotal), 0), " +
//             "COALESCE(AVG(v.prix), 0)) " +
//             "FROM Vol v " +
//             "LEFT JOIN v.aeroportDepart ad " +
//             "LEFT JOIN v.aeroportArrivee aa " +
//             "LEFT JOIN AvionVol av ON av.vol.id = v.id " +
//             "LEFT JOIN av.reservations r " +
//             "WHERE v.id = :volId " +
//             "GROUP BY v.id, ad.id, aa.id, ad.nom, ad.ville, aa.nom, aa.ville")
//     ChiffreAffairesTrajetDTO getStatistiquesTrajet(@Param("volId") Integer volId);

//     // Version simplifiée si la version ci-dessus ne fonctionne pas
//     @Query("SELECT new com.airline.manage.dto.ChiffreAffairesTrajetDTO(" +
//             "v.id, " +
//             "ad.nom, " +
//             "ad.ville, " +
//             "aa.nom, " +
//             "aa.ville, " +
//             "(SELECT COUNT(av2) FROM AvionVol av2 WHERE av2.vol.id = v.id), " +
//             "(SELECT COUNT(r2) FROM Reservation r2 WHERE r2.avionVol.vol.id = v.id), " +
//             "COALESCE((SELECT SUM(r3.nbPlaces) FROM Reservation r3 WHERE r3.avionVol.vol.id = v.id), 0), " +
//             "COALESCE((SELECT SUM(r4.prixTotal) FROM Reservation r4 WHERE r4.avionVol.vol.id = v.id), 0), " +
//             "COALESCE(v.prix, 0)) " + // Utiliser le prix du vol directement
//             "FROM Vol v " +
//             "JOIN v.aeroportDepart ad " +
//             "JOIN v.aeroportArrivee aa " +
//             "ORDER BY COALESCE((SELECT SUM(r5.prixTotal) FROM Reservation r5 WHERE r5.avionVol.vol.id = v.id), 0) DESC")
//     List<ChiffreAffairesTrajetDTO> getChiffreAffairesParTrajetSimple();
}