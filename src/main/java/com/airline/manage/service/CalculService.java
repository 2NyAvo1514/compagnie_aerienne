package com.airline.manage.service;

import com.airline.manage.model.*;
import com.airline.manage.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;

@Service
public class CalculService {

    @Autowired
    private AvionRepository avionRepository;

    @Autowired
    private AvionVolRepository avionVolRepository;

    @Autowired
    private VolRepository volRepository;

    @Autowired
    private AvionPlaceRepository avionPlaceRepository;

    @Autowired
    private PrixVolRepository prixVolRepository;

    @Autowired
    private PlaceRepository placeRepository;

    @Autowired
    private ValeurMaximaleService valeurMaximaleService;

    /**
     * Récupère tous les avions avec leurs configurations de places
     */
    public List<Avion> getAllAvionsWithPlaces() {
        List<Avion> avions = avionRepository.findAll();
        // Charger les places pour chaque avion
        for (Avion avion : avions) {
            List<AvionPlace> avionPlaces = avionPlaceRepository.findByAvionId(Math.toIntExact(avion.getId()));
            avion.setAvionPlaces(new HashSet<>(avionPlaces));
        }
        return avions;
    }

    /**
     * Récupère tous les vols avec leurs prix
     */
    public List<Vol> getAllVolsWithPrices() {
        List<Vol> vols = volRepository.findAll();
        // Note: Les prix sont liés à AvionVol, pas directement à Vol
        // Vous devrez peut-être adapter cette méthode
        return vols;
    }

    /**
     * Récupère tous les AvionVol avec leurs prix
     */
    public List<AvionVol> getAllAvionVolsWithPrices() {
        return avionVolRepository.findAllWithPrices();
    }

    /**
     * Calcule la valeur maximale pour une configuration spécifique
     */
    public Map<String, Object> calculerValeurMaximale(
            Long avionId, Integer avionVolId,
            Map<String, BigDecimal> prixParType,
            boolean inclureFrais, boolean inclureTaxes) {

        Map<String, Object> resultats = new HashMap<>();

        // Récupérer l'avion avec ses places
        Avion avion = avionRepository.findById(avionId)
                .orElseThrow(() -> new RuntimeException("Avion non trouvé avec l'ID: " + avionId));

        // Charger les places de l'avion
        List<AvionPlace> avionPlaces = avionPlaceRepository.findByAvionId(Math.toIntExact(avionId));
        avion.setAvionPlaces(new HashSet<>(avionPlaces));

        // Récupérer l'AvionVol s'il est spécifié
        AvionVol avionVol = null;
        if (avionVolId != null) {
            avionVol = avionVolRepository.findById(avionVolId)
                    .orElseThrow(() -> new RuntimeException("AvionVol non trouvé avec l'ID: " + avionVolId));
        }

        // Si un AvionVol est sélectionné, utiliser ses prix
        if (avionVol != null) {
            prixParType = new HashMap<>();
            List<PrixVol> prixVols = prixVolRepository.findByAvionVolId(avionVolId);

            for (PrixVol prixVol : prixVols) {
                prixParType.put(prixVol.getPlace().getType(), prixVol.getPrix());
            }
        }

        // Calculer la valeur
        BigDecimal valeurBase = BigDecimal.ZERO;
        Map<String, Object> detailsCalcul = new HashMap<>();
        Map<String, BigDecimal> valeursParType = new HashMap<>();
        Map<String, Integer> placesParType = new HashMap<>();

        // Calculer pour chaque type de place de l'avion
        for (AvionPlace avionPlace : avion.getAvionPlaces()) {
            String typePlace = avionPlace.getPlace().getType();
            Integer nombrePlaces = avionPlace.getNombre();
            BigDecimal prixUnitaire = prixParType.getOrDefault(typePlace, BigDecimal.ZERO);

            if (prixUnitaire.compareTo(BigDecimal.ZERO) > 0) {
                BigDecimal valeurPartielle = prixUnitaire.multiply(BigDecimal.valueOf(nombrePlaces));
                valeurBase = valeurBase.add(valeurPartielle);

                // Stocker les détails
                Map<String, Object> detailType = new HashMap<>();
                detailType.put("nombre", nombrePlaces);
                detailType.put("prixUnitaire", prixUnitaire);
                detailType.put("valeurPartielle", valeurPartielle);
                detailType.put("pourcentage", BigDecimal.ZERO);

                detailsCalcul.put(typePlace, detailType);
                valeursParType.put(typePlace, valeurPartielle);
            }

            placesParType.put(typePlace, nombrePlaces);
        }

        // Calculer les pourcentages
        if (valeurBase.compareTo(BigDecimal.ZERO) > 0) {
            for (Map.Entry<String, Object> entry : detailsCalcul.entrySet()) {
                @SuppressWarnings("unchecked")
                Map<String, Object> detail = (Map<String, Object>) entry.getValue();
                BigDecimal valeurPartielle = (BigDecimal) detail.get("valeurPartielle");
                BigDecimal pourcentage = valeurPartielle
                        .multiply(BigDecimal.valueOf(100))
                        .divide(valeurBase, 2, RoundingMode.HALF_UP);
                detail.put("pourcentage", pourcentage);
            }
        }

        // Calculer les frais et taxes
        BigDecimal fraisService = BigDecimal.ZERO;
        BigDecimal taxesAeroport = BigDecimal.ZERO;
        BigDecimal totalGeneral = valeurBase;

        if (inclureFrais) {
            fraisService = valeurBase.multiply(new BigDecimal("0.10"))
                    .setScale(0, RoundingMode.HALF_UP);
            totalGeneral = totalGeneral.add(fraisService);
        }

        if (inclureTaxes) {
            taxesAeroport = valeurBase.multiply(new BigDecimal("0.05"))
                    .setScale(0, RoundingMode.HALF_UP);
            totalGeneral = totalGeneral.add(taxesAeroport);
        }

        // Préparer les résultats
        resultats.put("avion", avion);
        resultats.put("avionVol", avionVol);
        resultats.put("valeurBase", valeurBase);
        resultats.put("fraisService", fraisService);
        resultats.put("taxesAeroport", taxesAeroport);
        resultats.put("totalGeneral", totalGeneral);
        resultats.put("valeurMaximale", totalGeneral);
        resultats.put("detailsCalcul", detailsCalcul);
        resultats.put("valeursParType", valeursParType);
        resultats.put("placesParType", placesParType);
        resultats.put("prixUtilises", prixParType);
        resultats.put("inclureFrais", inclureFrais);
        resultats.put("inclureTaxes", inclureTaxes);

        // Ajouter des métadonnées
        if (avionVol != null) {
            resultats.put("vol", avionVol.getVol());
            resultats.put("dateHeure", avionVol.getDateHeure());
        }

        return resultats;
    }

