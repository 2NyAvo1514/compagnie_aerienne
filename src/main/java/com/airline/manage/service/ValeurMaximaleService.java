package com.airline.manage.service;

import com.airline.manage.model.*;
import com.airline.manage.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ValeurMaximaleService {

        @Autowired
        private AvionVolRepository avionVolRepository;

        @Autowired
        private AvionPlaceRepository avionPlaceRepository;

        @Autowired
        private PrixVolRepository prixVolRepository;

        @Autowired
        private PlaceRepository placeRepository;

        /**
         * Calcule la valeur maximale qu'un avion peut générer pour un vol spécifique
         */
        public BigDecimal calculerValeurMaximalePourVol(Integer avionVolId) {
                AvionVol avionVol = avionVolRepository.findById(avionVolId)
                                .orElseThrow(() -> new RuntimeException("AvionVol non trouvé"));

                return calculerValeurMaximalePourVol(avionVol);
        }

        /**
         * Calcule la valeur maximale qu'un avion peut générer pour un vol spécifique
         */
        public BigDecimal calculerValeurMaximalePourVol(AvionVol avionVol) {
                BigDecimal valeurTotale = BigDecimal.ZERO;

                // Pour chaque type de place dans l'avion
                for (AvionPlace avionPlace : avionVol.getAvion().getAvionPlaces()) {
                        String typePlace = avionPlace.getPlace().getType();
                        Integer nombrePlaces = avionPlace.getNombre();

                        // Trouver le prix pour ce type de place sur ce vol
                        BigDecimal prix = prixVolRepository.findPrixByAvionVolIdAndTypePlace(
                                        avionVol.getId(), typePlace);

                        if (prix != null) {
                                BigDecimal valeurPourType = prix.multiply(BigDecimal.valueOf(nombrePlaces));
                                valeurTotale = valeurTotale.add(valeurPourType);
                        }
                }

                return valeurTotale;
        }

        /**
         * Calcule la valeur maximale pour un trajet spécifique (ex: Tana → Nosy Be)
         */
        public Map<String, BigDecimal> calculerValeurMaximaleParAvionPourTrajet(
                        String villeDepart, String villeArrivee) {

                Map<String, BigDecimal> valeursParAvion = new HashMap<>();

                // Récupérer tous les AvionVol pour ce trajet
                // Note: Vous devrez ajouter cette méthode dans AvionVolRepository
                // List<AvionVol> avionVols = avionVolRepository.findByTrajet(villeDepart,
                // villeArrivee);

                // Pour la démonstration, on calcule pour tous les AvionVol
                for (AvionVol avionVol : avionVolRepository.findAll()) {
                        if (avionVol.getVol().getAeroportDepart().getVille().equals(villeDepart) &&
                                        avionVol.getVol().getAeroportArrivee().getVille().equals(villeArrivee)) {

                                BigDecimal valeur = calculerValeurMaximalePourVol(avionVol);
                                String avionInfo = avionVol.getAvion().getNom() + " (" +
                                                avionVol.getAvion().getModele() + ") - " +
                                                avionVol.getDateHeureFormatted();

                                valeursParAvion.put(avionInfo, valeur);
                        }
                }

                return valeursParAvion;
        }

        /**
         * Calcule la valeur maximale totale pour un avion sur tous ses vols
         */
        public BigDecimal calculerValeurMaximaleTotalePourAvion(Integer avionId) {
                BigDecimal valeurTotale = BigDecimal.ZERO;

                // Récupérer tous les AvionVol pour cet avion
                List<AvionVol> avionVols = avionVolRepository.findByAvionId(avionId);

                for (AvionVol avionVol : avionVols) {
                        BigDecimal valeurVol = calculerValeurMaximalePourVol(avionVol);
                        valeurTotale = valeurTotale.add(valeurVol);
                }

                return valeurTotale;
        }

        /**
         * Génère un rapport détaillé pour un vol
         */
        public Map<String, Object> genererRapportValeurMaximale(Integer avionVolId) {
                AvionVol avionVol = avionVolRepository.findById(avionVolId)
                                .orElseThrow(() -> new RuntimeException("AvionVol non trouvé"));

                Map<String, Object> rapport = new HashMap<>();
                Map<String, Map<String, Object>> detailsParType = new HashMap<>();

                BigDecimal valeurTotale = BigDecimal.ZERO;

                // Détails par type de place
                for (AvionPlace avionPlace : avionVol.getAvion().getAvionPlaces()) {
                        String typePlace = avionPlace.getPlace().getType();
                        Integer nombrePlaces = avionPlace.getNombre();

                        BigDecimal prix = prixVolRepository.findPrixByAvionVolIdAndTypePlace(
                                        avionVol.getId(), typePlace);

                        Map<String, Object> details = new HashMap<>();
                        details.put("nombrePlaces", nombrePlaces);
                        details.put("prix", prix != null ? prix : BigDecimal.ZERO);
                        details.put("valeurPartielle", prix != null ? prix.multiply(BigDecimal.valueOf(nombrePlaces))
                                        : BigDecimal.ZERO);

                        detailsParType.put(typePlace, details);

                        if (prix != null) {
                                valeurTotale = valeurTotale.add(
                                                prix.multiply(BigDecimal.valueOf(nombrePlaces)));
                        }
                }

                rapport.put("avion", avionVol.getAvion().getNom() + " (" +
                                avionVol.getAvion().getModele() + ")");
                rapport.put("trajet", avionVol.getVol().getAeroportDepart().getVille() +
                                " → " + avionVol.getVol().getAeroportArrivee().getVille());
                rapport.put("dateHeure", avionVol.getDateHeureFormatted());
                rapport.put("detailsParType", detailsParType);
                rapport.put("valeurTotale", valeurTotale);
                rapport.put("valeurTotaleFormatted", String.format("%,.2f Ar", valeurTotale));

                return rapport;
        }

        /**
         * Exemple spécifique: Tana → Nosy Be
         */
        public Map<String, Object> calculerExempleTanaNosyBe() {
                Map<String, Object> resultat = new HashMap<>();

                // Données d'exemple
                Map<String, BigDecimal> prixParType = new HashMap<>();
                prixParType.put("Première", new BigDecimal("1200000"));
                prixParType.put("Économique", new BigDecimal("700000"));

                // Exemple avec un avion ayant 10 places première et 150 places économique
                Map<String, Integer> placesParType = new HashMap<>();
                placesParType.put("Première", 10);
                placesParType.put("Économique", 150);

                // Calcul
                BigDecimal valeurTotale = BigDecimal.ZERO;
                Map<String, BigDecimal> valeursParType = new HashMap<>();

                for (Map.Entry<String, Integer> entry : placesParType.entrySet()) {
                        String type = entry.getKey();
                        Integer nombre = entry.getValue();
                        BigDecimal prix = prixParType.get(type);

                        BigDecimal valeur = prix.multiply(BigDecimal.valueOf(nombre));
                        valeursParType.put(type, valeur);
                        valeurTotale = valeurTotale.add(valeur);
                }

                resultat.put("trajet", "Antananarivo → Nosy Be");
                resultat.put("prixParType", prixParType);
                resultat.put("placesParType", placesParType);
                resultat.put("valeursParType", valeursParType);
                resultat.put("valeurTotale", valeurTotale);
                resultat.put("valeurTotaleFormatted", String.format("%,.2f Ar", valeurTotale));

                return resultat;
        }
}