package com.airline.manage.model;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "prix_vol")
public class PrixVol {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_avion_vol", nullable = false)
    private AvionVol avionVol;

    @ManyToOne
    @JoinColumn(name = "id_place", nullable = false)
    private Place place;

    @Column(name = "prix", nullable = false, precision = 12, scale = 2)
    private BigDecimal prix;

    // Constructeurs
    public PrixVol() {
    }

    public PrixVol(AvionVol avionVol, Place place, BigDecimal prix) {
        this.avionVol = avionVol;
        this.place = place;
        this.prix = prix;
    }

    // Getters et Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public AvionVol getAvionVol() {
        return avionVol;
    }

    public void setAvionVol(AvionVol avionVol) {
        this.avionVol = avionVol;
    }

    public Place getPlace() {
        return place;
    }

    public void setPlace(Place place) {
        this.place = place;
    }

    public BigDecimal getPrix() {
        return prix;
    }

    public void setPrix(BigDecimal prix) {
        this.prix = prix;
    }

    // Méthode utilitaire pour formater le prix
    public String getPrixFormatted() {
        return String.format("%,.2f Ar", prix);
    }
}