    /**
     * Méthode pour formater les montants
     */
    public String formatMontant(BigDecimal montant) {
        if (montant == null)
            return "0 Ar";
        return String.format("%,d Ar", montant.setScale(0, RoundingMode.HALF_UP));
    }

    /**
     * Calcule la valeur pour différentes options de configuration
     */
    public Map<String, Object> comparerConfigurations(
            Long avionId,
            List<Map<String, BigDecimal>> configurationsPrix) {

        Map<String, Object> comparaison = new HashMap<>();
        List<Map<String, Object>> resultatsConfigs = new ArrayList<>();

        for (int i = 0; i < configurationsPrix.size(); i++) {
            Map<String, BigDecimal> prixParType = configurationsPrix.get(i);
            Map<String, Object> resultat = calculerValeurMaximale(
                    avionId, null, prixParType, true, true);

            resultat.put("configurationIndex", i + 1);
            resultat.put("description", "Configuration " + (i + 1));
            resultatsConfigs.add(resultat);
        }

        // Trouver la configuration optimale
        Map<String, Object> configOptimale = Collections.max(resultatsConfigs,
                Comparator.comparing(c -> (BigDecimal) c.get("valeurMaximale")));

        comparaison.put("configurations", resultatsConfigs);
        comparaison.put("configOptimale", configOptimale);
        comparaison.put("nombreConfigurations", configurationsPrix.size());

        return comparaison;
    }

    /**
     * Simule différentes stratégies de prix
     */
    public Map<String, Object> simulerStrategiesPrix(
            Long avionId, BigDecimal prixBase,
            Map<String, Double> multiplicateurs) {

        Map<String, Object> resultats = new HashMap<>();
        List<Map<String, Object>> strategies = new ArrayList<>();

        // Stratégies possibles
        String[] nomsStrategies = { "Économique", "Standard", "Premium", "Luxe" };

        for (String strategie : nomsStrategies) {
            Map<String, BigDecimal> prixParType = new HashMap<>();

            // Appliquer différents multiplicateurs selon le type de place
            for (Map.Entry<String, Double> entry : multiplicateurs.entrySet()) {
                String typePlace = entry.getKey();
                Double multiplicateur = entry.getValue();

                BigDecimal prix = prixBase.multiply(BigDecimal.valueOf(multiplicateur))
                        .setScale(0, RoundingMode.HALF_UP);
                prixParType.put(typePlace, prix);
            }

            Map<String, Object> resultat = calculerValeurMaximale(
                    avionId, null, prixParType, true, true);

            resultat.put("strategie", strategie);
            resultat.put("multiplicateurs", multiplicateurs);
            strategies.add(resultat);
        }

        resultats.put("strategies", strategies);
        resultats.put("prixBase", prixBase);

        return resultats;
    }
}