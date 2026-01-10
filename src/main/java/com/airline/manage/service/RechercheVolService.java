package com.airline.manage.service;

import com.airline.manage.dto.FiltreVolDTO;
import com.airline.manage.dto.RechercheVolDTO;
import com.airline.manage.dto.ResultatVolDTO;
import com.airline.manage.model.Aeroport;
import com.airline.manage.model.AvionVol;
import com.airline.manage.repository.AeroportRepository;
import com.airline.manage.repository.AvionVolRepository;
import com.airline.manage.repository.ReservationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class RechercheVolService {

    @Autowired
    private AeroportRepository aeroportRepository;

    @Autowired
    private AvionVolRepository avionVolRepository;

    @Autowired
    private ReservationRepository reservationRepository;

    // Méthode existante pour la recherche simple (gardez-la si vous en avez besoin)
    public List<ResultatVolDTO> rechercherVols(RechercheVolDTO recherche) {
        List<ResultatVolDTO> resultats = new ArrayList<>();

        Optional<Aeroport> aeroportDepartOpt = aeroportRepository.findByNomAndVille(
                recherche.getAeroportDepart(), "Antananarivo");
        Optional<Aeroport> aeroportArriveeOpt = aeroportRepository.findByNomAndVille(
                recherche.getAeroportArrivee(), "Nosy Be");

        if (aeroportDepartOpt.isPresent() && aeroportArriveeOpt.isPresent()) {
            LocalDate date = recherche.getDate() != null ? recherche.getDate() : LocalDate.now();

            LocalTime time = LocalTime.of(recherche.getHeure() != null ? recherche.getHeure() : 12, 0);
            LocalDateTime dateHeure = LocalDateTime.of(date, time);

            List<AvionVol> avionsVols = avionVolRepository.findByAeroportsAndDate(
                    recherche.getAeroportDepart(),
                    recherche.getAeroportArrivee(),
                    dateHeure);

            for (AvionVol av : avionsVols) {
                int heureVol = av.getDateHeure().getHour();
                if (Math.abs(heureVol - (recherche.getHeure() != null ? recherche.getHeure() : 12)) <= 2) {
                    Integer placesReservees = reservationRepository.getNombrePlacesReservees(av.getId());
                    Integer placesDisponibles = av.getAvion().getCapacite()
                            - (placesReservees != null ? placesReservees : 0);

                    ResultatVolDTO dto = new ResultatVolDTO(
                            av.getId(),
                            av.getVol().getAeroportDepart().getNom(),
                            av.getVol().getAeroportArrivee().getNom(),
                            av.getVol().getAeroportDepart().getVille(),
                            av.getVol().getAeroportArrivee().getVille(),
                            av.getDateHeure(),
                            av.getAvion().getNom(),
                            av.getAvion().getModele(),
                            av.getAvion().getCapacite(),
                            placesDisponibles);

                    resultats.add(dto);
                }
            }
        }

        return resultats;
    }

    public List<ResultatVolDTO> rechercherVolsAvecFiltres(FiltreVolDTO filtre) {
        System.out.println("=== SERVICE: Début recherche vols ===");

        List<ResultatVolDTO> resultats = new ArrayList<>();

        try {
            LocalDateTime dateDebut;
            LocalDateTime dateFin;

            // Si une date est spécifiée dans le filtre
            if (filtre.getDate() != null) {
                LocalDate dateRecherche = filtre.getDate();
                dateDebut = dateRecherche.atStartOfDay();
                dateFin = dateRecherche.atTime(23, 59, 59);
            } else {
                dateDebut = LocalDate.now().atStartOfDay();
                dateFin = LocalDate.now().plusYears(1).atTime(23, 59, 59);
            }

            // Récupérer tous les vols programmés pour la plage de dates
            List<AvionVol> avionsVols = new ArrayList<>();

            // Si les aéroports sont spécifiés, filtrer par aéroports
            if (filtre.getAeroportDepartId() != null && filtre.getAeroportArriveeId() != null) {
                Optional<Aeroport> departOpt = aeroportRepository.findById(filtre.getAeroportDepartId());
                Optional<Aeroport> arriveeOpt = aeroportRepository.findById(filtre.getAeroportArriveeId());

                if (departOpt.isPresent() && arriveeOpt.isPresent()) {
                    String nomDepart = departOpt.get().getNom();
                    String nomArrivee = arriveeOpt.get().getNom();

                    avionsVols = avionVolRepository.findByAeroportsAndDateRange(
                            nomDepart,
                            nomArrivee,
                            dateDebut,
                            dateFin);
                }
            } else {
                avionsVols = avionVolRepository.findByDateRange(dateDebut, dateFin);
            }

            System.out.println("Vols trouvés en base: " + avionsVols.size());

            // Appliquer les filtres supplémentaires
            for (AvionVol av : avionsVols) {
                try {
                    boolean passeFiltres = true;

                    // Vérifier que l'objet av n'est pas null
                    if (av == null || av.getDateHeure() == null) {
                        continue; // Passer au suivant si null
                    }

                    LocalDateTime dateHeureVol = av.getDateHeure();

                    // Convertir les heures min/max du filtre
                    LocalTime heureMin = null;
                    LocalTime heureMax = null;

                    if (filtre.getHeureMin() != null && !filtre.getHeureMin().isEmpty()) {
                        try {
                            heureMin = LocalTime.parse(filtre.getHeureMin());
                        } catch (Exception e) {
                            // Ignorer
                        }
                    }

                    if (filtre.getHeureMax() != null && !filtre.getHeureMax().isEmpty()) {
                        try {
                            heureMax = LocalTime.parse(filtre.getHeureMax());
                        } catch (Exception e) {
                            // Ignorer
                        }
                    }

                    // Filtrer par heure
                    if (heureMin != null) {
                        if (dateHeureVol.toLocalTime().isBefore(heureMin)) {
                            passeFiltres = false;
                        }
                    }

                    if (heureMax != null && passeFiltres) {
                        if (dateHeureVol.toLocalTime().isAfter(heureMax)) {
                            passeFiltres = false;
                        }
                    }

                    // Calculer les places disponibles
                    Integer placesReservees = reservationRepository.getNombrePlacesReservees(av.getId());
                    Integer placesDisponibles = av.getAvion().getCapacite()
                            - (placesReservees != null ? placesReservees : 0);

                    // Filtrer par nombre de places minimum
                    if (passeFiltres && filtre.getPlacesMin() != null) {
                        if (placesDisponibles < filtre.getPlacesMin()) {
                            passeFiltres = false;
                        }
                    }

                    // Filtrer par type d'avion
                    if (passeFiltres && filtre.getTypeAvion() != null && !filtre.getTypeAvion().isEmpty()) {
                        String modeleAvion = av.getAvion().getModele() != null ? av.getAvion().getModele().toLowerCase()
                                : "";
                        String typeRecherche = filtre.getTypeAvion().toLowerCase();
                        if (!modeleAvion.contains(typeRecherche)) {
                            passeFiltres = false;
                        }
                    }

                    if (passeFiltres) {
                        // Récupérer les informations en sécurité
                        String aeroportDepart = av.getVol() != null && av.getVol().getAeroportDepart() != null
                                ? av.getVol().getAeroportDepart().getNom()
                                : "";
                        String aeroportArrivee = av.getVol() != null && av.getVol().getAeroportArrivee() != null
                                ? av.getVol().getAeroportArrivee().getNom()
                                : "";
                        String villeDepart = av.getVol() != null && av.getVol().getAeroportDepart() != null
                                ? av.getVol().getAeroportDepart().getVille()
                                : "";
                        String villeArrivee = av.getVol() != null && av.getVol().getAeroportArrivee() != null
                                ? av.getVol().getAeroportArrivee().getVille()
                                : "";
                        String nomAvion = av.getAvion() != null ? av.getAvion().getNom() : "";
                        String modeleAvion = av.getAvion() != null ? av.getAvion().getModele() : "";
                        Integer capacite = av.getAvion() != null ? av.getAvion().getCapacite() : 0;

                        ResultatVolDTO dto = new ResultatVolDTO(
                                av.getId(),
                                aeroportDepart,
                                aeroportArrivee,
                                villeDepart,
                                villeArrivee,
                                dateHeureVol,
                                nomAvion,
                                modeleAvion,
                                capacite,
                                placesDisponibles);

                        resultats.add(dto);
                    }
                } catch (Exception e) {
                    System.err.println("Erreur lors du traitement d'un vol: " + e.getMessage());
                    e.printStackTrace();
                    // Continuer avec le vol suivant
                }
            }

            // Trier les résultats par date (du plus proche au plus éloigné)
            resultats.sort((v1, v2) -> {
                if (v1.getDateHeure() == null && v2.getDateHeure() == null)
                    return 0;
                if (v1.getDateHeure() == null)
                    return 1;
                if (v2.getDateHeure() == null)
                    return -1;
                return v1.getDateHeure().compareTo(v2.getDateHeure());
            });

            System.out.println("Nombre final de résultats: " + resultats.size());

        } catch (Exception e) {
            System.err.println("Erreur grave dans rechercherVolsAvecFiltres: " + e.getMessage());
            e.printStackTrace();
        }

        System.out.println("=== SERVICE: Fin recherche vols ===");
        return resultats;
    }

    // Méthode pour récupérer tous les vols du jour (pour le dashboard)
    public List<ResultatVolDTO> getVolsDuJour() {
        FiltreVolDTO filtre = new FiltreVolDTO();
        filtre.setDate(LocalDate.now());
        return rechercherVolsAvecFiltres(filtre);
    }

    // NOUVELLE MÉTHODE : Récupérer les prochains vols (pour le dashboard)
    public List<ResultatVolDTO> getProchainsVols(int limit) {
        FiltreVolDTO filtre = new FiltreVolDTO();
        filtre.setDate(LocalDate.now());
        List<ResultatVolDTO> tousLesVols = rechercherVolsAvecFiltres(filtre);

        // Limiter aux X prochains vols
        if (tousLesVols.size() > limit) {
            return tousLesVols.subList(0, limit);
        }
        return tousLesVols;
    }
}