package com.airline.manage.model;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

import jakarta.persistence.*;

@Entity
@Table(name = "avion")
public class Avion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "nom", nullable = false, length = 100)
    private String nom;

    @Column(name = "modele", nullable = false, length = 100)
    private String modele;

    @Column(name = "capacite", nullable = false)
    private Integer capacite;

        @OneToMany(mappedBy = "avion", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<AvionPlace> avionPlaces = new HashSet<>();
    // Constructeurs
    public Avion() {
    }

    public Avion(String nom, String modele, Integer capacite) {
        this.nom = nom;
        this.modele = modele;
        this.capacite = capacite;
    }

    // Getters et Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getModele() {
        return modele;
    }

    public void setModele(String modele) {
        this.modele = modele;
    }

    public Integer getCapacite() {
        return capacite;
    }

    public void setCapacite(Integer capacite) {
        this.capacite = capacite;
    }
     public Set<AvionPlace> getAvionPlaces() {
        return avionPlaces;
    }
    
    public void setAvionPlaces(Set<AvionPlace> avionPlaces) {
        this.avionPlaces = avionPlaces;
    }
    
    // Méthode pour obtenir la capacité totale (somme de toutes les places)
    public Integer getCapaciteTotale() {
        return avionPlaces.stream()
                .map(AvionPlace::getNombre)
                .reduce(0, Integer::sum);
    }
    
    // Méthode pour obtenir le nombre de places d'un type spécifique
    public Integer getNombrePlacesParType(String typePlace) {
        return avionPlaces.stream()
                .filter(ap -> ap.getPlace() != null && ap.getPlace().getType().equalsIgnoreCase(typePlace))
                .map(AvionPlace::getNombre)
                .findFirst()
                .orElse(0);
    }
    
    // Méthode pour calculer la valeur maximale pour un vol donné
    public BigDecimal getValeurMaximalePourVol(AvionVol avionVol) {
        BigDecimal valeurTotale = BigDecimal.ZERO;
        
        for (AvionPlace avionPlace : avionPlaces) {
            // Trouver le prix pour cette place sur ce vol
            BigDecimal prix = avionVol.getPrixParTypePlace(avionPlace.getPlace().getType());
            if (prix != null) {
                valeurTotale = valeurTotale.add(
                    prix.multiply(BigDecimal.valueOf(avionPlace.getNombre()))
                );
            }
        }
        
        return valeurTotale;
    }
}