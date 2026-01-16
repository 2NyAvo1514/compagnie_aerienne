package com.airline.manage.model;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "avion_vol")
public class AvionVol {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "avion_id", nullable = false)
    private Avion avion;

    @ManyToOne
    @JoinColumn(name = "vol_id", nullable = false)
    private Vol vol;

    @Column(name = "date_heure", nullable = false)
    private LocalDateTime dateHeure;

    // Nouvelle relation avec les prix par type de place
    @OneToMany(mappedBy = "avionVol", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private Set<PrixVol> prixVols = new HashSet<>();

    // Constructeurs
    public AvionVol() {
    }

    public AvionVol(Avion avion, Vol vol, LocalDateTime dateHeure) {
        this.avion = avion;
        this.vol = vol;
        this.dateHeure = dateHeure;
    }

    // Getters et Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Avion getAvion() {
        return avion;
    }

    public void setAvion(Avion avion) {
        this.avion = avion;
    }

    public Vol getVol() {
        return vol;
    }

    public void setVol(Vol vol) {
        this.vol = vol;
    }

    public LocalDateTime getDateHeure() {
        return dateHeure;
    }

    public void setDateHeure(LocalDateTime dateHeure) {
        this.dateHeure = dateHeure;
    }

    public Set<PrixVol> getPrixVols() {
        return prixVols;
    }

    public void setPrixVols(Set<PrixVol> prixVols) {
        this.prixVols = prixVols;
    }

    // Méthode pour formater la date
    public String getDateHeureFormatted() {
        if (dateHeure == null)
            return "";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return dateHeure.format(formatter);
    }

    // Méthode pour savoir si le vol est passé
    public boolean isPasse() {
        if (dateHeure == null)
            return false;
        return dateHeure.isBefore(LocalDateTime.now());
    }

    // Méthode pour formater la date pour les inputs HTML
    public String getDateHeureForInput() {
        if (dateHeure == null)
            return "";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return dateHeure.format(formatter);
    }

    // Méthode pour formater l'heure pour les inputs HTML
    public String getHeureForInput() {
        if (dateHeure == null)
            return "";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
        return dateHeure.format(formatter);
    }

    // MÉTHODE DEMANDÉE : Récupérer le prix pour un type de place spécifique
    public BigDecimal getPrixParTypePlace(String typePlace) {
        if (prixVols == null || prixVols.isEmpty()) {
            return null;
        }

        // Parcourir tous les prix définis pour ce vol
        for (PrixVol prixVol : prixVols) {
            if (prixVol.getPlace() != null &&
                    prixVol.getPlace().getType().equalsIgnoreCase(typePlace)) {
                return prixVol.getPrix();
            }
        }

        // Si aucun prix trouvé pour ce type de place
        return null;
    }

    // Méthode pour obtenir le prix formaté
    public String getPrixFormattedParTypePlace(String typePlace) {
        BigDecimal prix = getPrixParTypePlace(typePlace);
        return prix != null ? String.format("%,.2f Ar", prix) : "Non défini";
    }

    // Méthode pour obtenir tous les prix par type de place
    public String getTousLesPrixFormatted() {
        if (prixVols == null || prixVols.isEmpty()) {
            return "Aucun prix défini";
        }

        StringBuilder sb = new StringBuilder();
        for (PrixVol prixVol : prixVols) {
            if (prixVol.getPlace() != null) {
                sb.append(prixVol.getPlace().getType())
                        .append(": ")
                        .append(String.format("%,.2f Ar", prixVol.getPrix()))
                        .append("\n");
            }
        }
        return sb.toString();
    }

    // Méthode pour calculer la valeur maximale de ce vol (basée sur les prix et
    // places)
    public BigDecimal getValeurMaximale() {
        if (avion == null || prixVols == null || prixVols.isEmpty()) {
            return BigDecimal.ZERO;
        }

        BigDecimal valeurTotale = BigDecimal.ZERO;

        // Parcourir toutes les places de l'avion
        for (AvionPlace avionPlace : avion.getAvionPlaces()) {
            if (avionPlace.getPlace() != null) {
                // Trouver le prix pour ce type de place
                BigDecimal prix = getPrixParTypePlace(avionPlace.getPlace().getType());
                if (prix != null && avionPlace.getNombre() != null) {
                    BigDecimal valeurPourType = prix.multiply(BigDecimal.valueOf(avionPlace.getNombre()));
                    valeurTotale = valeurTotale.add(valeurPourType);
                }
            }
        }

        return valeurTotale;
    }

    // Méthode pour formater la valeur maximale
    public String getValeurMaximaleFormatted() {
        BigDecimal valeur = getValeurMaximale();
        return String.format("%,.2f Ar", valeur);
    }

    // Méthode pour obtenir un rapport détaillé de la valeur maximale
    public String getRapportValeurMaximale() {
        if (avion == null) {
            return "Avion non défini";
        }

        StringBuilder rapport = new StringBuilder();
        rapport.append("Valeur maximale pour le vol ")
                .append(vol != null ? vol.getId() : "N/A")
                .append(" (")
                .append(getDateHeureFormatted())
                .append(")\n\n");

        BigDecimal valeurTotale = BigDecimal.ZERO;
        boolean aDesPlaces = false;

        // Parcourir toutes les places de l'avion
        for (AvionPlace avionPlace : avion.getAvionPlaces()) {
            if (avionPlace.getPlace() != null) {
                aDesPlaces = true;
                String typePlace = avionPlace.getPlace().getType();
                Integer nombrePlaces = avionPlace.getNombre();
                BigDecimal prix = getPrixParTypePlace(typePlace);

                rapport.append(typePlace)
                        .append(": ")
                        .append(nombrePlaces)
                        .append(" places");

                if (prix != null) {
                    BigDecimal valeurPourType = prix.multiply(BigDecimal.valueOf(nombrePlaces));
                    rapport.append(" × ")
                            .append(String.format("%,.2f Ar", prix))
                            .append(" = ")
                            .append(String.format("%,.2f Ar", valeurPourType));
                    valeurTotale = valeurTotale.add(valeurPourType);
                } else {
                    rapport.append(" (prix non défini)");
                }

                rapport.append("\n");
            }
        }

        if (!aDesPlaces) {
            rapport.append("Aucune configuration de places définie pour cet avion\n");
        }

        rapport.append("\nVALEUR MAXIMALE TOTALE: ")
                .append(String.format("%,.2f Ar", valeurTotale));

        return rapport.toString();
    }

    // Méthode pour vérifier si un type de place a un prix défini
    public boolean aPrixPourTypePlace(String typePlace) {
        return getPrixParTypePlace(typePlace) != null;
    }

    // Méthode pour ajouter un prix pour un type de place
    public void ajouterPrixPourTypePlace(Place place, BigDecimal prix) {
        if (place == null || prix == null) {
            return;
        }

        // Vérifier si un prix existe déjà pour ce type de place
        for (PrixVol prixVol : prixVols) {
            if (prixVol.getPlace() != null && prixVol.getPlace().equals(place)) {
                prixVol.setPrix(prix);
                return;
            }
        }

        // Créer un nouveau PrixVol
        PrixVol nouveauPrix = new PrixVol(this, place, prix);
        prixVols.add(nouveauPrix);
    }

    @Override
    public String toString() {
        return "AvionVol{" +
                "id=" + id +
                ", avion=" + (avion != null ? avion.getNom() : "null") +
                ", vol=" + (vol != null ? vol.getId() : "null") +
                ", dateHeure=" + getDateHeureFormatted() +
                '}';
    }
}